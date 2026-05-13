import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:flutter/material.dart';
import '../classes/Usuario.dart';
import '../classes/UsuarioProvider.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';


class criarSenhaUserResponsavel extends StatelessWidget {

  criarSenhaUserResponsavel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<UsuariofamiliarProvider>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
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
                  controller.criarUsuario();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
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