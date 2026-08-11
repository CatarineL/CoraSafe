import 'package:flutter/material.dart';


class raizesEasas extends StatelessWidget {
  raizesEasas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Raízes e Asas")),
      appBar: AppBar(
        title: Text("Raízes e Asas",
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