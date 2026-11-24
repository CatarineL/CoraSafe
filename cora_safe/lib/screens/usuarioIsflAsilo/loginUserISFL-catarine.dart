import 'package:cora_safe/screens/cadastroSelecaoTipoUsuario.dart';
import 'package:flutter/material.dart';
import '../../classes/InstituicaoSFLProvider.dart';
import 'menuPrincipalInstituicao.dart';
import 'package:provider/provider.dart';

class LoginUserISFL extends StatelessWidget {
  LoginUserISFL({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller_isfl = context.read<InstituicaosflProvider>();

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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    //FlutterLogo(size: 76),
                    Image.asset(
                      'assets/images/CoraSafe_logo_removido.png',
                      width: 150,
                      height: 131,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _senhaController,
                      decoration: InputDecoration(hintText: "Senha"),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (!context.mounted) return;
                        bool acesso = await controller_isfl.loginISFL(
                          _emailController.text,
                          _senhaController.text,
                        );

                        if (acesso) {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) =>
                                  MenuPrincipalInstituicao(), //MenuPrincipal(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("E-mail ou senha inválidos"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: Size(150, 55),
                        side: BorderSide(color: Colors.grey, width: 1),
                        shape: RoundedRectangleBorder(
                          // bordas arredondadas
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Entrar"),
                    ),

                    SizedBox(height: 16),

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
                        minimumSize: Size(150, 55),
                        side: BorderSide(color: Colors.grey, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Ainda não tem uma conta, crie agora"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
