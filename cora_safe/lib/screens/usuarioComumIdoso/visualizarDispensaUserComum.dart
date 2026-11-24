import 'package:cora_safe/classes/NotificacaoProvider.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';

import '../../classes/MedicamentoProvider.dart';
import '../../classes/Notificacao.dart';

class visualizacaoDispensaUserComum extends StatefulWidget {
  const visualizacaoDispensaUserComum({super.key});

  @override
  State<visualizacaoDispensaUserComum> createState() =>
      _visualizacaoDispensaUserComumState();
}

class _visualizacaoDispensaUserComumState
    extends State<visualizacaoDispensaUserComum> {
  @override
  void initState() {
    super.initState();

    //variaveis
    final idUsuario = Provider.of<Usuarioprovider>(
      context,
      listen: false,
    ).idUsuario.text;

    Provider.of<Produtoprovider>(context, listen: false).lendoItens(idUsuario);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //variaveis
      final idUsuario = Provider.of<Usuarioprovider>(
        context,
        listen: false,
      ).idUsuario.text;

      //chamada das funções e incluindo os parametros
      int diferencaDiasNotificacao = 0;
      var mensagem = "";
      DateTime agora = DateTime.now();
      var envio = "Enviado";
      final controllerNotificacao = context.read<Notificacao>();
      final controllerNotificacaoProvider = context.read<NotificacaoProvider>();
      final produtos = await Provider.of<Produtoprovider>(
        context,
        listen: false,
      ).lendoItens(idUsuario);

      for (final produto in produtos) {
        final validade = produto.validadeProduto;

        if (validade != null && validade != "") {
          var data = DateFormat('dd/MM/yyyy').parse(validade!);
          diferencaDiasNotificacao = data.difference(DateTime.now()).inDays;
          bool verifica;
          //preenchendo as listas
          if (diferencaDiasNotificacao == 0 || diferencaDiasNotificacao == 1) {
            mensagem =
            "${produto.nomeProduto} - Válido até ${produto.validadeProduto}";
            controllerNotificacao.idUsuario_fk = idUsuario;
            controllerNotificacao.idProduto_fk = produto.idProduto;
            controllerNotificacao.Mensagem = mensagem;
            controllerNotificacao.dataCriacao = agora;
            controllerNotificacao.Status = envio;
            verifica = await (controllerNotificacaoProvider
                .verificaNotificacaoProduto(produto.idProduto!));

            print('Produto: ${produto.nomeProduto}');
            print('Validade: ${produto.validadeProduto}');
            print('Dias até vencer: $diferencaDiasNotificacao');
            print('Notificação já existe: $verifica');
            print('idUsuario já existe: $idUsuario');

            if (verifica == false && produto.validadeProduto!=null) {
              print('Criando notificação para ${produto.nomeProduto}');
              print(
                'ID enviado na notificação: '
                    '"${controllerNotificacao.idUsuario_fk}"',
              );
              await controllerNotificacaoProvider.criarNotificacao(
                  controllerNotificacao.idUsuario_fk!,
                  null,
                  null,
                  controllerNotificacao.idProduto_fk!,
                  controllerNotificacao.Mensagem,
                  controllerNotificacao.Status,
                  controllerNotificacao.dataCriacao!,
                  null
              );

            }
          } else if (diferencaDiasNotificacao > 1 &&
              diferencaDiasNotificacao <= 3) {
            mensagem =
            "${produto.nomeProduto} - Válido até ${produto.validadeProduto}";
            controllerNotificacao.idUsuario_fk = idUsuario;
            controllerNotificacao.idProduto_fk = produto.idProduto;
            controllerNotificacao.Mensagem = mensagem;
            controllerNotificacao.dataCriacao = agora;
            controllerNotificacao.Status = envio;
            verifica = await controllerNotificacaoProvider
                .verificaNotificacaoProduto(produto.idProduto!);

            print('Produto: ${produto.nomeProduto}');
            print('Validade: ${produto.validadeProduto}');
            print('Dias até vencer: $diferencaDiasNotificacao');
            print('Notificação já existe: $verifica');
            print('idUsuario já existe: $idUsuario');

            if (verifica == false && produto.validadeProduto!=null) {
              print('Criando notificação para ${produto.nomeProduto}');
              print(
                'ID enviado na notificação: '
                    '"${controllerNotificacao.idUsuario_fk}"',
              );
              await controllerNotificacaoProvider.criarNotificacao(
                  controllerNotificacao.idUsuario_fk!,
                  null,
                  null,
                  controllerNotificacao.idProduto_fk!,
                  controllerNotificacao.Mensagem,
                  controllerNotificacao.Status,
                  controllerNotificacao.dataCriacao!,
                  null
              );

            }
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final controllerProduto = context.watch<Produtoprovider>();
    final controllerNotificacaoProvider = context.watch<NotificacaoProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispensa Atual",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: controllerProduto.produtos.length,
          itemBuilder: (context, index) {
            final produto = controllerProduto.produtos[index];
            bool value = false;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),

              child: ListTile(
                leading: Checkbox(
                  value: produto.statusProduto ?? false,
                  onChanged: (bool? novoValor) {
                    DateTime hoje = DateTime.now();
                    String dataAtual = hoje.toIso8601String();
                    setState(() {
                      produto.statusProduto = novoValor ?? false;
                      //metodo de atualizar status
                      controllerProduto.editarProduto(
                        produto.idProduto,
                        produto.nomeProduto,
                        produto.validadeproduto,
                        dataAtual,
                        produto.statusProduto,
                      );
                    });
                  },
                  //shape: const CircleBorder(),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                ),
                title: Text(produto.nomeProduto),

                subtitle: Text(
                  "Data de Validade: ${produto.validadeProduto}",
                  style: TextStyle(fontSize: 12),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(
                      //btn de edição
                      icon: const Icon(Icons.edit),
                      iconSize: 20,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            TextEditingController nomeProdutoNovo =
                                TextEditingController(
                                  text: produto.nomeProduto,
                                );
                            TextEditingController dataValidade =
                                TextEditingController(
                                  text: produto.validadeProduto,
                                );

                            var data;

                            return AlertDialog(
                              title: Text('Atualização de item'),
                              actions: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Nome do item:",
                                  ),
                                  controller: nomeProdutoNovo,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Validade do item:",
                                  ),
                                  controller: dataValidade,
                                  onTap: () async {
                                    data = (await showDatePicker(
                                      context: dialogContext,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                      locale: const Locale('pt', 'BR'),
                                    ));
                                    if (data != null) {
                                      //formatando a data escolhida
                                      dataValidade.text =
                                          "${data.day.toString().padLeft(2, '0')}/"
                                          "${data.month.toString().padLeft(2, '0')}/"
                                          "${data.year}";
                                    }
                                  },
                                ),

                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(dialogContext, "Confirmar");
                                    bool verifica;
                                    String mensagem;
                                    controllerProduto.editarProduto(
                                      produto.idProduto,
                                      nomeProdutoNovo.text,
                                      dataValidade.text,
                                      produto.dataConsumo,
                                      produto.statusProduto ?? false,
                                    );
                                    verifica =
                                        await (controllerNotificacaoProvider
                                            .verificaNotificacaoProduto(
                                              produto.idProduto!,
                                            ));

                                    mensagem =
                                        "${nomeProdutoNovo.text} - Válido até: ${dataValidade.text}";

                                    if (verifica == true) {
                                      String? idNot =
                                          await controllerNotificacaoProvider
                                              .retornoIdNotificacaoProduto(
                                                produto.idProduto,
                                              );

                                      if (idNot != null) {
                                        await controllerNotificacaoProvider
                                            .atualizaNotificacao(
                                              int.parse(idNot),
                                              mensagem,
                                            );
                                      } else {
                                        print(
                                          "ID da notificação não encontrado para o produto",
                                        );
                                      }
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Atualizado!'),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent[400],
                                  ),
                                  child: Text(
                                    "Confirmar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Cancelar"),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent[400],
                                  ),
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 20,
                      onPressed: () {
                        //função de excluir
                        controllerProduto.excluirProduto(produto.idProduto);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Produto excluído com sucesso!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
