import 'package:flutter/material.dart';


class politicaPrivacidade extends StatelessWidget {
  politicaPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Política de Privacidade")),
      appBar: AppBar(
        title: Text("Política de Privacidade",
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