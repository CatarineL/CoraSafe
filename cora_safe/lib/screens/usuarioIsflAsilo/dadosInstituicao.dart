import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dadosInstituicao extends StatelessWidget {
  dadosInstituicao({super.key});

  @override
  Widget build(BuildContext context) {
    final controller_isfl = context.watch<InstituicaosflProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dados da Instituição",
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
              'Informações Gerais',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(height: 50),
            Text(
              'Nome da Instituição: ${controller_isfl.nomeISFL.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'Nome do Responsável: ${controller_isfl.nomeResponsavel.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'E-mail Institucional:\n${controller_isfl.emailISFL.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'Telefone Institucional: ${controller_isfl.telefoneISFL.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40),
            Text(
              'CNPJ: ${controller_isfl.cnpj.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      TextEditingController nomeISFLNovo =
                      TextEditingController(
                        text: controller_isfl.nomeISFL.text,
                      );
                      TextEditingController nomeResponsavelNovo = TextEditingController(
                        text: controller_isfl.nomeResponsavel.text,
                      );
                      TextEditingController emailISFL =
                      TextEditingController(
                        text: controller_isfl.emailISFL.text,
                      );
                      TextEditingController telefone = TextEditingController(
                        text: controller_isfl.telefoneISFL.text,
                      );

                      return AlertDialog(
                        title: Text('Editar Informações'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(labelText: "Nome da Instituição"),
                              controller: nomeISFLNovo,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Nome do Responsável",
                              ),
                              controller: nomeResponsavelNovo,
                            ),
                            TextField(
                              decoration: InputDecoration(labelText: "E-mail da Instituição"),
                              controller: emailISFL,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Telefone",
                              ),
                              controller: telefone,
                            ),

                            TextButton(
                              onPressed: () async {
                                Navigator.pop(dialogContext, "Confirmar");
                                print("DADOSSSS ");
                                await controller_isfl
                                    .editarInformacaoISFL(
                                 int.parse(controller_isfl
                                      .idISFL
                                      .text),
                                  nomeISFLNovo.text,
                                  nomeResponsavelNovo.text,
                                  emailISFL.text,
                                  telefone.text
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
