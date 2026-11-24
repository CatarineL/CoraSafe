#adaptar para medicament
import ast
import json
from typing import Optional
from PIL import Image
from fastapi import Depends, FastAPI, Form, HTTPException, UploadFile
import numpy as np
import cv2
from pydantic import BaseModel
import pytesseract as pyt
import re
from sqlalchemy import Integer, create_engine, Column, String
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
rotaMedicamento = APIRouter()

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

#base de Usuario comum
Base_Medicamento = declarative_base()

#model (tabela) de Produto
class Medicamento(Base_Medicamento):
    __tablename__ = "medicamento"

    idMedicamento = Column("idmedicamento", Integer, primary_key=True)
    idUsuario_fk = Column("idusuario_fk", Integer)
    idISFL_fk = Column("idisfl_fk", Integer)
    nomeMedicamento = Column("nomemedicamento", String)
    validadeMedicamento = Column("validademedicamento", String)
    para = Column("para", String)
    horarioMedicamentoIntervalo = Column("horariomedicamentointervalo", Integer)
    

#schema (tabela) de Produto 
class MedicamentoSchema(BaseModel): 
    idUsuario_fk: None
    idISFL_fk: None
    nomeMedicamento: str 
    validadeMedicamento: None 
    para: Optional[str] = None
    horarioMedicamentoIntervalo: Optional[str] = None
    
#schema para produto dos usuarios
class MedicamentoSchemaUserComum(BaseModel):
    idUsuario_fk: int
    nomeMedicamento: Optional[str] = None 
    validadeMedicamento: Optional[str] = None
    para: Optional[str] = None
    horarioMedicamentoIntervalo: Optional[str] = None 
    
class MedicamentoSchemaISFL(BaseModel):
    idISFL_fk: int
    nomeMedicamento: Optional[str] = None 
    validadeMedicamento: Optional[str] = None
    para: Optional[str] = None
    horarioMedicamentoIntervalo: Optional[str] = None 
    
class MedicamentoSchemaUserComumAtualiza(BaseModel):
    nomeMedicamento: Optional[str] = None 
    validadeMedicamento: Optional[str] = None
    horarioMedicamentoIntervalo: Optional[str] = None

class MedicamentoSchemaISFLAtualiza(BaseModel):
    nomeMedicamento: Optional[str] = None 
    validadeMedicamento: Optional[str] = None
    para: Optional[str] = None
    horarioMedicamentoIntervalo: Optional[str] = None
    
Base_Medicamento.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
    
