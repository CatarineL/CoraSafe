import 'package:cora_safe/screens/acessibilidade.dart';
import 'package:cora_safe/screens/ajuda.dart';
import 'package:cora_safe/screens/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:cora_safe/screens/seguranca.dart';
import 'package:cora_safe/screens/meusDadosUserPrincipal.dart';

class perfilUser extends StatelessWidget {
  perfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil",
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

            //pagina de meus dados
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Meus Dados'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => meusDados(),
                  ),
                );

              },
            ),
            Divider(),
            //segurança
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Segurança'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => seguranca(),
                  ),
                );

              },
            ),
            Divider(),
            //preferencias
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Preferências'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => preferencias(),
                  ),
                );

              },
            ),
            Divider(),
            //acessibilidade
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Acessibilidade'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => acessibilidade(),
                  ),
                );

              },
            ),
            Divider(),
            //ajuda
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Ajuda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ajuda(),
                  ),
                );

              },
            ),
            Divider(),
            //sair - botão
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Sair'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => meusDados(),
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
