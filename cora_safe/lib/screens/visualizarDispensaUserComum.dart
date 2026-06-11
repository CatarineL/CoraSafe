import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'dart:convert';

class visualizacaoDispensaUserComum extends StatelessWidget {
  visualizacaoDispensaUserComum({super.key});


  @override
  Widget build(BuildContext context) {
    //final List<String> entries = <String>['A', 'B', 'C'];
    final controller = context.watch<Produtoprovider>();

    //final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dispensa Atual",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.black26,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    body: Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
        Expanded(
          //versão anterior
          /*child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: controller.produtos.length,
            itemBuilder: (BuildContext context, int index) {
            return Container(
              //height: 30,
              //color: Colors.redAccent[colorCodes[index]],
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      //height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //chamada da função
                          controller.lendoItens();
                        },
                        icon: const Icon(Icons.edit),
                        //icon: const Icon(Icons.delete),
                        //controller: controller.nomeProduto,
                        label: Text(
                            controller.produtos[index].nomeProduto,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          alignment: Alignment.center,
                          iconAlignment: IconAlignment.end,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                  ),
                ],
            ),

        ),
            );
      },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),*/
            child: FutureBuilder(
              future: controller.lendoItens(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.produtos.length,
                  itemBuilder: (context, index) {

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: Text(
                          controller.produtos[index].nomeProduto,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                );
              },
            ),
          ),
      SizedBox(
        width: double.infinity,
        height: 30,
        child: ElevatedButton(

          onPressed: () {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Restricao(),
                    ),
                  );*/
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent[400],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Confirmar"),
        ),
      ),
    ],
        ),
      ),
    );

  }
}