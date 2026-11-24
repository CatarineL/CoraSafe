from typing import Optional
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from sqlalchemy import INTEGER, Date, Integer, create_engine, Column, String, Boolean, null
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from fastapi import Depends, FastAPI, Request
from sqlalchemy import BigInteger
from pydantic import BaseModel
from datetime import date
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotaNotificacao = APIRouter()
#SessionLocal = sessionmaker(bind=engine)

DATABASE_URL = "postgresql://postgres:36413159@localhost:5432/CoraTeste"

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_Notificacao = declarative_base()

Base_NotificacaoVinculo = declarative_base()

#model (tabela) de Notificacao
class Notificacao(Base_Notificacao):
    __tablename__ = "notificacao"

    idNotificacao = Column("idnotificacao", Integer, primary_key=True)
    idUsuario_fk = Column("idusuario_fk", Integer)
    idUsuarioFamiliar_fk = Column("idusuariofamiliar_fk", Integer)
    idISFL_fk = Column("idisfl_fk", Integer)
    idProduto_fk = Column("idproduto_fk", Integer)
    Mensagem = Column("mensagem", String)
    Status = Column("status", String)
    dataCriacao = Column("datacriacao", String)
    idMedicamento_fk = Column("idmedicamento_fk", Integer)
    
class NotificacaoVinculo(Base_NotificacaoVinculo):
    __tablename__ = "notificacaovinculo"

    idNotificacaoVinculo = Column("idnotificacaovinculo", Integer, primary_key=True)
    idUsuario = Column("idusuario_fk", Integer)
    idUsuarioFamiliar = Column("idusuariofamiliar_fk", Integer)
    Mensagem = Column("mensagem", String)
    Status = Column("status", String)
    dataCriacao = Column("datacriacao", Date)
    
#schema (tabela) de Usuario Comum (Pessoa 60+)
class NotificacaoSchema(BaseModel):
    #idNotificacao: int
    idUsuario_fk: Optional[int] = None
    idUsuarioFamiliar_fk: Optional[int] = None
    idISFL_fk: Optional[int] = None
    idProduto_fk: Optional[int] = None
    Mensagem: Optional[str] = None
    Status: Optional[str] = None
    dataCriacao: Optional[date] = None
    idMedicamento_fk: Optional[int] = None
    
class NotificacaoVinculoSchema(BaseModel):
    idUsuario: int

class atualizaNotificacaoSchema(BaseModel):
    idNotificacao: int
    idProduto_fk: Optional[int] = None
    idMedicamento_fk: Optional[int] = None
    Mensagem: str
    
class atualizaStatusNotificacaoVinculoSchema(BaseModel):
    idUsuario: int
    Status: str
    

    
# cria tabela de Usuario no banco (se não existir)
Base_Notificacao.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()



#metodo de criação de usuario comum
@rotaNotificacao.post("/notificacao")
def criar_notificacao(notificacao: NotificacaoSchema, db: Session = Depends(get_db)):
    nova_notificacao = Notificacao(
        idUsuario_fk= notificacao.idUsuario_fk,
        idUsuarioFamiliar_fk=notificacao.idUsuarioFamiliar_fk,
        idISFL_fk= notificacao.idISFL_fk,
        idProduto_fk = notificacao.idProduto_fk,
        Mensagem= notificacao.Mensagem,
        Status= notificacao.Status,
        dataCriacao= notificacao.dataCriacao,
        idMedicamento_fk=notificacao.idMedicamento_fk
        
    )
    db.add(nova_notificacao)
    db.commit()
    db.refresh(nova_notificacao)

    return {"mensagem": "Notificação criada"}

#metodo de criação de usuario comum
@rotaNotificacao.post("/notificacao_vinculo")
def criar_notificacao_vinculo(notificacao: NotificacaoVinculoSchema, db: Session = Depends(get_db)):
    nova_notificacao_vinculo = NotificacaoVinculo(
        idUsuario_fk= notificacao.idUsuario_fk,
        idUsuarioFamiliar_fk=notificacao.idUsuarioFamiliar_fk,
        Mensagem= notificacao.Mensagem,
        Status= notificacao.Status,
        dataCriacao= notificacao.dataCriacao
    )
    db.add(nova_notificacao_vinculo)
    db.commit()
    

    return {"mensagem": "Notificação de vinculo criada"}


