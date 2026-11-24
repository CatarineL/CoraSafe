from typing import Optional
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from sqlalchemy import INTEGER, Date, Integer, create_engine, Column, String, Boolean, null
from sqlalchemy.orm import Session, declarative_base, sessionmaker
from fastapi import Depends, FastAPI, Request
from sqlalchemy import BigInteger
from pydantic import BaseModel
from datetime import date
import smtplib
from email.mime.text import MIMEText
from fastapi import APIRouter, Depends, HTTPException

#configuração da rota
rotaDoacoes = APIRouter()

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_Doacoes = declarative_base()

class Doacao(Base_Doacoes):
    __tablename__ = "doacao"

    idDoacao = Column("iddoacao", Integer, primary_key=True)
    idISFL_fk = Column("idisfl_fk", Integer)
    idICFL_fk = Column("idicfl_fk", Integer)
    mensagemSolicitacao = Column("mensagemsolicitacao", String) #Column("cpfusuario",BigInteger, primary_key=True)
    statusSolicitacao = Column("statussolicitacao", String)
    dataSolicitacao = Column("datasolicitacao", String)
    emailISFL_fk = Column("emailisfl_fk", String)
    emailICFL_fk = Column("emailicfl_fk", String)
    
class DoacaoSchema(BaseModel):
    idISFL_fk: int
    idICFL_fk: int
    mensagemSolicitacao: str
    statusSolicitacao: str
    dataSolicitacao: str
    emailISFL_fk: Optional[str] = None
    emailICFL_fk: Optional[str] = None
    
class DoacaoEnvioSolicitacaoEmailSchema(BaseModel):
    mensagemSolicitacao: str
    emailISFL_fk: Optional[str] = None
    emailICFL_fk: Optional[str] = None
   
# cria tabela de Usuario no banco (se não existir)
Base_Doacoes.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@rotaDoacoes.post("/criar_solicitacaoDoacao")
def criar_solicitacaoDoacao(doacao: DoacaoSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    nova_doacao = Doacao(
        idISFL_fk = doacao.idISFL_fk,
        idICFL_fk = doacao.idICFL_fk,
        mensagemSolicitacao = doacao.mensagemSolicitacao,
        statusSolicitacao = doacao.statusSolicitacao,
        dataSolicitacao = doacao.dataSolicitacao,
        emailISFL_fk = doacao.emailISFL_fk,
        emailICFL_fk = doacao.emailICFL_fk
    )
    db.add(nova_doacao)
    db.commit()

#envio de mensgaem por email
@rotaDoacoes.post("/envioEmail_solicitacaoDoacao")
def envioEmail_solicitacaoDoacao(nomeISFL: str, nomeRes: str, 
                                 telefone: str,
                                 emailInstituicaoSFL: str, emailInstituicaoCFL: str, mensagem: str,
                                 doacao: DoacaoEnvioSolicitacaoEmailSchema, db: Session = Depends(get_db)):
    try:
        consulta = db.query(Doacao)
        instituicoes = consulta.filter(Doacao.emailISFL_fk == emailInstituicaoSFL, Doacao.emailICFL_fk == emailInstituicaoCFL).first()
        
        if instituicoes:
               remetente = instituicoes.emailISFL_fk
               senha_app = "vinvcjxfopxfnbbk"
           
               destinatario = emailInstituicaoCFL
               
               emailSolicitacaoDoacao = MIMEText(
               f"""
               <html>
                   <body style="font-family: Arial, sans-serif;">
           
                   <h2 style="color: #e53935;">Solicitação de Ajuda - {nomeISFL}</h2>
                   
                   <p>
                   {mensagem}<br>
                   Para mais informações contatar {telefone}
                   </p>
           
                   <p>
                   <strong>Atenciosamente,</strong><br>
                   Equipe {nomeISFL} - Responsável {nomeRes}
                   </p>
           
                   </body>
               </html>
               """
               ,
               "html",
               "utf-8"
               )
           
               emailSolicitacaoDoacao["Subject"] = "CoraSafe - Solicitação de Doação"
               emailSolicitacaoDoacao["From"] = remetente
               emailSolicitacaoDoacao["To"] = destinatario
           
               with smtplib.SMTP_SSL("smtp.gmail.com", 465) as servidor:
                   servidor.login(remetente, senha_app)
                   servidor.send_message(emailSolicitacaoDoacao)
           
               return {"mensagem": "E-mail de solicitação de doação enviado"}
            
            
    except HTTPException as e:
                print(f'Erro ao tentar ler informações do usuário.')
    
    
#lendo solicitações de doação
@rotaDoacoes.post("/lendo_solicitacaoDoacao/{idisfl_fk}")
def lendo_solicitacaoDoacao(idisfl_fk: int, db: Session = Depends(get_db)):
    
    try:
        consulta = db.query(Doacao)
        resultado = consulta.filter(Doacao.idISFL_fk == idisfl_fk).all()
        
        return [
            {
                "idDoacao": d.idDoacao,
                "idISFL_fk": d.idISFL_fk,
                "idICFL_fk": d.idICFL_fk,
                "mensagemSolicitacao": d.mensagemSolicitacao,
                "statusSolicitacao": d.statusSolicitacao
            }
            for d in resultado
        ]
    except HTTPException as e:
            print(f"Erro ao realizar a busca pela instituição: {e}")
            return {
                "encontrado": False,
                "mensagem": "Erro ao realizar a busca pela notificação"
            }