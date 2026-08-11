import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/edicaoDadosUserFamiliar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/UsuarioFamiliar.dart';


class meusDadosFamiliar extends StatelessWidget {
  meusDadosFamiliar({super.key});

  @override
  Widget build(BuildContext context) {
    var controller_userFamiliar = context.read<UsuariofamiliarProvider>();

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
              'Nome: ${controller_userFamiliar.nome.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'E-mail: ${controller_userFamiliar.emailFamiliar.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'Telefone: ${controller_userFamiliar.telefone.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'Data de Nascimento: ${controller_userFamiliar.dataNascimento.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'E-mail de familiar: ${controller_userFamiliar.emailFamiliar.text}',
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
                      builder: (context) => edicaoDadosUserFamiliar(),
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
