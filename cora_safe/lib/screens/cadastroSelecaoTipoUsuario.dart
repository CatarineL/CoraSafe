import 'package:flutter/material.dart';
import 'formularioUser.dart';

class CadastroSelecaoTipoUsuario extends StatelessWidget {
  CadastroSelecaoTipoUsuario({super.key});

  bool sim = false, nao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                const SizedBox(height: 280),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    Expanded(
                      child: Text(
                        "Instituição/Asilo",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // sim
                    Row(
                      children: [
                        const Text("Sim"),
                        Radio<String>(
                          value: "sim",
                          //groupValue: escolha,
                          onChanged: (value) {
                            //setState(() => escolha = value);
                          },
                        ),
                      ],
                    ),

                    // não
                    Row(
                      children: [
                        const Text("Não"),
                        Radio<String>(
                          value: "nao",
                          //groupValue: escolha,
                          onChanged: (value) {
                            //setState(() => escolha = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),


                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormularioUser(),
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
