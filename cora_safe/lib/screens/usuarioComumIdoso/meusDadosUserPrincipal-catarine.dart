import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/UsuarioProvider.dart';

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
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(height: 50),
            Text(
              'Nome: ${controller_userComum.nomeUsuario.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'E-mail: ${controller_userComum.emailPessoal.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'Telefone: ${controller_userComum.telefone.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'E-mail de familiar: ${controller_userComum.emailFamiliar}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'Restrição Alimentar: ${controller_userComum.restricao.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),

            Spacer(),
            //SizedBox(height: 380,),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      TextEditingController nomeUsuarioNovo =
                          TextEditingController(
                            text: controller_userComum.nomeUsuario.text,
                          );
                      TextEditingController emailUserComum =
                          TextEditingController(
                            text: controller_userComum.emailpessoal,
                          );
                      TextEditingController telefone = TextEditingController(
                        text: controller_userComum.telefone.text,
                      );
                      TextEditingController emailFamiliar =
                          TextEditingController(
                            text: controller_userComum.emailFamiliar,
                          );
                      TextEditingController restriAlimentar =
                          TextEditingController(
                            text: controller_userComum.restricao.text,
                          );


                      return AlertDialog(
                        title: Text('Editar Informações'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(labelText: "Nome"),
                              controller: nomeUsuarioNovo,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "E-mail pessoal",
                              ),
                              controller: emailUserComum,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Telefone",
                              ),
                              controller: telefone,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "E-mail familiar",
                              ),
                              controller: emailFamiliar,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Restrição Alimentar",
                              ),
                              controller: restriAlimentar,
                            ),

                            TextButton(
                              onPressed: () async {
                                Navigator.pop(dialogContext, "Confirmar");
                                controller_userComum.editarInformacaoUserComum(
                                  controller_userComum.idUsuario.text,
                                  nomeUsuarioNovo.text,
                                  emailUserComum.text,
                                  telefone.text,
                                  emailFamiliar.text,
                                  restriAlimentar.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Atualizado!')),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent[400],
                              ),
                              child: Text(
                                "Confirmar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, "Cancelar"),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent[400],
                              ),
                              child: Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
