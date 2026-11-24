import 'package:cora_safe/screens/usuarioComumIdoso/tipoRestricaoUsuarioComum.dart';
import 'package:flutter/material.dart';
import '../../classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/loginUserComum.dart';
import 'package:provider/provider.dart';

import '../botoes.dart';

class criarSenhaUsuarioComum extends StatelessWidget {
  criarSenhaUsuarioComum({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerUser = context.read<Usuarioprovider>();
    final bool obscureText;
    TextEditingController confirmarSenha1 = TextEditingController();
    TextEditingController confirmarSenha2 = TextEditingController();

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
                onPressed: () async {
                  if (confirmarSenha1.text == confirmarSenha2.text) {
                    //verificando se as senhas são iguais
                    controllerUser.senha.text = confirmarSenha2.text;
                    await controllerUser.criarUsuario();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginUserComum()),
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
