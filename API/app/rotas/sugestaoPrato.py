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
rotasugestao_prato = APIRouter()
#SessionLocal = sessionmaker(bind=engine)

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_SugestaoPrato = declarative_base()


#model (tabela) de Usuario Comum (Pessoa 60+)
class SugestaoPrato(Base_SugestaoPrato):
    __tablename__ = "sugestaoprato"

    idPrato = Column("idprato", Integer, primary_key=True)
    nomePrato = Column("nomeprato", String)
    descricao = Column("descricao", String)
    restricao = Column("restricao", String)
    linkPrato = Column("linkprato", String)
   

#schema (tabela) de Usuario Comum (Pessoa 60+)
class SugestaoPratoSchema(BaseModel):
    restricao: str
    
#cria tabela de Usuario no banco (se não existir)
Base_SugestaoPrato.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()



#metodo de criação de usuario comum
@rotasugestao_prato.post("/sugestao_prato")
def lendoItens(prato: SugestaoPratoSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(SugestaoPrato)
        print("RESTRIÇÃO RECEBIDA:", repr(prato.restricao))
        todos = db.query(SugestaoPrato).all()

        print("TOTAL DE PRATOS:", len(todos))
        resultado = consulta.filter(SugestaoPrato.restricao == prato.restricao).all()
        
        if resultado:
            return [
                {
                    "idPrato": p.idPrato,
                    "nomePrato": p.nomePrato,
                    "descricao": p.descricao,
                    "restricao": p.restricao,
                    "linkPrato": p.linkPrato
                }
                for p in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')