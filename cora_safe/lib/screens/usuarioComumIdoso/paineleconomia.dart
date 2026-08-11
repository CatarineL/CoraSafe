import 'package:flutter/material.dart';


class Paineleconomia extends StatelessWidget {
  Paineleconomia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Painel de Economia")),
      appBar: AppBar(
        title: Text("Painel de Economia",
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