"""@rotaNotificacao.post("/visualizandoNotificacaoUserComum")
def visualizandoNotificacaoUserComum(notificacao: NotificacaoSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idNotificacao == notificacao.idNotificacao).all()
        
        if resultado:
            return [
                {
                    "idUsuario": n.idUsuario_fk,
                    "Mensagem": n.Mensagem,
                    "dataCriacao": n.dataCriacao
                }
                for n in resultado
            ]
        else:
            return "Notificação não encontrada"
            
    except HTTPException:
        print('Erro ao realizar a busca pela notificação')"""

@rotaNotificacao.post("/verificaNotificacaoProd")
def verificaNotificacaoProd(idProd_fk: int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idProduto_fk == idProd_fk).first()
        
        if resultado:
            print("Notificacao do produto ja existe")
            return resultado is not None
           
        else:
            print("Notificacao do produto não existe")
            return False
            
    except HTTPException as e:
            print(f"Erro ao realizar a busca pela notificação: {e}")
            return {
                "encontrado": False,
                "mensagem": "Erro ao realizar a busca pela notificação"
            }
            
@rotaNotificacao.post("/verificaNotificacaoMed")
def verificaNotificacaoMed(idMed_fk: int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idMedicamento_fk == idMed_fk).first()
        
        if resultado:
            print("Notificacao do medicamento ja existe")
            return resultado is not None
           
        else:
            print("Notificacao do medicamento não existe")
            return False
            
    except HTTPException as e:
            print(f"Erro ao realizar a busca pela notificação: {e}")
            return {
                "encontrado": False,
                "mensagem": "Erro ao realizar a busca pela notificação"
            }
            
@rotaNotificacao.post("/retornoIDNotificacaoProd")
def retornoIDNotificacaoProd(idProd_fk: int, db: Session = Depends(get_db)):

    try: 
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idProduto_fk == idProd_fk).first()
        
        if resultado:
            print("Notificacao do produto ja existe")
            return resultado.idNotificacao
           
        else:
            print("Notificacao do produto não existe")
            return null
            
    except HTTPException as e:
            print(f"Erro ao realizar a busca pela notificação: {e}")
            return "mensagem: Erro ao realizar a busca pela notificação"
            
            
@rotaNotificacao.post("/retornoIDNotificacaoMed")
def retornoIDNotificacaoMed(idMed_fk: int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idMedicamento_fk == idMed_fk).first()
        
        if resultado:
            print("Notificacao do medicamento ja existe")
            return resultado.idNotificacao
           
        else:
            print("Notificacao do medicamento não existe")
            return null
            
    except HTTPException as e:
            print(f"Erro ao realizar a busca pela notificação: {e}")
            return "mensagem: Erro ao realizar a busca pela notificação"
                
            
@rotaNotificacao.post("/lendoNotificacoesUsuarioComum/{idUsuario}")
def lendoNotificacoesUsuarioComum(idUsuario: int, db: Session = Depends(get_db)):

    try: 
        print("ID idoso recebido:", idUsuario)
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idUsuario_fk == idUsuario).all()
    
       
        return [
            {
                "idNotificacao": n.idNotificacao,
                "idUsuario_fk": n.idUsuario_fk,
                "idUsuarioFamiliar_fk": n.idUsuarioFamiliar_fk,
                "idISFL_fk": n.idISFL_fk,
                "idProduto_fk": n.idProduto_fk,
                "Mensagem": n.Mensagem,
                "Status": n.Status,
                "dataCriacao": n.dataCriacao,
                "idMedicamento_fk": n.idMedicamento_fk
            
            }
            for n in resultado
        ]
            
    except HTTPException as e:
        print(f"Erro ao realizar a busca pela notificação: {e}")
        return {
            "encontrado": False,
            "mensagem": "Erro ao realizar a busca pela notificação"
        }        
 
@rotaNotificacao.post("/lendoNotificacoesISFL/{idISFL}")
def lendoNotificacoesISFL(idISFL: int, db: Session = Depends(get_db)):

    try: 
        print("ID idoso recebido:", idISFL)
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        resultado = consulta.filter(Notificacao.idISFL_fk == idISFL).all()
    
       
        return [
            {
                "idNotificacao": n.idNotificacao,
                "idUsuario_fk": n.idUsuario_fk,
                "idUsuarioFamiliar": n.idUsuarioFamiliar_fk,
                "idISFL_fk": n.idISFL_fk,
                "idProduto_fk": n.idProduto_fk,
                "Mensagem": n.Mensagem,
                "Status": n.Status,
                "dataCriacao": n.dataCriacao,
                "idMedicamento_fk": n.idMedicamento_fk
            
            }
            for n in resultado
        ]
            
    except HTTPException as e:
        print(f"Erro ao realizar a busca pela notificação: {e}")
        return {
            "encontrado": False,
            "mensagem": "Erro ao realizar a busca pela notificação"
        } 
 
 
        
