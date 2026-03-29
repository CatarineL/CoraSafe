import 'package:flutter/material.dart';

import 'menuPrincipal.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.redAccent[400],
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
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
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              //hintStyle:TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          obscureText: true,
                          controller: _senhaController,
                          decoration: InputDecoration(
                              hintText: "Senha",
                              //hintStyle:TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuPrincipal(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 55),
                              side: BorderSide(color: Colors.grey, width: 1),
                              shape: RoundedRectangleBorder(             // bordas arredondadas
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text("Entrar")
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: Size(150, 55),
                            side: BorderSide(color: Colors.grey, width: 1),
                            shape: RoundedRectangleBorder(             // bordas arredondadas
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Entrar com google"),),
                        SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black
                          ),
                          child: Text("Ainda não tem uma conta, crie uma conta"),
                        )
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
