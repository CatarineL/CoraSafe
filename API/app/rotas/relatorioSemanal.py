from typing import Optional
from fastapi import Depends, FastAPI, Form, HTTPException, UploadFile
import numpy as np
from pydantic import BaseModel
from sqlalchemy import Boolean, Date, Integer, create_engine, Column, String
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from sqlalchemy import null
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotaRelatorioSemanal = APIRouter()


DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_relatorioSemanal = declarative_base()


#model (tabela) de Produto
class RelatorioSemanal(Base_relatorioSemanal):
    __tablename__ = "relatoriosemanal"

    idSemana = Column("idsemana", Integer, primary_key=True)
    idUsuario_fk = Column("idusuario_fk", Integer)
    idUsuarioFamiliar_fk = Column("idusuariofamiliar_fk", Integer)
    idISFL_fk = Column("idisfl_fk", Integer)
    inicioSemana = Column("iniciosemana", String)
    finalSemana = Column("finalsemana", String)
    segunda = Column("segunda", Integer)
    terca = Column("terca", Integer)
    quarta = Column("quarta", Integer)
    quinta = Column("quinta", Integer)
    sexta = Column("sexta", Integer)
    sabado = Column("sabado", Integer)
    domingo = Column("domingo", Integer)

    
#schema para produto dos usuarios - lendo itens
class RelatorioSemanalSchema(BaseModel):
    idUsuario_fk: Optional[int] = None
    idUsuarioFamiliar_fk: Optional[int] = None
    idISFL_fk: Optional[int] = None
    inicioSemana: str
    finalSemana: str
    segunda: Optional[int] = None
    terca: Optional[int] = None
    quarta: Optional[int] = None
    quinta: Optional[int] = None
    sexta: Optional[int] = None
    sabado: Optional[int] = None
    domingo: Optional[int] = None
    
class verificaRelatorioSemanalSchema(BaseModel):
    idUsuario_fk: Optional[int] = None
    inicioSemana: str
    finalSemana: str
    
class verificaRelatorioSemanalISFLSchema(BaseModel):
    idISFL_fk: Optional[int] = None
    inicioSemana: str
    finalSemana: str
    
class lendoRelatorioSemanal(BaseModel):
    idUsuario_fk: int
    inicioSemana: str
    finalSemana: str
    segunda: Optional[int] = None
    terca: Optional[int] = None
    quarta: Optional[int] = None
    quinta: Optional[int] = None
    sexta: Optional[int] = None
    sabado: Optional[int] = None
    domingo: Optional[int] = None   

class atualizandoRelatorioSemanalUserComum(BaseModel):
    idUsuario_fk: int
    inicioSemana: str
    finalSemana: str
    segunda: Optional[int] = None
    terca: Optional[int] = None
    quarta: Optional[int] = None
    quinta: Optional[int] = None
    sexta: Optional[int] = None
    sabado: Optional[int] = None
    domingo: Optional[int] = None 
    
class atualizandoRelatorioSemanalISFL(BaseModel):
    idISFL_fk: int
    inicioSemana: str
    finalSemana: str
    segunda: Optional[int] = None
    terca: Optional[int] = None
    quarta: Optional[int] = None
    quinta: Optional[int] = None
    sexta: Optional[int] = None
    sabado: Optional[int] = None
    domingo: Optional[int] = None 
    
