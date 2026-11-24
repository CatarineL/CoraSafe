import 'package:flutter/material.dart';
import 'package:cora_safe/classes/Produto.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:provider/provider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:intl/intl.dart';
import '../../classes/Notificacao.dart';
import '../../classes/NotificacaoProvider.dart';
import '../../classes/servicoNotificacao.dart';

class itensValidadeProximaUserComum extends StatefulWidget {
  const itensValidadeProximaUserComum({super.key});

  @override
  State<itensValidadeProximaUserComum> createState() =>
      _itensValidadeProximaUserComumState();
}

class _itensValidadeProximaUserComumState
    extends State<itensValidadeProximaUserComum> {
  int filtroBotoes = 0;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = context.watch<Produtoprovider>();
    int diferencaDias = 0;
    final List<Produto> produtosDia1 = [];
    final List<Produto> produtosDias3 = [];
    List<Produto> listaExibicao = [];

    for (final produto in controller.produtos) {
      final validade = produto.validadeProduto;

      if (validade != null && validade != "") {
        var data = DateFormat('dd/MM/yyyy').parse(validade!);
        diferencaDias = data.difference(DateTime.now()).inDays;

        //preenchendo as listas
        if (diferencaDias == 0 || diferencaDias == 1) {
          produtosDia1.add(produto);
        } else if (diferencaDias > 1 && diferencaDias <= 3) {
          produtosDias3.add(produto);
        }
      }
    }
    if (filtroBotoes == 0) {
      //todos os produtos
      listaExibicao = produtosDia1 + produtosDias3;
    } else if (filtroBotoes == 1) {
      listaExibicao = produtosDia1;
    } else if (filtroBotoes == 3) {
      listaExibicao = produtosDias3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Itens com valildade próxima",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("#Todos"),
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Hoje/1 Dia",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 3;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("3 Dias", style: TextStyle(color: Colors.black)),
                ),

                SizedBox(width: 10),
              ],
            ),

            Divider(),
            Expanded(
              //height: 300,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: listaExibicao.length,
                  itemBuilder: (context, index) {
                    final produto = listaExibicao[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),

                      child: ListTile(
                        title: Text(produto.nomeProduto),
                        subtitle: Text(
                          "Válido até: ${produto.validadeProduto}",
                          style: TextStyle(color: Colors.redAccent[400]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
