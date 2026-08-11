import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                    child: TextFormField(
                      controller: controller.restricao,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Possui alguma restrição alimentar? (Sim/Não)',
                      ),
                    ),
                  ),

                  Spacer(),
                  //continuar
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {//caso o usuario tenha uma ou mais restrições
                        //if (controller.restricao == "Sim"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => criarSenhaUsuarioComum()
                            ),
                          );
                        //}

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
              ],
        ),
    ),
    );
  }
}