Base_relatorioSemanal.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@rotaRelatorioSemanal.post("/criar_relatorioSemanal")
def criacaoRelatorioSemanal(semana: RelatorioSemanalSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    nova_semana = RelatorioSemanal(
        idUsuario_fk = semana.idUsuario_fk,
        idUsuarioFamiliar_fk = semana.idUsuarioFamiliar_fk,
        idISFL_fk = semana.idISFL_fk,
        inicioSemana = semana.inicioSemana,
        finalSemana = semana.finalSemana,
        segunda = semana.segunda,
        terca = semana.terca,
        quarta = semana.quarta,
        quinta = semana.quinta,
        sexta = semana.sexta,
        sabado = semana.sabado,
        domingo = semana.domingo
    )
    db.add(nova_semana)
    db.commit()
    
    
@rotaRelatorioSemanal.post("/verifica_relatorioSemanalUserComum")
def verificaRelatorioSemanal(semana: verificaRelatorioSemanalSchema, db: Session = Depends(get_db)):
    try:
        consulta = db.query(RelatorioSemanal)
        relatorio = consulta.filter(RelatorioSemanal.idUsuario_fk == semana.idUsuario_fk, RelatorioSemanal.inicioSemana == semana.inicioSemana, RelatorioSemanal.finalSemana==semana.finalSemana).first()
        
        if relatorio:
           return {
               "encontrado": True,
               "idSemana": relatorio.idSemana
           } 
        else: 
           return {
               "encontrado": False,
               "idSemana": null
           }   
            
    except HTTPException as e:
                print(f'Erro de {e}, ao tentar ler informações da semana.')
                
                
@rotaRelatorioSemanal.post("/verifica_relatorioSemanalISFL")
def verificaRelatorioSemanal(semana: verificaRelatorioSemanalISFLSchema, db: Session = Depends(get_db)):
    try:
        consulta = db.query(RelatorioSemanal)
        relatorio = consulta.filter(RelatorioSemanal.idISFL_fk == semana.idISFL_fk, RelatorioSemanal.inicioSemana == semana.inicioSemana, RelatorioSemanal.finalSemana==semana.finalSemana).first()
        
        if relatorio:
           return {
               "encontrado": True,
               "idSemana": relatorio.idSemana
           } 
        else: 
           return {
               "encontrado": False,
               "idSemana": null
           }   
            
    except HTTPException as e:
                print(f'Erro de {e}, ao tentar ler informações da semana.')
                
#ataualizar o campo de respectivo para consumo do dia da semana
@rotaRelatorioSemanal.put("/editando_relatorioSemanal/{idsemana}")
def editando_relatorioSemanal(idsemana:  int, dados_novos: atualizandoRelatorioSemanalUserComum, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanal)
        relatorio = consulta.filter(RelatorioSemanal.idSemana == idsemana).first()
        
        if relatorio:
            relatorio.segunda = dados_novos.segunda
            relatorio.terca = dados_novos.terca
            relatorio.quarta = dados_novos.quarta
            relatorio.quinta = dados_novos.quinta
            relatorio.sexta = dados_novos.sexta
            relatorio.sabado = dados_novos.sabado
            relatorio.domingo = dados_novos.domingo
        db.commit() 
        return {"mensagem": "Semana atualizada"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar editar semana: {e}')
        
@rotaRelatorioSemanal.put("/editando_relatorioSemanalISFL/{idsemana}")
def editando_relatorioSemanal(idsemana:  int, dados_novos: atualizandoRelatorioSemanalISFL, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanal)
        relatorio = consulta.filter(RelatorioSemanal.idSemana == idsemana).first()
        
        if relatorio:
            relatorio.segunda = dados_novos.segunda
            relatorio.terca = dados_novos.terca
            relatorio.quarta = dados_novos.quarta
            relatorio.quinta = dados_novos.quinta
            relatorio.sexta = dados_novos.sexta
            relatorio.sabado = dados_novos.sabado
            relatorio.domingo = dados_novos.domingo
        db.commit() 
        return {"mensagem": "Semana atualizada"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar editar semana: {e}')
        
#lendo relatorios semanais
@rotaRelatorioSemanal.post("/lendo_ConsumoDiario/{idsemana}")
def lendo_relatorio(idsemana:  int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanal)
        relatorio = consulta.filter(RelatorioSemanal.idSemana == idsemana).first()
        
        if relatorio:
            return relatorio
        else:
            print("Errro ao tentar encontrar semana")
            
          
    except HTTPException as e:
        print(f'Erro ao tentar encontrar relatorio {e}')