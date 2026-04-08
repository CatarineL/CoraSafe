import 'package:flutter/material.dart';


class tema extends StatelessWidget {
  tema({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Tema")),
      appBar: AppBar(
        title: Text("Tema",
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