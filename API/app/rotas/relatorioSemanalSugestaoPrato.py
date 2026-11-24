import ast
import json
from typing import Optional
from fastapi import Depends, FastAPI, Form, HTTPException, UploadFile
import numpy as np
from pydantic import BaseModel
from sqlalchemy import Boolean, Date, Integer, create_engine, Column, String
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from sqlalchemy import null
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotaRelatorioSemanalSugestaoPrato = APIRouter()


DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_relatorioSemanal = declarative_base()


#model (tabela) de Produto
class RelatorioSemanalSugestaoPrato(Base_relatorioSemanal):
    __tablename__ = "relatoriosemanalsugestaoprato" 

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
class RelatorioSemanalSugestaoPratoSchema(BaseModel):
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
    
class verificaRelatorioSemanalSugestaoPratoSchema(BaseModel):
    idUsuario_fk: Optional[int] = None
    inicioSemana: str
    finalSemana: str
    
class lendoRelatorioSemanalSugestaoPrato(BaseModel):
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

class atualizandoRelatorioSemanalSugestaoPratoUserComum(BaseModel):
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
    
class atualizandoRelatorioSemanalSugestaoPratoISFL(BaseModel):
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

@rotaRelatorioSemanalSugestaoPrato.post("/criar_relatorioSemanalSugestaoPrato")
def criacaoRelatorioSemanal(semana: RelatorioSemanalSugestaoPratoSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    nova_semana = RelatorioSemanalSugestaoPrato(
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
    
    
@rotaRelatorioSemanalSugestaoPrato.post("/verifica_relatorioSemanalSugestaoPratoUserComum")
def verificaRelatorioSemanal(semana: RelatorioSemanalSugestaoPratoSchema, db: Session = Depends(get_db)):
    try:
        consulta = db.query(RelatorioSemanalSugestaoPrato)
        relatorio = consulta.filter(RelatorioSemanalSugestaoPrato.idUsuario_fk == semana.idUsuario_fk, RelatorioSemanalSugestaoPrato.inicioSemana == semana.inicioSemana, RelatorioSemanalSugestaoPrato.finalSemana==semana.finalSemana).first()
        
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
                
                
@rotaRelatorioSemanalSugestaoPrato.post("/verifica_relatorioSemanalSugestaoPratoISFL")
def verificaRelatorioSemanal(semana: RelatorioSemanalSugestaoPratoSchema, db: Session = Depends(get_db)):
    try:
        consulta = db.query(RelatorioSemanalSugestaoPrato)
        relatorio = consulta.filter(RelatorioSemanalSugestaoPrato.idISFL_fk == semana.idISFL_fk, RelatorioSemanalSugestaoPrato.inicioSemana == semana.inicioSemana, RelatorioSemanalSugestaoPrato.finalSemana==semana.finalSemana).first()
        
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
@rotaRelatorioSemanalSugestaoPrato.put("/editando_relatorioSemanalSugestaoPrato/{idsemana}")
def editando_relatorioSemanal(idsemana:  int, dados_novos: atualizandoRelatorioSemanalSugestaoPratoUserComum, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanalSugestaoPrato)
        relatorio = consulta.filter(RelatorioSemanalSugestaoPrato.idSemana == idsemana).first()
        
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
        
@rotaRelatorioSemanalSugestaoPrato.put("/editando_relatorioSemanalSugestaoPratoISFL/{idsemana}")
def editando_relatorioSemanal(idsemana:  int, dados_novos: atualizandoRelatorioSemanalSugestaoPratoISFL, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanalSugestaoPrato)
        relatorio = consulta.filter(RelatorioSemanalSugestaoPrato.idSemana == idsemana).first()
        
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
@rotaRelatorioSemanalSugestaoPrato.post("/lendo_SugestaoPratoDiaria/{idsemana}")
def lendo_relatorio(idsemana:  int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(RelatorioSemanalSugestaoPrato)
        relatorio = consulta.filter(RelatorioSemanalSugestaoPrato.idSemana == idsemana).first()
        
        if relatorio:
            return relatorio
        
        else:
            print("Errro ao tentar encontrar semana")           
    except HTTPException as e:
        print(f'Erro ao tentar editar semana: {e}')