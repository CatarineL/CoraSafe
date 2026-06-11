import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/tipoRestricao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                   // Row(
                   //   children: [
                   //     SizedBox(height: 40,),
                   //     Expanded(
                   //       child: Text(
                   //         "Restrição Alimentar",
                   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                   //         overflow: TextOverflow.ellipsis,
                   //       ),
                   //     ),
                   //
                   //     // sim
                   //     Row(
                   //       children: [
                   //         const Text("Sim"),
                   //         Radio<String>(
                   //           value: "sim",
                   //           //groupValue: escolha,
                   //           onChanged: (value) {
                   //             //setState(() => escolha = value);
                   //           },
                   //         ),
                   //       ],
                   //     ),
                   //
                   //    // não
                   //     Row(
                   //       children: [
                   //         const Text("Não"),
                   //         Radio<String>(
                   //           value: "nao",
                   //           //groupValue: escolha,
                   //           onChanged: (value) {
                   //             //setState(() => escolha = value);
                   //           },
                   //         ),
                   //       ],
                   //     ),
                   //   ],
                   // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: controller.restricao,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Possui alguma restrição alimentar?',
                      ),
                    ),
                  ),

                  Spacer(),
                  //continuar
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => tipoRestricao(),
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
              ],
        ),
    ),
    );
  }
}