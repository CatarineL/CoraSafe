import 'package:flutter/material.dart';


class Doacoes extends StatelessWidget {
  Doacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Doações")),
      appBar: AppBar(
        title: Text("Doações",
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