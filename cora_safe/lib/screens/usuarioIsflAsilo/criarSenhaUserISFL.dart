import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/loginUserISFL.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class criarSenhaUserISFL extends StatelessWidget {

  criarSenhaUserISFL({super.key});

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
                obscureText: true,
                controller: controller.senha,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Criar senha:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                //recebendo o valor recebido pelo usuario em controller
                obscureText: true,
                controller: controller.senha,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Confirmar senha:',
                ),
              ),
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  print("Botão clicado");
                  controller.criarISFL();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginUserISFL(),
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
                child: const Text("Confirmar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}