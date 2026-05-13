import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/screens/restricao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'criarSenhaUserISFL.dart';


class FormularioUserInstituicao extends StatelessWidget {
  FormularioUserInstituicao({super.key});

  // //criando variaveis do formulario
  // final TextEditingController nomeInstitucional = TextEditingController();
  // final TextEditingController nomeResponsavel = TextEditingController();
  // final TextEditingController cnpj = TextEditingController();
  // final TextEditingController telefoneInstitucional = TextEditingController();
  // final TextEditingController emailInstitucional = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<InstituicaosflProvider>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.nomeISFL,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome Institucional:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.nomeResponsavel,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome do responsável:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.cnpj,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'CNPJ:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.telefoneISFL,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Telefone Institucional:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.emailISFL,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail Institucional:',
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => Restricao(),
                      builder: (context) => criarSenhaUserISFL(),
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
                child: const Text("Continuar"),
              ),
            ),

            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
