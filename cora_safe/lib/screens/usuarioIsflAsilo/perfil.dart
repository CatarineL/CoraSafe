import 'package:cora_safe/screens/usuarioIsflAsilo/acessibilidade.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/ajuda.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/dadosInstituicao.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/seguranca.dart';

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

            //pagina de meus dados
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Dados da Instituição'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dadosInstituicao(),
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
                    builder: (context) => Seguranca(),
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
                    builder: (context) => Acessibilidade(),
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