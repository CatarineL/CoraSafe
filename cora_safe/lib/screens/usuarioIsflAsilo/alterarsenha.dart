import 'package:flutter/material.dart';


class alterarsenha extends StatelessWidget {
  alterarsenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Painel de Economia")),
      appBar: AppBar(
        title: Text("Alterar Senha",
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