@rotaNotificacao.post("/visualizandoNotificacaoVinculoUserComum")
def visualizandoNotificacaoUserComum(notificacao: NotificacaoVinculoSchema, db: Session = Depends(get_db)):

    try: 
        print("ID idoso recebido:", notificacao.idUsuario)
        #consultando a tabela de Usuario no banco
        consulta = db.query(NotificacaoVinculo)
        resultado = consulta.filter(NotificacaoVinculo.idUsuario == notificacao.idUsuario).first()
        print("RESULTADO:", resultado)
        if resultado:
            
            return {
                "idNotificacaoVinculo": resultado.idNotificacaoVinculo,
                "idUsuario": resultado.idUsuario,
                "idUsuarioFamiliar": resultado.idUsuarioFamiliar,
                "Mensagem": resultado.Mensagem,
                "Status": resultado.Status,
                "dataCriacao": resultado.dataCriacao
            }
        
        else:
            return {
                "encontrado": False,
                "mensagem": "Notificacao de vinculo não encontrado"
            }
            
    except HTTPException as e:
        print(f"Erro ao realizar a busca pela notificação: {e}")
        return {
            "encontrado": False,
            "mensagem": "Erro ao realizar a busca pela notificação"
        }

@rotaNotificacao.put("/atualiza_notificacao/{idNot}")
def atualizando_Notificacao(idNot:  int, dados_novos: atualizaNotificacaoSchema, db: Session = Depends(get_db)):

    try:
        consulta = db.query(Notificacao)
        notificacao = consulta.filter(Notificacao.idNotificacao == idNot).first()
        print("NOTIFICAÇÃO ENCONTRADA:", notificacao)
        if notificacao:            
            notificacao.Mensagem = dados_novos.Mensagem
            print("MENSAGEM DEPOIS:", notificacao.Mensagem)
        db.commit() 
        db.refresh(notificacao)
  
        return {"mensagem": "atualização feita com sucesso"}  
                 
    except HTTPException as e:
        print(f'Erro de {e}, ao tentar atualizar o staus de notificacao.')
        

@rotaNotificacao.put("/atualiza_notificacao_vinculo/{idusuario}")
def atualizando_StatusNotVinculoUserComum(idusuario:  int, dados_novos: atualizaStatusNotificacaoVinculoSchema, db: Session = Depends(get_db)):

    try:
        consulta = db.query(NotificacaoVinculo)
        notificacao = consulta.filter(NotificacaoVinculo.idUsuario == idusuario).first()
        print("NOTIFICAÇÃO ENCONTRADA:", notificacao)
        if notificacao:            
            print("STATUS ANTES:", notificacao.Status)
            notificacao.Status = dados_novos.Status
            print("STATUS DEPOIS:", notificacao.Status)
        db.commit() 
        db.refresh(notificacao)

       
        return {"mensagem": "atualização feita com sucesso"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar atualizar o staus de notificacao.')    
         
        
"""@rotaNotificacao.post("excluir_notificacao_vinculo/{idNotificacaoVinculo}")
def excluindoNotificacaoVinculo(idNotificacaoVinculo: int, db: Session = Depends(get_db)):
    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(NotificacaoVinculo)
        notificacao = consulta.filter(NotificacaoVinculo.idNotificacaoVinculo == idNotificacaoVinculo).first()
        
        if notificacao:
            db.delete(notificacao)    
            db.commit()  
            return {"mensgaem": "notificacao excluída"}     
        else:
            raise HTTPException(
                status_code=404,
                detail="Notificacao de Vínculo não encontrada"
            )
    except Exception as e:
        print(f'Erro ao tentar excluir o notificacao: {e}')"""
        
        
@rotaNotificacao.delete("/excluir_notificacao/{idNotificacao}")
def excluindoNotificacao(idNotificacao: int, db: Session = Depends(get_db)):
    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Notificacao)
        notificacao = consulta.filter(Notificacao.idNotificacao == idNotificacao).first()
        
        if notificacao:
            db.delete(notificacao)    
            db.commit()  
            return {"mensgaem": "notificacao excluída"}     
        else:
            raise HTTPException(
                status_code=404,
                detail="Notificacao não encontrada"
            )
    except Exception as e:
        print(f'Erro ao tentar excluir o notificacao: {e}')
    
    