// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
// child: TextFormField(
// decoration: const InputDecoration(
// border: UnderlineInputBorder(),
// labelText: 'Confirmar senha:',
// ),
// ),
// ),
//
// Spacer(),

import 'package:flutter/material.dart';


class edicaoDadosUserPrincipal extends StatelessWidget {
  edicaoDadosUserPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus dados",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ]

        ),
      ),
    );
  }

}