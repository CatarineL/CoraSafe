import ast
from datetime import datetime
import json
from typing import Optional
from PIL import Image
from fastapi import Depends, FastAPI, Form, HTTPException, UploadFile
import numpy as np
import cv2
from pydantic import BaseModel
import pytesseract as pyt
import re
from sqlalchemy import Boolean, DateTime, Integer, create_engine, Column, String
# plotagem das imagens geradas - apenas a função da biblioteca foi usada aqui
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from matplotlib import pyplot as plt
from sqlalchemy import null
import os
from google import genai
from google.genai.errors import ServerError
from ultralytics import YOLO
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotaProduto = APIRouter()

modelo = YOLO('C:/Users/catar/runs/detect/train-5/weights/best.pt')
os.environ["GEMINI_API_KEY"] = "AQ.Ab8RN6KgewIL9JhCO72Ft_3l3sEIAvmKbQi9AfhU65KXRrCuOQ"  #"AQ.Ab8RN6JLwk-pHcrI77V18NjlVX08HGgOqS6Aiihj86_aZez-RA"

# Inicialize o cliente
client = genai.Client()
#SessionLocal = sessionmaker(bind=engine)

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

Base_Produto = declarative_base()


#model (tabela) de Produto
class Produto(Base_Produto):
    __tablename__ = "produto"

    idProduto = Column("idproduto", Integer, primary_key=True)
    idUsuario_fk = Column("idusuario_fk", Integer)
    idISFL_fk = Column("idisfl_fk", Integer)
    nomeProduto = Column("nomeproduto", String)
    validadeProduto = Column("validadeproduto", String)
    statusProduto = Column("statusproduto", Boolean)
    dataConsumo = Column("dataconsumo", DateTime)

    
class ProdutoSchemaUserComum(BaseModel):
    idUsuario_fk: int
    nomeProduto: Optional[str] = None 
    validadeProduto: Optional[str] = None  
    statusProduto: Optional[bool] = None
    dataConsumo: Optional[datetime] = None #type: ignore
    
class ProdutoSchemaUserComumAtualiza(BaseModel):
    nomeProduto: Optional[str] = None 
    validadeProduto: Optional[str] = None
    statusProduto: Optional[bool] = None
    dataConsumo: Optional[datetime] = None #type: ignore
    
class ProdutoSchemaISFL(BaseModel): 
    idISFL_fk: int
    nomeProduto: Optional[str] = None 
    validadeProduto: Optional[str] = None 
    statusProduto: Optional[bool] = None
    dataConsumo: Optional[datetime] = None #type: ignore

Base_Produto.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


