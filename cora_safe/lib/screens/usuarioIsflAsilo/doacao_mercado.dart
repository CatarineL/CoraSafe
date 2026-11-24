import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../classes/Doacao.dart';
import '../../classes/DoacaoProvider.dart';
import '../../classes/InstituicaoCFLProvider.dart';
import '../../classes/InstituicaoSFLProvider.dart';

class DoacaoMercado extends StatelessWidget {
  DoacaoMercado({super.key});

  @override
  Widget build(BuildContext context) {
    final controller_isfl = context.read<InstituicaosflProvider>();
    final controller_doacaoSolicitacao = context.read<Doacao>();
    final controller_doacaoSolicitacaoMetodo = context.read<DoacaoProvider>();
    final controller_icfl = context.read<Instituicaocflprovider>();
    final mensagemS = TextEditingController();
    String idICFL = "4";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Solicitação de Doação - Mercado",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Faça seu pedido para o mercado",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      //background local
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.shopping_cart, size: 20),
                  title: Text(
                    'Mercado Savegnago',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  height: 150,
                  child: TextFormField(
                    controller: mensagemS,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Digite aqui sua mensagem',
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller_doacaoSolicitacao.idISFL_fk =
                          int.parse(controller_isfl.idISFL.text);
                      controller_doacaoSolicitacao.idICFL_fk = int.parse(idICFL);
                      controller_doacaoSolicitacao.mensagemSolicitacao = mensagemS.text;
                      controller_doacaoSolicitacao.dataSolicitacao =
                          DateFormat('dd/MM/yyyy').format(DateTime.now());
                      controller_doacaoSolicitacao.statusSolicitacao =
                      "Em andamento";
                      controller_doacaoSolicitacao.emailISFL_fk =
                          controller_isfl.emailISFL.text;
                      final email = await controller_icfl.lendoDados(idICFL);
                      if (email != null && email.isNotEmpty) {
                        controller_doacaoSolicitacao.emailICFL_fk =
                        await email;
                        await controller_doacaoSolicitacaoMetodo
                            .criarSolicitacaoDoacao(
                            controller_doacaoSolicitacao.idISFL_fk,
                            controller_doacaoSolicitacao.idICFL_fk,
                            controller_doacaoSolicitacao.mensagemSolicitacao,
                            controller_doacaoSolicitacao.dataSolicitacao,
                            controller_doacaoSolicitacao.statusSolicitacao,
                            controller_doacaoSolicitacao.emailISFL_fk,
                            controller_doacaoSolicitacao.emailICFL_fk
                        );
                        await controller_doacaoSolicitacaoMetodo
                            .envioSolicitacaoDoacaoEmail(
                          controller_isfl.nomeISFL.text,
                          controller_isfl.nomeResponsavel.text,
                          controller_isfl.telefoneISFL.text,
                          controller_doacaoSolicitacao.emailISFL_fk!,
                          email!,
                          controller_doacaoSolicitacao.mensagemsolicitacao,
                        );
                        controller_doacaoSolicitacao.mensagemSolicitacao = '';
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Solicitação enviada com sucesso'),
                          ),
                        );
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Enviar pedido"),
                  ),
                ),
              ],
            ),

            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '©CoraSafe - Todos os Direitos Reservados',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
