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
rotaUsuarios = APIRouter()

DATABASE_URL = ""

#conexão
engine = create_engine(DATABASE_URL)

#sessão
SessionLocal = sessionmaker(bind=engine)

#base de Usuario comum
Base_UsuarioIdoso = declarative_base()

#base de Usuario familiar
Base_UsuarioFamiliar = declarative_base()

#base de ISFL
Base_UsuarioISFL = declarative_base()

Base_UsuarioICFL = declarative_base()

Base_VinculoUsuarioFamiliarIdoso = declarative_base()


#model (tabela) de Usuario Comum (Pessoa 60+)
class Usuario(Base_UsuarioIdoso):
    __tablename__ = "usuario"

    idUsuario = Column("usuarioid", Integer, primary_key=True)
    nomeUsuario = Column("nomeusuario", String)
    dataNascimentoUsuario = Column("datanascimentousuario", String)
    cpfUsuario = Column("cpfusuario", String) #Column("cpfusuario",BigInteger, primary_key=True)
    tipoUsuario = Column("tipousuario", String)
    emailUsuario = Column("emailusuario", String)
    emailFamiliar = Column("emailfamiliar", String)
    senha = Column("senha", String)
    sexo = Column("sexo", String)
    telefone = Column("telefone", String)
    restricaoAlimentar = Column("restricaoalimentar", String)

#schema (tabela) de Usuario Comum (Pessoa 60+)
class UsuarioSchema(BaseModel):
    nomeUsuario: str
    dataNascimentoUsuario: str
    cpfUsuario: str
    tipoUsuario: str
    emailUsuario: str
    emailFamiliar: Optional[str] = None
    senha: str
    sexo: Optional[str] = None
    telefone: str
    restricaoAlimentar: Optional[str] = None
    
class loginUsuarioComumSchema(BaseModel):
    emailUsuario: str
    senha: str
    
#model (tabela) de Usuario Familiar (Responsavel)
class Usuariofamiliar(Base_UsuarioFamiliar):
    __tablename__ = "usuario_familiar"

    idUsuario = Column("idusuariofamiliar", Integer, primary_key=True)
    nome = Column("nome", String)
    dataNascimento = Column("datanascimento", String)
    cpf = Column("cpf", String) #Column("cpfusuario",BigInteger, primary_key=True)
    tipoUsuario = Column("tipousuario", String)
    emailFamiliar = Column("emailfamiliar", String)
    senha = Column("senha", String)
    sexo = Column("sexo", String)
    telefone = Column("telefone", String)
    idUsuarioComum = Column("idusuariocomumfk", String)
    
#schema (tabela) de Usuario Familiar
class UsuariofamiliarSchema(BaseModel):
    nome: str
    dataNascimento: str
    cpf: str
    tipoUsuario: str
    emailFamiliar: str
    senha: str
    sexo: Optional[str] = None
    telefone: str    
    idusuarioComum: Optional[str] = None
    
class loginUsuarioFamiliarSchema(BaseModel):
    emailFamiliar: str
    senha: str

    
class lendoDadosSchema(BaseModel):
    emailFamiliar: str
    
   
#atualizando dados idoso
class atualizaUsuarioComumSchema(BaseModel):
    nomeUsuario: Optional[str] = None
    dataNascimentoUsuario: Optional[str] = None
    emailUsuario: Optional[str] = None
    emailFamiliar: Optional[str] = None
    telefone: str
    restricaoAlimentar: Optional[str] = None

#atualizando dados familiar
class atualizaUsuarioFamiliarSchema(BaseModel):
    nomeUsuario: str
    telefone: str


class atualizandocampoUsuarioFamiliarSchema(BaseModel):
    idUsuarioComum: str

class buscaCPFUsuarioComumSchema(BaseModel):
    cpfUsuario: str


#model (tabela) de ISFL
class InstituicaoSFL(Base_UsuarioISFL):
    __tablename__ = "isfl"

    idISFL = Column("idisfl", Integer, primary_key=True)
    nomeISFL = Column("nomeisfl", String)
    nomeResponsavel = Column("nomeresponsavel", String)
    cnpj = Column("cnpj", String) #Column("cpfusuario",BigInteger, primary_key=True)
    tipoUsuario = Column("tipousuario", String)
    emailISFL = Column("emailisfl", String)
    senha = Column("senha", String)
    telefoneISFL = Column("telefoneisfl", String)
    restricaoAlimentar = Column("restricaoalimentar", Boolean)


