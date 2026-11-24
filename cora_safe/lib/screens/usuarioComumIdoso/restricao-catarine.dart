import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/loginUserComum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../botoes.dart';
import 'criarSenhaUsuarioComum.dart';

class Restricao extends StatelessWidget {
  Restricao({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<Usuarioprovider>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Possui alguma restrição alimentar? (Sim/Não)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: controller.restricao,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            //continuar
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    //caso o usuario tenha uma ou mais restrições

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => criarSenhaUsuarioComum(),
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
            ),
          ],
        ),
      ),
    );
  }
}
