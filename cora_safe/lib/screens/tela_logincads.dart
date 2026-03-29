import 'package:cora_safe/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'cadastroSelecaoTipoUsuario.dart';


class LoginCadastro extends StatelessWidget {
  LoginCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,//redAccent[400],
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Column(
                      children: [
                        //FlutterLogo(size: 76),
                        Image.asset(
                          'assets/images/CoraSafe_logo.png',
                          width: 300,
                          height: 300,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
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
                            minimumSize: Size(200, 55),
                            //side: BorderSide(color: Colors.black, width: 2),
                            shape: RoundedRectangleBorder(             // bordas arredondadas
                              borderRadius: BorderRadius.circular(12),
                            ),
                            ),
                            child: Text("Login",)),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CadastroSelecaoTipoUsuario(),
                              ),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: Size(200, 55),
                            side: BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(             // bordas arredondadas
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Cadastrar"),),

                      ]
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
