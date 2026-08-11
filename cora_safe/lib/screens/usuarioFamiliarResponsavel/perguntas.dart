import 'package:flutter/material.dart';


class perguntas extends StatelessWidget {
  perguntas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Perguntas Frequentes")),
      appBar: AppBar(
        title: Text("Perguntas Frequentes",
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