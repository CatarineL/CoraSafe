import 'package:cora_safe/screens/usuarioComumIdoso/perguntas.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/reportarproblema.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/versaoapp.dart';
import 'package:flutter/material.dart';


class Ajuda extends StatelessWidget {
  Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajuda",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       border: UnderlineInputBorder(),
            //       labelText: 'Nome completo:',
            //     ),
            //   ),
            // ),

            //pagina de perguntas frequentes
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Perguntas Frequentes'),
              subtitle: Text('Tire suas dúvidas sobre o CoraSafe'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => perguntas(),
                  ),
                );

              },
            ),
            Divider(),
            //Reportar Problema
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Reportar Problema'),
              subtitle: Text('Entre em contato conosco'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => reportarProblema(),
                  ),
                );

              },
            ),
            Divider(),
            //versao do app
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Versão ao Aplicativo'),
              subtitle: Text('CoraSafe v1.0.0'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => versaoApp(),
                  ),
                );

              },
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '©CoraSafe',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),

            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }

}