#schema de ISFL
class InstituicaoSFLSchema(BaseModel):
    nomeISFL: str
    nomeResponsavel: str
    cnpj: str
    tipoUsuario: str
    emailISFL: str
    senha: str
    telefoneISFL: str
    restricaoAlimentar: Optional[bool] = None  

class loginISFLSchema(BaseModel):
    emailISFL: str
    senha: str

class atualizaISFLSchema(BaseModel):
    nomeISFL: str
    nomeResponsavel: str
    emailISFL: str
    telefoneISFL: str

class VinculoUsuarioFamiliarIdoso(Base_VinculoUsuarioFamiliarIdoso):
    __tablename__ = "vinculo_usuarioFamiliar_usuarioIdoso"

    idVinculoFamiliar = Column("idvinculofamiliar", Integer, primary_key=True)
    idUsuarioFamiliar = Column("idusuariofamiliar", Integer)
    idUsuarioIdoso = Column("idusuarioidoso", Integer)
    status = Column("status", String) #Column("cpfusuario",BigInteger, primary_key=True)
    
#schema (tabela) de Usuario Comum (Pessoa 60+)
class vinculo_usuarioFamiliar_usuarioIdosoSchema(BaseModel):
    idUsuarioFamiliar: Optional[int] = None
    idUsuarioIdoso: Optional[int] = None
    status: Optional[str] = None


class InstituicaoCFL(Base_UsuarioICFL):
    __tablename__ = "icfl"

    idICFL = Column("idicfl", Integer, primary_key=True)
    nomeICFL = Column("nomeicfl", String)
    telefoneICFL = Column("telefoneicfl", String)
    emailICFL = Column("emailicfl", String) #Column("cpfusuario",BigInteger, primary_key=True)
    


#schema de ISFL
class InstituicaoCFLSchema(BaseModel):
    nomeICFL: str
    telefoneICFL: str
    emailICFL: str
          
# cria tabela de Usuario no banco (se não existir)
Base_UsuarioIdoso.metadata.create_all(bind=engine)
# cria tabela de Usuario Familiar no banco (se não existir)
Base_UsuarioFamiliar.metadata.create_all(bind=engine)
# cria tabela de ISFL no banco (se não existir)
Base_UsuarioISFL.metadata.create_all(bind=engine)

Base_VinculoUsuarioFamiliarIdoso.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


