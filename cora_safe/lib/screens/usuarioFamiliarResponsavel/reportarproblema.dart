import 'package:flutter/material.dart';


class reportarProblema extends StatelessWidget {
  reportarProblema({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Reportar Problema")),
      appBar: AppBar(
        title: Text("Reportar problema",
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