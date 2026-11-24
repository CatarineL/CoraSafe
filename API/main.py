from fastapi import FastAPI
app = FastAPI()
from app.rotas import users, medicamentos, produto, notificacao, restricao_usuario_comum, sugestaoPrato, sugestaoPrato_usuario_isfl, doacoes, relatorioSemanal, relatorioSemanalSugestaoPrato


app.include_router(users.rotaUsuarios)
app.include_router(medicamentos.rotaMedicamento)
app.include_router(produto.rotaProduto)
app.include_router(notificacao.rotaNotificacao)
app.include_router(restricao_usuario_comum.rotarestricao_usuario_comum)
app.include_router(sugestaoPrato.rotasugestao_prato)
app.include_router(sugestaoPrato_usuario_isfl.rotasugestao_prato_usuario_isfl)
app.include_router(doacoes.rotaDoacoes)
app.include_router(relatorioSemanal.rotaRelatorioSemanal)
app.include_router(relatorioSemanalSugestaoPrato.rotaRelatorioSemanalSugestaoPrato)