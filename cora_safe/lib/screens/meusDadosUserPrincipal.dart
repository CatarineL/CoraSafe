import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../classes/UsuarioProvider.dart';
import 'edicaoDadosUserPrincipal.dart';

class meusDados extends StatelessWidget {
  meusDados({super.key});

  @override
  Widget build(BuildContext context) {
    var controller_userComum = context.read<Usuarioprovider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus dados",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minhas informações',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15)
            ),
            SizedBox(height: 50,),
            Text(
              'Nome: ${controller_userComum.nomeUsuario.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'E-mail: ${controller_userComum.emailPessoal.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'Telefone: ${controller_userComum.telefone.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'Data de Nascimento: ${controller_userComum.dataNascimento.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'E-mail de familiar: ${controller_userComum.emailFamiliar.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),


            Spacer(),
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