#função de extração de texto em imagem
@rotaMedicamento.post("/selecao_imagem")
async def recebendoImagem(imagem: UploadFile) -> list: #img: UploadFile/imagemRecebida
   #converte o buffer do OpenCV em bytes puros do Python
       bytes_imagem = await imagem.read()
       
       imagem_array = np.frombuffer(bytes_imagem, dtype=np.uint8)
       print("buffer convertido")
       
       imagem = cv2.imdecode(imagem_array, cv2.IMREAD_GRAYSCALE)
       
       
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

       
   
   
       #condições
       #baixo contraste - intervalo de desvio padrão com base no dataset, desvio padrão minimo: 17,73 e variancia minima: 314,43
       #medio contraste - intervalo de desvio padrão: 34,31 e variancia: 1177,41
       #alto contraste - intervalo de desvio padrão com base no dataset, desvio padrão maximo: 58,48 e variancia maxima: 3419,41
   
       #imagem de baixo até medio contraste
       if (desvioPadrao>1 and desvioPadrao<35) and (variancia_global>1 and variancia_global<1177): #imagem de baixo a medio contraste
           
           clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(10, 10))
   
           # # 3. Aplicar o CLAHE na imagem de entrada
           imagem_clahe = clahe.apply(img_cortada)
           print("clahe aplicado e imagem chegou aqui")
         
           text = pyt.image_to_string(imagem_clahe, lang="por") #textto extraido da imagem
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
               lista_final = ast.literal_eval(texto_limpo)"""
               
               if listaOCR is None:
                   raise HTTPException(status_code=503, detail="Serviço de IA indisponível, tente novamente")
               else:
                   return listaOCR
               
           except (ServerError, Exception) as e:
               print(f"Erro ao chamar Gemini: {e}")
               raise HTTPException(status_code=503, detail="Não foi possível processar a imagem no momento") 
   
       elif (desvioPadrao>35 and variancia_global>1117):#imagens de medio a alto contraste
           
           #medio contraste - intervalo de desvio padrão: 34,31 e variancia: 1177,41
           #alto contraste - intervalo de desvio padrão com base no dataset, desvio padrão maximo: 58,48 e variancia maxima: 3419,41
           
           print("limiar binário aplicado e imagem chegou aqui")
           # ret é o valor limiar (threshold) que neste caso será 135
           ret, thresh1 = cv2.threshold (img_cortada, 135, 255, cv2.THRESH_BINARY)
           
           text = pyt.image_to_string(thresh1, lang="por") #textto extraido da imagem
           padrao = r'(\d+)\s([A-ZÀ-ÿ\s]+)' #expressão regular
           resultado = re.findall(padrao, text) #o texto que tiver o padrão é salvo na lista
           palavrasChaves = ['\nGT TOTAL DE TTENS\nVALOR TOTAL ', 'IBWÁSUO ','\nCNPJ ', 'LOJASO', 'POVAGIK ', 'RIRIGUI', 'VALOR ', 'VALOR A PAGAR R',  'VALOR TOTAL R', 'VALOR À PAGAR R', 'FORNMA DE PAGAMENTO VALOR PRGO\nD','FORMA DE PAGANMENTO VALOR PRGO\nD', '\nCONSUMIDOR NW', 'FORNA DE PAGAMENTO VALOR PAGO\nD', '\nIDENTIFICADO', 'VALUR FOTAL R', 'VALOR R PAGAR RS ', '\nGT TOTAL DE T D']
           if resultado:
               for item in resultado:
                   if len(item[1])>5 and not (item[1] in palavrasChaves):#verificando o segundo grupo da expressão regular para saber se o tamanho da string é menor que 5 carac. e se ela não esta contida na lista de palavras
                       listaItens.append(item[1])
                       # print(item[1])
                       
               #recebendo a lista de itens retornado pelo ocr
           listaOCR = listaItens
           # Faça uma interação simples
           try: 
               """
               response = client.models.generate_content(
                   model="gemini-2.5-flash",
                   contents=f"Quero que vc retorne essa lista {listaOCR} em outra lista, mas com cada item escrito da maneira correta. Formato de saida: ['item 1', 'item 2', ...]. Sem frase introdutoria",
               )
               # print(f"{response.text}\n")
               texto_limpo = response.text.replace("```python", "").replace("```json", "").replace("Aqui está a lista corrigida:", "").replace("```", "")
               # l = listaItens #json.loads(listaItens)
               lista_final = ast.literal_eval(texto_limpo)"""
               
               if listaOCR is None:
                   raise HTTPException(status_code=503, detail="Serviço de IA indisponível, tente novamente")
               else:
                   return listaOCR
               
           except (ServerError, Exception) as e:
               print(f"Erro ao chamar Gemini: {e}")
               raise HTTPException(status_code=503, detail="Não foi possível processar a imagem no momento")
       
   
#metodo de recebimento, tratamento e extração de texto em imagem
@rotaMedicamento.post("/medicamentos_identificados")
#função de transformação de lista em json
async def tranformandoListaMedicamentos_Json(imagem: UploadFile):
    

    resultado = []
    l = await recebendoImagem(imagem)

    for item in l:
        itensJson = {"idMedicamento": None, "idUsuario_fk": None,"idISFL_fk": None, "nomeMedicamento": item, "validadeMedicamento": None, "para": None, "horarioMedicamentoIntervalo": None}
    
        resultado.append(itensJson)
    
    return resultado

#metodo de criar produtos
@rotaMedicamento.post("/criar_medicamento")
async def criar_medicamento(imagem: UploadFile,  idUsuario_fk: int = Form(...), db: Session = Depends(get_db)):#"idProduto": None, "idUsuarioFK": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None
    
    medicamentos = await tranformandoListaMedicamentos_Json(imagem)
    print("Medicamentos retornados:", medicamentos)
    print("Quantidade:", len(medicamentos))
    if medicamentos:
        for medicamento in medicamentos:
            novo_medicamento = Medicamento(
                idUsuario_fk = idUsuario_fk, 
                idISFL_fk = medicamento["idISFL_fk"],
                nomeMedicamento = medicamento["nomeMedicamento"],
                validadeMedicamento = medicamento["validadeMedicamento"],
                para = medicamento["para"],
                horarioMedicamentoIntervalo = medicamento["horarioMedicamentoIntervalo"]
            )
        
            db.add(novo_medicamento)
            print("Medicamento adicionado:", novo_medicamento.nomeMedicamento)
        db.commit()
        return True
    else: 
        print("lista de medicamentos vazia")
        return False



@rotaMedicamento.post("/criar_medicamentoISFL")
async def criar_medicamentoISFL(imagem: UploadFile,  idISFL_fk: int = Form(...), db: Session = Depends(get_db)):#"idProduto": None, "idUsuarioFK": None,"idISFL_fk": None, "nomeProduto": item, "dataValidade": None
    
    medicamentos = await tranformandoListaMedicamentos_Json(imagem)
   
    if medicamentos:
        for medicamento in medicamentos:
            novo_produto = Medicamento(
                
                idUsuario_fk = medicamento["idUsuario_fk"],
                idISFL_fk = idISFL_fk,
                nomeMedicamento = medicamento["nomeMedicamento"],
                validadeMedicamento = medicamento["validadeMedicamento"],
                para = medicamento["para"],
                horarioMedicamentoIntervalo = medicamento["horarioMedicamentoIntervalo"]

            )
        
            db.add(novo_produto)
        db.commit()
        return True
    else:
        print("lista de medicamentos vazia")
        return False
    

#metodo de visualizacao de itens que foi salvo no banco -> para o app
#metodo de login - leitura de dados no banco- user comum
@rotaMedicamento.post("/visualizandoMedicamentos")
def lendoItens(medicamento: MedicamentoSchemaUserComum, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Medicamento)
        resultado = consulta.filter(Medicamento.idUsuario_fk == medicamento.idUsuario_fk).all()
        
        if resultado:
            return [
                {
                    "idMedicamento": m.idMedicamento,
                    "nomeMedicamento": m.nomeMedicamento,
                    "validadeMedicamento": m.validadeMedicamento,
                    "para": m.para,
                    "horarioMedicamentoIntervalo": m.horarioMedicamentoIntervalo
                }
                for m in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')
        
@rotaMedicamento.post("/visualizandoMedicamentosISFL")
def lendoItensISFL(medicamento: MedicamentoSchemaISFL, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Medicamento)
        resultado = consulta.filter(Medicamento.idISFL_fk == medicamento.idISFL_fk).all()
        
        if resultado:
            return [
                {
                    "idMedicamento": m.idMedicamento,
                    "nomeMedicamento": m.nomeMedicamento,
                    "validadeMedicamento": m.validadeMedicamento,
                    "para": m.para,
                    "horarioMedicamentoIntervalo": m.horarioMedicamentoIntervalo
                }
                for m in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')
               
#metodo de atualizando med
@rotaMedicamento.put("/atualizando_medicamentos/{idmedicamento}")
def atualizando_medicamentos(idmedicamento:  int, dados_novos: MedicamentoSchemaUserComumAtualiza, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Medicamento)
        medicamento = consulta.filter(Medicamento.idMedicamento == idmedicamento).first()
        
        if medicamento:
                medicamento.nomeMedicamento = dados_novos.nomeMedicamento
                medicamento.validadeMedicamento = dados_novos.validadeMedicamento
                medicamento.horarioMedicamentoIntervalo = dados_novos.horarioMedicamentoIntervalo
                
                
        db.commit() 
        return {"mensagem": "Medicamento atualizado"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar excluir o medicamaneto: {e}')
        
@rotaMedicamento.put("/atualizando_medicamentosISFL/{idmedicamento}")
def atualizando_medicamentos(idmedicamento:  int, dados_novos: MedicamentoSchemaISFLAtualiza, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Medicamento)
        medicamento = consulta.filter(Medicamento.idMedicamento == idmedicamento).first()
        
        if medicamento:
            medicamento.nomeMedicamento = dados_novos.nomeMedicamento
            medicamento.validadeMedicamento = dados_novos.validadeMedicamento
            medicamento.para =  dados_novos.para
            medicamento.horarioMedicamentoIntervalo = dados_novos.horarioMedicamentoIntervalo
                
        db.commit() 
        return {"mensagem": "Medicamento atualizado"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar excluir o medicamaneto: {e}')

#metodo de delete - lista de itens
@rotaMedicamento.delete("/excluindoMedicamentos/{idmedicamento}")
def excluindo_produtos(idmedicamento:  int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Medicamento)
        medicamento = consulta.filter(Medicamento.idMedicamento == idmedicamento).first()
        
        if medicamento:
            
            db.delete(medicamento)    
            db.commit()  
            return {"mensgaem": "Medicamento excluído"}     
        else:
            raise HTTPException(
                status_code=404,
                detail="Medicamento não encontrado"
            )
    except Exception as e:
        print(f'Erro ao tentar excluir o medicamento: {e}')