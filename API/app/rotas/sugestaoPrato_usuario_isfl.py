from typing import Optional
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from sqlalchemy import INTEGER, Date, Integer, create_engine, Column, String, Boolean
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from fastapi import Depends, FastAPI, Request
from sqlalchemy import BigInteger
from pydantic import BaseModel
from datetime import date, datetime
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotasugestao_prato_usuario_isfl = APIRouter()
#SessionLocal = sessionmaker(bind=engine)

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_SugestaoPratoUsuario = declarative_base()
Base_SugestaoPratoISFL = declarative_base()

#model (tabela) de Usuario Comum (Pessoa 60+)
class SugestaoPratoUsuario(Base_SugestaoPratoUsuario):
    __tablename__ = "sugestao_prato_usuario"

    idsugestaopratousuario = Column("idsugestaopratousuario", Integer, primary_key=True)
    idprato = Column("idprato", Integer)
    idusuario_fk = Column("idusuario_fk", Integer)
    status = Column("status", String)
    datacriacao = Column("datacriacao", Date)
    
class SugestaoPratoISFL(Base_SugestaoPratoISFL):
    __tablename__ = "sugestao_prato_isfl"

    idsugestaopratousuario = Column("idsugestaopratousuario", Integer, primary_key=True)
    idprato = Column("idprato", Integer)
    idISFL_fk = Column("idisfl_fk", Integer)
    status = Column("status", String)
    datacriacao = Column("datacriacao", Date)

#schema (tabela) de Usuario Comum (Pessoa 60+)
class SugestaoPratoUsuarioSchema(BaseModel):
    idPrato: int
    idUsuario_fk: int
    status: str
    datacriacao: date
    
class SugestaoPratoISFLSchema(BaseModel):
    idPrato: int
    idISFL_fk: int
    status: str
    datacriacao: date
    
class SugestaoPratoUsuarioLeituraSchema(BaseModel):
    idUsuario_fk: int

class SugestaoPratoISFLLeituraSchema(BaseModel):
    idISFL_fk: int
    
    
#cria tabela de Usuario no banco (se não existir)
Base_SugestaoPratoUsuario.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@rotasugestao_prato_usuario_isfl.post("/sugestao_prato_usuario")
def criar_sugestao_prato_usuario(sugestao: SugestaoPratoUsuarioSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    aceitacaoSugestao = SugestaoPratoUsuario(
        idprato = sugestao.idPrato,
        idusuario_fk = sugestao.idUsuario_fk,
        status = sugestao.status,
        datacriacao = sugestao.datacriacao
    )
    db.add(aceitacaoSugestao)
    db.commit()
    db.refresh(aceitacaoSugestao)

    return {
        "idsugestaopratousuario": aceitacaoSugestao.idsugestaopratousuario
    }
    
@rotasugestao_prato_usuario_isfl.post("/sugestao_prato_isfl")
def criar_sugestao_prato_isfl(sugestao: SugestaoPratoISFLSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    aceitacaoSugestao = SugestaoPratoISFL(
        idprato = sugestao.idPrato,
        idISFL_fk = sugestao.idISFL_fk,
        status = sugestao.status,
        datacriacao = sugestao.datacriacao
    )
    db.add(aceitacaoSugestao)
    db.commit()
    db.refresh(aceitacaoSugestao)

    return {
        "idsugestaopratousuario": aceitacaoSugestao.idsugestaopratousuario
    }
     
#metodo de criação de usuario comum
@rotasugestao_prato_usuario_isfl.post("/sugestao_pratoAceitas")
def lendoItens(sugestao_prato: SugestaoPratoUsuarioLeituraSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(SugestaoPratoUsuario)
        
        resultado = consulta.filter(SugestaoPratoUsuario.idusuario_fk == sugestao_prato.idUsuario_fk).all()
        
        if resultado:
            return [
                {
                    "idprato": p.idprato,
                    "idusuario_fk": p.idusuario_fk,
                    "status": p.status,
                    "datacriacao": p.datacriacao
                }
                for p in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens')
        
#metodo de criação de usuario comum
@rotasugestao_prato_usuario_isfl.post("/sugestao_pratoAceitas_isfl")
def lendoItensIsfl(sugestao_prato: SugestaoPratoISFLLeituraSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(SugestaoPratoISFL)
        
        resultado = consulta.filter(SugestaoPratoISFL.idISFL_fk == sugestao_prato.idISFL_fk).all()
        
        if resultado:
            return [
                {
                    "idprato": p.idprato,
                    "idisfl_fk": p.idISFL_fk,
                    "status": p.status,
                    "datacriacao": p.datacriacao
                }
                for p in resultado
            ]
        else:
            return []
            
    except HTTPException:
        print('Erro ao realizar a busca de itens para a instituição')