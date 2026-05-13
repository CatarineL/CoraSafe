import 'formularioUserResponsavel.dart';
import 'formularioUserComum.dart';
import 'formularioUserInstituicao.dart';
import 'package:flutter/material.dart';


class CadastroSelecaoTipoUsuario extends StatelessWidget {
  CadastroSelecaoTipoUsuario({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
              children: [

                SizedBox(height: 220),

                //pessoa 60+
                SizedBox(
                  width: 250,
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
                    child: const Text("Pessoa 60+"),
                  ),
                ),

                SizedBox(height: 20,),

                //pessoa responsavel
                SizedBox(
                  width:250,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioUserResponsavel(),
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
                    child: const Text("Sou Responsável por Alguém"),
                  ),
                ),

                SizedBox(height: 20,),

                //pessoa responsavel
                SizedBox(
                  width: 250,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioUserInstituicao(),
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
                    child: const Text("Represento uma Instituição"),
                  ),
                ),

              ],
            ),
            ),
          ),
        );
  }
}
