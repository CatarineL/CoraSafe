import 'package:flutter/material.dart';


class categoriasItens extends StatelessWidget {
  categoriasItens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Categorias favoritas de Itens")),
      appBar: AppBar(
        title: Text("Categorias favoritas de Itens",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text("Você chegou aqui!"),
      ),

    );

  }
}