#metodo de criação de usuario comum
@rotaUsuarios.post("/usuarios")
def criar_usuario(usuario: UsuarioSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    novo_usuario = Usuario(
        #idUsuario = 9, #campo de autoincremento no banco de dados
        nomeUsuario= usuario.nomeUsuario,
        dataNascimentoUsuario=usuario.dataNascimentoUsuario,
        cpfUsuario= usuario.cpfUsuario,
        tipoUsuario= usuario.tipoUsuario,
        emailUsuario= usuario.emailUsuario,
        emailFamiliar= usuario.emailFamiliar,
        senha= usuario.senha,
        sexo= usuario.sexo,
        telefone= usuario.telefone, 
        restricaoAlimentar = usuario.restricaoAlimentar
    )
    db.add(novo_usuario)
    db.commit()

    #email de confirmação de cadastro
    if usuario.emailUsuario != null:
        remetente = "cora.safequalitylife@gmail.com"
        senha_app = "vinvcjxfopxfnbbk"

        destinatario = usuario.emailUsuario
        
        emailConfirmacaoCadastro = MIMEText(
        f"""
        <html>
            <body style="font-family: Arial, sans-serif;">

            <h2 style="color: #e53935;">Cadastro realizado com sucesso</h2>

            <p>
            <strong>{usuario.nomeUsuario}</strong>
            parabéns por fazer sua conta conosco!
            </p>

            <p>
            Acesse o aplicativo para realizar seu login agora mesmo.
            </p>

            <p>
            <strong>Atenciosamente,</strong><br>
            Equipe CoraSafe
            </p>

            </body>
        </html>
        """
        ,
        "html",
        "utf-8"
        )

    #notificação de cadastro conluido com sucesso
    emailConfirmacaoCadastro["Subject"] = "CoraSafe - Cadastro"
    emailConfirmacaoCadastro["From"] = remetente
    emailConfirmacaoCadastro["To"] = destinatario

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as servidor:
        servidor.login(remetente, senha_app)
        servidor.send_message(emailConfirmacaoCadastro)
    

    if usuario.emailFamiliar!=null:
        #enviando para o email de familiar convite de vinculo de responsabilidade
        remetente = "cora.safequalitylife@gmail.com"
        senha_app = "vinvcjxfopxfnbbk"

        destinatario = usuario.emailFamiliar

        mensagem_ConviteFamiliar = MIMEText(
        f"""
        <html>
        <body style="font-family: Arial, sans-serif;">

            <h2 style="color: #e53935;">Convite CoraSafe</h2>

            <p>
            <strong>{usuario.nomeUsuario}</strong>
            informou este endereço de e-mail como contato familiar.
            </p>

            <p>
            Acesse o aplicativo para realizar seu cadastro
            e acompanhar seu familiar ou paciente.
            </p>

            <p>
            <strong>Atenciosamente,</strong><br>
            Equipe CoraSafe
            </p>

        </body>
        </html>
        """
        ,
        "html",
        "utf-8"
        )

        mensagem_ConviteFamiliar["Subject"] = "CoraSafe - Vínculo de familiar"
        mensagem_ConviteFamiliar["From"] = remetente
        mensagem_ConviteFamiliar["To"] = destinatario

        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as servidor:
            servidor.login(remetente, senha_app)
            servidor.send_message(mensagem_ConviteFamiliar)
    
    return {"mensagem": "Usuário Cadastrado com Sucesso"}
    
#metodo de criação de usuario familiar
@rotaUsuarios.post("/usuario_familiar")
def criar_usuario(usuario: UsuariofamiliarSchema, db: Session = Depends(get_db)):
    
    novo_usuario = Usuariofamiliar(
    
        nome= usuario.nome,
        dataNascimento=usuario.dataNascimento,
        cpf= usuario.cpf,
        tipoUsuario= usuario.tipoUsuario,
        emailFamiliar= usuario.emailFamiliar,
        senha= usuario.senha,
        sexo= usuario.sexo,
        telefone= usuario.telefone,
        idUsuarioComum = usuario.idusuarioComum
        
    )
    db.add(novo_usuario)
    db.commit()
    db.refresh(novo_usuario)
    
    #enviando para o email para confirmação de cadastro
    remetente = "cora.safequalitylife@gmail.com"
    senha_app = "vinvcjxfopxfnbbk"

    destinatario = usuario.emailFamiliar

    emailConfirmacaoCadastro = MIMEText(
    f"""
    <html>
        <body style="font-family: Arial, sans-serif;">

        <h2 style="color: #e53935;">Cadastro realizado com sucesso</h2>

        <p>
        <strong>{usuario.nome}</strong>
        parabéns por fazer sua conta conosco!
        </p>

        <p>
        Acesse o aplicativo para realizar seu login agora mesmo.
        </p>

        <p>
        <strong>Atenciosamente,</strong><br>
        Equipe CoraSafe
        </p>

        </body>
    </html>
    """
    ,
    "html",
    "utf-8"
    )

    emailConfirmacaoCadastro["Subject"] = "CoraSafe - Cadastro"
    emailConfirmacaoCadastro["From"] = remetente
    emailConfirmacaoCadastro["To"] = destinatario

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as servidor:
        servidor.login(remetente, senha_app)
        servidor.send_message(emailConfirmacaoCadastro)
    
      
    return {
        "idUsuario": novo_usuario.idUsuario
    }
    
    

#metodo de criação de ISFL
@rotaUsuarios.post("/ISFL")
def criarISFL(usuario: InstituicaoSFLSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    nova_instituicao = InstituicaoSFL(
        #idUsuario = 9,
        nomeISFl= usuario.nomeISFL,
        nomeResponsavel=usuario.nomeResponsavel,
        cnpj= usuario.cnpj,
        tipoUsuario= usuario.tipoUsuario,
        emailISFl= usuario.emailISFL,
        senha= usuario.senha,
        telefoneISFl= usuario.telefoneISFL,
        restricaoAlimentar = usuario.restricaoAlimentar
    )
    db.add(nova_instituicao)
    db.commit()
    
    #enviando para o email para confirmação de cadastro
    remetente = "cora.safequalitylife@gmail.com"
    senha_app = "vinvcjxfopxfnbbk"

    destinatario = usuario.emailISFL

    emailConfirmacaoCadastro = MIMEText(
    f"""
    <html>
        <body style="font-family: Arial, sans-serif;">

        <h2 style="color: #e53935;">Cadastro realizado com sucesso</h2>

        <p>
        <strong>{usuario.nomeISFL}</strong>
        parabéns por fazer sua conta conosco!
        </p>

        <p>
        Acesse o aplicativo para realizar seu login agora mesmo.
        </p>

        <p>
        <strong>Atenciosamente,</strong><br>
        Equipe CoraSafe
        </p>

        </body>
    </html>
    """
    ,
    "html",
    "utf-8"
    )

    emailConfirmacaoCadastro["Subject"] = "CoraSafe - Cadastro"
    emailConfirmacaoCadastro["From"] = remetente
    emailConfirmacaoCadastro["To"] = destinatario

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as servidor:
        servidor.login(remetente, senha_app)
        servidor.send_message(emailConfirmacaoCadastro)

    return {"mensagem": "Instituição salva"}

@rotaUsuarios.post("/vinculo_usuarioFamiliar_usuarioIdoso")
def criar_vinculo(vinculo: vinculo_usuarioFamiliar_usuarioIdosoSchema, db: Session = Depends(get_db)):
    db = SessionLocal()

    novo_vinculo = VinculoUsuarioFamiliarIdoso(
        
        idUsuarioFamiliar = vinculo.idUsuarioFamiliar,
        idUsuarioIdoso= vinculo.idUsuarioIdoso,  
        status = vinculo.status,
        
    )
    db.add(novo_vinculo)
    db.commit()
    db.refresh(novo_vinculo)
    
    print("ID DO VÍNCULO CRIADO:", novo_vinculo.idVinculoFamiliar)
    
    return{
        "idVinculoFamiliar": novo_vinculo.idVinculoFamiliar
    }


#metodo de login - leitura de dados no banco- user comum
@rotaUsuarios.post("/loginUserComum")
def loginUserComum(usuario: loginUsuarioComumSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuario)
        resultado = consulta.filter(Usuario.emailUsuario == usuario.emailUsuario, Usuario.senha == usuario.senha).first()
        
        if resultado is not None:
            return {
                "idUsuario": resultado.idUsuario,
                "nomeUsuario": resultado.nomeUsuario,
                "emailUsuario": resultado.emailUsuario,
                "telefone": resultado.telefone,
                "dataNascimentoUsuario": resultado.dataNascimentoUsuario,
                "emailFamiliar": resultado.emailFamiliar,
    
            }
        else:
            print('Usuário não encontrado')
            
    except HTTPException:
        print('Erro ao realizar login')
        
#metodo de login - leitura de dados no banco- user responsavel
@rotaUsuarios.post("/loginUserResponsavel")
def loginUserResponsavel(usuarioResponsavel: loginUsuarioFamiliarSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuariofamiliar)
        resultado = consulta.filter(Usuariofamiliar.emailFamiliar == usuarioResponsavel.emailFamiliar, Usuariofamiliar.senha == usuarioResponsavel.senha).first()
        
        if resultado is not None:
            return resultado
        else:
            print('Usuário responsável não encontrado')
            
    except HTTPException:
        print('')
        
        
@rotaUsuarios.post("/lendoDados")
def lendoDados(usuarioResponsavel: lendoDadosSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuariofamiliar)
        resultado = consulta.filter(Usuariofamiliar.emailFamiliar == usuarioResponsavel.emailFamiliar).first()
        
        if resultado is not None:
            return resultado
        else:
            print('Usuário responsável não encontrado')
            
    except HTTPException:
        print('')
        
#metodo de login - leitura de dados no banco - ISFL 
@rotaUsuarios.post("/loginUserISFL")
def loginUserISFL(usuarioISFL: loginISFLSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(InstituicaoSFL)
        resultado = consulta.filter(InstituicaoSFL.emailISFL == usuarioISFL.emailISFL, InstituicaoSFL.senha == usuarioISFL.senha).first()
        
        if resultado is not None:
            return resultado
        else:
            raise HTTPException(status_code=401,
                                detail='Instituição não encontrada')
            
    except HTTPException:
        raise
        
@rotaUsuarios.post("/lendoDadosUsuarioComum/{idUsuario}")
def lendoDadosUsuarioComum(idUsuario: int, db: Session = Depends(get_db)):
    try:
        consulta = db.query(Usuario)
        usuario = consulta.filter(Usuario.idUsuario == idUsuario).first()
        
        if usuario:
            return usuario.nomeUsuario
        
        raise HTTPException(
            status_code=404,
            detail="Usuário não encontrado")
        
    except HTTPException as e:
            print(f'Erro ao tentar atualizar informações do usuário.')

#lendo email de ICFL
@rotaUsuarios.post("/lendoDadosICFL/{idICFL_fk}")
def lendoDadosICFL(idICFL_fk: int, db: Session = Depends(get_db)):
    try:
        consulta = db.query(InstituicaoCFL)
        icfl = consulta.filter(InstituicaoCFL.idICFL == idICFL_fk).first()
        
        if icfl:
            print(icfl.emailICFL)
            return icfl.emailICFL
            
        raise HTTPException(
            status_code=404,
            detail="ICFL não encontrada")
        
    except HTTPException as e:
            print(f'Erro ao tentar ler informações do usuário.')

@rotaUsuarios.post("/lendoDadosNomeICFL/{idICFL_fk}")
def lendoDadosNomeICFL(idICFL_fk: int, db: Session = Depends(get_db)):
    try:
        consulta = db.query(InstituicaoCFL)
        icfl = consulta.filter(InstituicaoCFL.idICFL == idICFL_fk).first()
        
        if icfl:
            print(icfl.nomeICFL)
            return icfl.nomeICFL
            
        raise HTTPException(
            status_code=404,
            detail="ICFL não encontrada")
        
    except HTTPException as e:
            print(f'Erro ao tentar ler informações da instituição.')


#metodos de edição  de informações
#atualizar info User comum
@rotaUsuarios.put("/atualizando_informacoesUserComum/{idusuario}")
def atualizando_informacoesUserComum(idusuario:  int, dados_novos: atualizaUsuarioComumSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuario)
        usuario = consulta.filter(Usuario.idUsuario == idusuario).first()
        
        if usuario:            
            usuario.nomeUsuario = dados_novos.nomeUsuario
            usuario.emailUsuario = dados_novos.emailUsuario
            usuario.telefone = dados_novos.telefone
            usuario.emailFamiliar = dados_novos.emailFamiliar
            usuario.restricaoAlimentar = dados_novos.restricaoAlimentar
        db.commit() 
        return {"mensagem": "atualização feita com sucesso"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar atualizar informações do usuário.')
        
#atualizar info User comum
@rotaUsuarios.put("/atualizando_informacoesUserFamiliar/{idusuario}")
def atualizando_informacoesUserFamiliar(idusuario:  int, dados_novos: atualizaUsuarioFamiliarSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuariofamiliar)
        usuario = consulta.filter(Usuariofamiliar.idUsuario == idusuario).first()
        
        if usuario:            
            usuario.nome = dados_novos.nomeUsuario
            usuario.telefone = dados_novos.telefone
                
            db.commit() 
            return {"mensagem": "atualização feita com sucesso"}  
        else:
            return {"mensagem": "Usuário não encontrado"}         
    except HTTPException as e:
        print(f'Erro ao tentar atualizar informações do usuário.')      
        
#atualizar info User responsavel
@rotaUsuarios.put("/atualizando_campoFK/{idusuarioFm}")
def atualizando_campoFK(dados_novos: atualizandocampoUsuarioFamiliarSchema, idusuarioFm:  int, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuariofamiliar)
        usuario = consulta.filter(Usuariofamiliar.idUsuario == idusuarioFm).first()
        
        if usuario:
            usuario.idUsuarioComum = dados_novos.idUsuarioComum
    
            db.commit() 
            return {"mensagem": "Id de usuario idoso inserido na tabela de responsavel"} 
        else:
            return {"mensagem": "Id de usuario familiar não encontrado"}
                 
    except HTTPException as e:
        print(f'Erro ao tentar atualizar campo: {e}')
        
#atualizar info ISFL
@rotaUsuarios.put("/atualizandoISFL/{idISFL}")
def atualizandoISFL(idISFL:  int, dados_novos: atualizaISFLSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(InstituicaoSFL)
        isfl = consulta.filter(InstituicaoSFL.idISFL == idISFL).first()
        
        if isfl:            
            
            isfl.nomeISFL  = dados_novos.nomeISFL
            isfl.nomeResponsavel = dados_novos.nomeResponsavel
            isfl.emailISFL = dados_novos.emailISFL
            isfl.telefoneISFL = dados_novos.telefoneISFL
            
        db.commit() 
        return {"mensagem": "atualização feita com sucesso"}  
                 
    except HTTPException as e:
        print(f'Erro ao tentar atualizar informações do usuário.')

#busca do cpf na tabela
@rotaUsuarios.post("/verificaCPF")
def buscaCPF(cpf: buscaCPFUsuarioComumSchema, db: Session = Depends(get_db)):

    try: 
        #consultando a tabela de Usuario no banco
        consulta = db.query(Usuario)
        resultado = consulta.filter(Usuario.cpfUsuario == cpf.cpfUsuario).first()
        
        if resultado is not None:
            return {"idUsuario": resultado.idUsuario}
        return {"idUsuario": None}
            
    except HTTPException:
        print('')