#***********METODOS PARA OS ITENS DA NOTA FISCAL*************
#função que recebe a imagem da nota fiscal do APP e faz a extração de texto
@rotaProduto.post("/selecao_imagem")
async def recebendoImagem(imagem: UploadFile) -> list: #img: UploadFile/imagemRecebida
   
    #converte o buffer do OpenCV em bytes puros do Python
    bytes_imagem = await imagem.read()
    
    imagem_array = np.frombuffer(bytes_imagem, dtype=np.uint8)
    print("buffer convertido")
    
    imagem = cv2.imdecode(imagem_array, cv2.IMREAD_GRAYSCALE)
    
    if imagem is None:
            print("Não foi possível ler o arquivo")
        
    res_img = modelo.predict(source=imagem, conf=0.25, iou=0.7, imgsz=640, show=False, save=False, save_txt=False, save_conf=False, save_crop=True, stream=False)

    xyxy = res_img[0].boxes.xyxy.cpu().numpy()
    
    if len(xyxy) == 0:
        print("Nenhuma região encontrada")
    
    #pega a primeira caixa detectada
    x1, y1, x2, y2 = xyxy[0]

    #converte para inteiro
    x1, y1, x2, y2 = map(int, [x1, y1, x2, y2])

    #recorta a IMAGEM ORIGINAL
    img_cortada = imagem[y1:y2, x1:x2]
    
    media = np.mean(img_cortada)
            
    #Calcula a variância global
    variancia_global = np.var(img_cortada)

    #Calcula o desvio padrão
    desvioPadrao = np.std(img_cortada)

    #lista vazia para rebecer a lista de itens encontrados na imagem
    listaItens = []
    listaOCR = []
    lista_final = []

    print(desvioPadrao, variancia_global, media)
    
    #condições
    #baixo contraste - intervalo de desvio padrão com base no dataset, desvio padrão minimo: 17,73 e variancia minima: 314,43
    #medio contraste - intervalo de desvio padrão: 34,31 e variancia: 1177,41
    #alto contraste - intervalo de desvio padrão com base no dataset, desvio padrão maximo: 58,48 e variancia maxima: 3419,41

    #imagem de baixo até medio contraste
    if (desvioPadrao<45):#(desvioPadrao>1 and desvioPadrao<35) and (variancia_global>1 and variancia_global<1177): #imagem de baixo a medio contraste
        
        clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(10, 10))

        imagem_clahe = clahe.apply(img_cortada)
        print("clahe aplicado e imagem chegou aqui")
      
        text = pyt.image_to_string(imagem_clahe, lang="por", config="--psm 11") #textto extraido da imagem
        padrao = r'(\d+)\s([A-ZÀ-ÿ\s]+)' #expressão regular
        resultado = re.findall(padrao, text) #o texto que tiver o padrão é salvo na lista
        palavrasChaves = ['\nGT TOTAL DE TTENS\nVALOR TOTAL ', 'IBWÁSUO ','\nCNPJ ', 'LOJASO', 'POVAGIK ', 'RIRIGUI', 'VALOR ', 'VALOR A PAGAR R',  'VALOR TOTAL R', 'VALOR À PAGAR R', 'FORNMA DE PAGAMENTO VALOR PRGO\nD','FORMA DE PAGANMENTO VALOR PRGO\nD', '\nCONSUMIDOR NW', 'FORNA DE PAGAMENTO VALOR PAGO\nD', '\nIDENTIFICADO', 'VALUR FOTAL R', 'VALOR R PAGAR RS ', '\nGT TOTAL DE T D']
        if resultado:
            for item in resultado:
                if len(item[1])>5 and not (item[1] in palavrasChaves):#verificando o segundo grupo da expressão regular para saber se o tamanho da string é menor que 5 carac. e se ela não esta contida na lista de palavras
                    listaItens.append(item[1])
                   
        listaOCR = listaItens
        
        try: 
            """
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=f"Quero que vc retorne essa lista {listaOCR} em outra lista, mas com cada item escrito da maneira correta. Formato de saida: ['item 1', 'item 2', ...]. Sem frase introdutoria",
            )
            # print(f"{response.text}\n")
            texto_limpo = response.text.replace("```python", "").replace("```json", "").replace("Aqui está a lista corrigida:", "").replace("```", "")
            # l = listaItens #json.loads(listaItens)
            lista_final = ast.literal_eval(texto_limpo)
            """
            if listaOCR is None: #lista_final
                return "lista vazia"
                #raise HTTPException(status_code=503, detail="Serviço de IA indisponível, tente novamente")
            else:
                return listaOCR  #lista_final
            
        except (ServerError, Exception) as e:
            print(f"Erro ao chamar Gemini: {e}")
            raise HTTPException(status_code=503, detail="Não foi possível processar a imagem no momento") 
        

    elif (desvioPadrao>=45):#(desvioPadrao>35 and variancia_global>1117):#imagens de medio a alto contraste
        
        #medio contraste - intervalo de desvio padrão: 34,31 e variancia: 1177,41
        #alto contraste - intervalo de desvio padrão com base no dataset, desvio padrão maximo: 58,48 e variancia maxima: 3419,41
        
        print("limiar binário aplicado e imagem chegou aqui")
        
        ret, thresh1 = cv2.threshold(img_cortada,
            0,
            255,
            cv2.THRESH_OTSU)
        
        
        text = pyt.image_to_string(thresh1, lang="por") #textto extraido da imagem
        padrao = r'(\d+)\s([A-ZÀ-ÿ\s]+)' #expressão regular
        resultado = re.findall(padrao, text) #o texto que tiver o padrão é salvo na lista
        palavrasChaves = ['\nGT TOTAL DE TTENS\nVALOR TOTAL ', 'IBWÁSUO ','\nCNPJ ', 'LOJASO', 'POVAGIK ', 'RIRIGUI', 'VALOR ', 'VALOR A PAGAR R',  'VALOR TOTAL R', 'VALOR À PAGAR R', 'FORNMA DE PAGAMENTO VALOR PRGO\nD','FORMA DE PAGANMENTO VALOR PRGO\nD', '\nCONSUMIDOR NW', 'FORNA DE PAGAMENTO VALOR PAGO\nD', '\nIDENTIFICADO', 'VALUR FOTAL R', 'VALOR R PAGAR RS ', '\nGT TOTAL DE T D']
        if resultado:
            for item in resultado:
                if len(item[1])>5 and not (item[1] in palavrasChaves):
                    listaItens.append(item[1])
                   
        listaOCR = listaItens
    
        try: 
            """response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=f"Quero que vc retorne essa lista {listaOCR} em outra lista, mas com cada item escrito da maneira correta. Sem frase introdutoria",
            )
            # print(f"{response.text}\n")
            texto_limpo = response.text.replace("```python", "").replace("```json", "").replace("Aqui está a lista corrigida:", "").replace("```", "")
            # l = listaItens #json.loads(listaItens)
            lista_final = ast.literal_eval(texto_limpo)
            """
            if listaOCR is None:
                raise HTTPException(status_code=503, detail="Serviço de IA indisponível, tente novamente")
            else:
                return listaOCR
            
        except (ServerError, Exception) as e:
            print(f"Erro ao chamar Gemini: {e}")
            raise HTTPException(status_code=503, detail="Não foi possível processar a imagem no momento")
    
    #medio contraste - intervalo de desvio padrão: 34,31 e variancia: 1177,41
    #alto contraste - intervalo de desvio padrão com base no dataset, desvio padrão maximo: 58,48 e variancia maxima: 3419,41
    
           

