import 'package:flutter/material.dart';

class notificacoesFamiliar extends StatelessWidget {
  notificacoesFamiliar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Prato do Dia")),
      appBar: AppBar(
        title: Text("Notificações",
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