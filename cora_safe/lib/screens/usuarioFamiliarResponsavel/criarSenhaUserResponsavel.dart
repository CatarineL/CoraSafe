import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/loginUserFamiliar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class criarSenhaUserResponsavel extends StatelessWidget {

  criarSenhaUserResponsavel({super.key});
  TextEditingController confirmarSenha1 = TextEditingController();
  TextEditingController confirmarSenha2 = TextEditingController();

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
                obscureText: true,
                controller: confirmarSenha1,
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
                controller: confirmarSenha2,
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
                  if (confirmarSenha1.text == confirmarSenha2.text){//verificando se as senhas são iguais
                    controller.senha.text = confirmarSenha2.text;
                    controller.criarUsuario();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginUserFamiliar(),
                      ),
                    );
                  }

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
            )
          ],
        ),
      ),
    );
  }
}