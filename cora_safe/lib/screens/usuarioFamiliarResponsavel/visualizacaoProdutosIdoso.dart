import 'package:cora_safe/classes/Produto.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';

class visualizacaoDispensaUserFamiliar extends StatefulWidget {
  const visualizacaoDispensaUserFamiliar({super.key});

  @override
  State<visualizacaoDispensaUserFamiliar> createState() =>
      _visualizacaoDispensaUserFamiliarState();
}

class _visualizacaoDispensaUserFamiliarState
    extends State<visualizacaoDispensaUserFamiliar> {

  @override
  void initState() {
    super.initState();

    //variaveis
    final idUsuario = Provider.of<Usuarioprovider>(context, listen: false).idUsuario.text;

    //chamada das funções e incluindo os parametros
    Provider.of<Produtoprovider>(context, listen: false).lendoItens(idUsuario);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Produtoprovider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispensa Atual do(a) Idoso(a)",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child:
        ListView.builder(
          itemCount: controller.produtos.length,
          itemBuilder: (context, index) {

            //Produto produto = produtos[index];
            final produto = controller.produtos[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),

              child:
              ListTile(
                title: Text(produto.nomeProduto),

                subtitle: Text(
                  "Validade: ${produto.validadeProduto ?? '__/__/____'}",
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    IconButton(
                      icon: const Icon(Icons.edit),
                      iconSize: 20,
                      onPressed: () {
                        //função de editar
                        controller.editarProduto(produto.idProduto, produto.nomeProduto, produto.validadeproduto);
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 20,
                      onPressed: () {
                        //função de excluir
                        controller.excluirProduto(produto.idProduto);
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