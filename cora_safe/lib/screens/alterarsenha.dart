import 'package:flutter/material.dart';


class alterarSenha extends StatelessWidget {
  alterarSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Alteração de Senha")),
      appBar: AppBar(
        title: Text("Alterar senha",
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