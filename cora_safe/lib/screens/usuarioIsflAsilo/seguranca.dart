import 'package:cora_safe/screens/usuarioIsflAsilo/alterarsenha.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/excluirconta.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/politicaprivacidade.dart';
import 'package:flutter/material.dart';


class Seguranca extends StatelessWidget {
  Seguranca({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Segurança",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            //pagina de alterar senha
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Alterar senha'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => alterarsenha(),
                  ),
                );

              },
            ),
            Divider(),
            //Política de Privacidade
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Política de Privacidade'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => politicaPrivacidade(),
                  ),
                );

              },
            ),
            Divider(),
            //Excluir conta
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Excluir conta'),
              onTap: () {

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