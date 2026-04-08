import 'package:cora_safe/screens/categoriasitens.dart';
import 'package:cora_safe/screens/notificacoes.dart';
import 'package:cora_safe/screens/tema.dart';
import 'package:cora_safe/screens/unidadesmedida.dart';
import 'package:flutter/material.dart';


class preferencias extends StatelessWidget {
  preferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferências",
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

            //pagina de tema de tela
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Tema'),
              subtitle: Text('Claro ou Escuro'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => tema(),
                  ),
                );

              },
            ),
            Divider(),
            //notificações
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Notificações'),
              subtitle: Text('Push, E-mail ou WhasApp'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => notificacoes(),
                  ),
                );

              },
            ),
            Divider(),
            //unidades de medida
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Unidades de Medida'),
              subtitle: Text('Kg, g, Ml'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => unidadesMedida(),
                  ),
                );

              },
            ),
            Divider(),
            //categorias favoritas de itens
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text('Categorias favoritas de Itens'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => categoriasItens(),
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