#metodo de recebimento, tratamento e extração de texto em imagem
@rotaProduto.post("/produtos_identificados")
async def tranformandoListaProdutos_Json(imagem: UploadFile):
    

    resultado = []
    l = await recebendoImagem(imagem)
   
    for item in l:
        itensJson = {"idProduto": None, "idUsuario_fk": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None,  "statusProduto": None, "dataConsumo": None}
    
        resultado.append(itensJson)
    
    return resultado


#metodo de criar produtos - lista de itens
@rotaProduto.post("/criar_produto")
async def criar_produto(imagem: UploadFile,  idUsuario_fk: int = Form(...), db: Session = Depends(get_db)):#"idProduto": None, "idUsuarioFK": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None
    
    produtos = await tranformandoListaProdutos_Json(imagem)
   
    
    if produtos:
        for produto in produtos:
            novo_produto = Produto(
                
                idUsuario_fk = idUsuario_fk, 
                idISFL_fk = produto["idISFL_fk"],
                nomeProduto = produto["nomeProduto"],
                validadeProduto = produto["dataValidade"],
                statusProduto = produto["statusProduto"],
                dataConsumo = produto["dataConsumo"]

            )
        
            db.add(novo_produto)
        db.commit()
        return True
    else:
        print("lista de produtos vazia")
        return False
    
    
@rotaProduto.post("/criar_produtoISFL")
async def criar_produtoISFL(imagem: UploadFile,  idISFL_fk: int = Form(...), db: Session = Depends(get_db)):#"idProduto": None, "idUsuarioFK": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None
    
    produtos = await tranformandoListaProdutos_Json(imagem)
   
    if produtos:
        for produto in produtos:
            novo_produto = Produto(
                idUsuario_fk = produto["idUsuario_fk"], 
                idISFL_fk = idISFL_fk,
                nomeProduto= produto["nomeProduto"],
                validadeProduto= produto["dataValidade"],
                statusProduto =produto["statusProduto"],
                dataConsumo = produto["dataConsumo"]
            )
        
            db.add(novo_produto)
        db.commit()
        return True
    else:
        print("lista de produtos vazia")
        return False
    


