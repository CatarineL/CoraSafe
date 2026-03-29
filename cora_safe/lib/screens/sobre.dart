import 'package:flutter/material.dart';


class Sobre extends StatelessWidget {
  Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sobre")),
      body: Center(
        child: Text("Você chegou aqui!"),
      ),

    );

  }
}