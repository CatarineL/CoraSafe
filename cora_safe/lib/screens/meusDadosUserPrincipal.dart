import 'package:flutter/material.dart';

import 'edicaoDadosUserPrincipal.dart';


class meusDados extends StatelessWidget {
  meusDados({super.key});

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
          Text('Minhas informações',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15)),
          Text('Nome de Usuário: Kaiane Los G S',
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black, fontSize: 15)),
          Text('E-mail: kaianelopes74@gmail.com',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 15)),
          Text('Telefone: (**) 9****-****',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 15)),
          Text('Data de Nascimento:  __/__/____',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 15)),
          Text('E-mail de familiar: user123@gmail.com',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 15)),

          //SizedBox(height: 380,),

          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => edicaoDadosUserPrincipal(),
                   ),
                 );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Editar"),
            ),
          ),

        Spacer(),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Center(
            child: Text(
              '©CoraSafe',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ),

        ],

        ),
      ),
      );

  }
}