@rotaProduto.post("/visualizandoProdutos")
def lendoItens(produto: ProdutoSchemaUserComum, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        resultado = consulta.filter(Produto.idUsuario_fk == produto.idUsuario_fk).all()
        
        if resultado:
            return [
                {
                    "idProduto": p.idProduto,
                    "nomeProduto": p.nomeProduto,
                    "validadeProduto": p.validadeProduto,
                    "statusProduto": p.statusProduto,
                    "dataConsumo": p.dataConsumo
                }
                for p in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')
        
@rotaProduto.post("/visualizandoProdutosISFL")
def lendoItensISFL(produto: ProdutoSchemaISFL, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        resultado = consulta.filter(Produto.idISFL_fk == produto.idISFL_fk).all()
        
        if resultado:
            return [
                {
                    "idProduto": p.idProduto,
                    "nomeProduto": p.nomeProduto,
                    "validadeProduto": p.validadeProduto,
                    "statusProduto": p.statusProduto,
                    "dataConsumo": p.dataConsumo
                    
                }
                for p in resultado
            ]
           
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')

#metodo de editar - lista de itens
#o metodo ira receber o id do produto selecionado e por meio do id selecionado 
# a alteração do nome e a inclusão da validade no banco será alterada
@rotaProduto.put("/atualizando_produtos/{idproduto}")
def atualizando_produtos(idproduto:  int, dados_novos: ProdutoSchemaUserComumAtualiza, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Produto)
        produto = consulta.filter(Produto.idProduto == idproduto).first()
        
        if produto:
                produto.nomeProduto = dados_novos.nomeProduto
                produto.validadeProduto= dados_novos.validadeProduto
                produto.statusProduto = dados_novos.statusProduto
                produto.dataConsumo = dados_novos.dataConsumo
                
        db.commit() 
        return {"mensagem": "Produto atualizado"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar excluir o produto: {e}')



#metodo de delete - lista de itens
@rotaProduto.delete("/excluindoProdutos/{idproduto}")
def excluindo_produtos(idproduto:  int, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        produto = consulta.filter(Produto.idProduto == idproduto).first()
        
        if produto:
            
            db.delete(produto)    
            db.commit()  
            return {"mensgaem": "Produto excluído"}     
        else:
            raise HTTPException(
                status_code=404,
                detail="Produto não encontrado"
            )
    except Exception as e:
        print(f'Erro ao tentar excluir o produto: {e}')
        

#**********METODOS PARA PRODUTOS FRACIONADOS**********

#metodo de adicionar produto fracionado
#função que recebe a imagem de um item fracionado e faz a extração de texto
@rotaProduto.post("/selecao_imagemFracionado")
async def recebendoImagemFracionado(imagem: UploadFile): #img: UploadFile/imagemRecebida
   
    listaItens = []
    listaOCR = []
    lista_final = []
    bytes_imagem = await imagem.read()
       
    imagem_array = np.frombuffer(bytes_imagem, dtype=np.uint8)
    
    imagem = cv2.imdecode(imagem_array, cv2.IMREAD_GRAYSCALE)
    
    text = pyt.image_to_string(imagem, lang="por")

    padraoItem = r'([A-ZÀ-ÿ0-9\s]+)'
    nome = re.findall(padraoItem, text)
    
    padraoValidade = r'VALIDADE[: ]*(\d{2}[/-]\d{2}[/-]\d{2})'
    validade = re.findall(padraoValidade, text)
    
    
    linhas = text.splitlines()

    for linha in linhas:
        linha = linha.strip()
        if linha:
            nome = linha
            break
        
    if nome and validade:
            nomeProduto = nome
            dataValidade = validade
                    
            listaItens.append((nomeProduto, dataValidade))

    else:
        print("Não foi possível identificar o item e sua validade")
            
    
    listaOCR = listaItens

    try: 
        response = client.models.generate_content(
            model="gemini-2.5-flash",
            contents=f"Quero que vc retorne essa lista {listaOCR} em outra lista, mas que o primeiro item da lista esteja escrito de maneira correta. Formato de saida: ['item 1', 'item 2', ...]. Sem frase introdutoria",
        )
  
        texto_limpo = response.text.replace("```python", "").replace("```json", "").replace("Aqui está a lista corrigida:", "").replace("```", "")
       
        lista_final = ast.literal_eval(texto_limpo)
        
        if lista_final is None:
            raise HTTPException(status_code=503, detail="Serviço de IA indisponível, tente novamente")
        else:
            print(lista_final)
            return lista_final
        
        
    except (ServerError, Exception) as e:
        print(f"Erro ao chamar Gemini: {e}")
        raise HTTPException(status_code=503, detail="Não foi possível processar a imagem no momento") 
           
#metodo de recebimento, tratamento e extração de texto em imagem
@rotaProduto.post("/produto_identificadoFracionado")
async def tranformandoProdutoFracionado_Json(imagem: UploadFile):
    

    resultado = []
    l = await recebendoImagemFracionado(imagem)
   
    
    for item, dataValidade in l:
        itensJson = {"idProduto": None, "idUsuario_fk": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": dataValidade}
    
        resultado.append(itensJson)
    
    return resultado


#metodo de criar produtos - lista de itens
@rotaProduto.post("/criar_produtoFracionado")
async def criar_produto(imagem: UploadFile,  idUsuario_fk: int = Form(...), db: Session = Depends(get_db)):#"idProduto": None, "idUsuarioFK": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None
    
    produtos = await tranformandoProdutoFracionado_Json(imagem)
   
    for produto in produtos:
        novo_produto = Produto(
            
            idUsuario_fk = idUsuario_fk,
            idISFL_fk = produto["idISFL_fk"],
            nomeProduto= produto["nomeProduto"],
            validadeProduto= produto["dataValidade"],

        )
    
        db.add(novo_produto)
    db.commit()
    

    return {"mensagem": "Produto salvo"}


#metodo de visualizacao de itens que foi salvo no banco -> para o app
#metodo de login - leitura de dados no banco- user comum
@rotaProduto.post("/visualizandoProdutoFracionado")
def lendoItemFracionado(produto: ProdutoSchemaUserComum, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        resultado = consulta.filter(Produto.idUsuario_fk == produto.idUsuario_fk).all()
        
        if resultado:
            return [
                {
                    "idProduto": p.idProduto,
                    "nomeProduto": p.nomeProduto,
                    "validadeProduto": p.validadeProduto
                }
                for p in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')
        

#metodo de editar
#o metodo ira receber o id do produto selecionado e por meio do id selecionado 
# a alteração do nome e a inclusão da validade no banco será alterada
@rotaProduto.put("/atualizando_produtoFracionado/{idproduto}")
def atualizando_produtoFracionado(idproduto:  int, dados_novos: ProdutoSchemaUserComum, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        produto = consulta.filter(Produto.idProduto == idproduto).first()
        
        if produto:
                produto.nomeProduto = dados_novos.nomeProduto
                produto.validadeProduto= dados_novos.validadeProduto
                
        db.commit() 
        return {"mensagem": "Produto atualizado"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar excluir o produto: {e}')


#metodo de delete
@rotaProduto.delete("/excluindoProdutoFracionado/{idProduto}")
def excluindo_produtoFracionado(idproduto:  int, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Produto)
        produto = consulta.filter(Produto.idProduto == idproduto).first()
        
        if produto:
            
            db.delete(produto)    
            db.commit()  
            return {"mensgaem": "Produto excluído"}     
        else:
            raise HTTPException(
                status_code=404,
                detail="Produto não encontrado"
            )
    except Exception as e:
        print(f'Erro ao tentar excluir o produto: {e}')

  