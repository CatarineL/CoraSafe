import 'package:flutter/material.dart';


class acessibilidade extends StatelessWidget {
  acessibilidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Acessibilidade")),
      appBar: AppBar(
        title: Text("Acessibilidade",
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