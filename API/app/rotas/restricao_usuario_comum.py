from typing import Optional
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from sqlalchemy import INTEGER, Date, Integer, create_engine, Column, String, Boolean
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from fastapi import Depends, FastAPI, Request
from sqlalchemy import BigInteger
from pydantic import BaseModel
from datetime import date
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotarestricao_usuario_comum = APIRouter()
#SessionLocal = sessionmaker(bind=engine)

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_RestricaoUsuario = declarative_base()


#model (tabela) de Usuario Comum (Pessoa 60+)
class RestricaoUsuario(Base_RestricaoUsuario):
    __tablename__ = "restricao_usuario"

    idRestricao_usuario = Column("idrestricao_usuario", Integer, primary_key=True)
    idRestricao = Column("idrestricao", Integer)
    idUsuario_fk = Column("idusuario_fk", Integer)
   

#schema (tabela) de Usuario Comum (Pessoa 60+)
class RestricaoUsuarioSchema(BaseModel):
    idRestricao: int
    idUsuario_fk: int
    
#cria tabela de Usuario no banco (se não existir)
Base_RestricaoUsuario.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

#metodo de criação de usuario comum
@rotarestricao_usuario_comum.post("/restricao_usuario")
def criarRestricao(restricao_usuario: RestricaoUsuarioSchema, db: Session = Depends(get_db)):
    db = SessionLocal()
    
    nova_restricao_usuario = RestricaoUsuario(
        idRestricao = restricao_usuario.idRestricao,
        idUsuario_fk =  restricao_usuario.idUsuario_fk,
        
    )
    db.add(nova_restricao_usuario)
    db.commit()

    return {"mensagem": "Restrição Salva"}