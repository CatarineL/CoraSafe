import 'package:flutter/material.dart';


class Ajuda extends StatelessWidget {
  Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajuda")),
      body: Center(
        child: Text("Você chegou aqui!"),
      ),

    );

  }
}