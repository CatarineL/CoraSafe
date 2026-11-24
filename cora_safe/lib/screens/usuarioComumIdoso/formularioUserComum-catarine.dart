import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/restricao.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class FormularioUser extends StatelessWidget {
  FormularioUser({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<Usuarioprovider>();
    TextEditingController emailF = TextEditingController(
      text: controller.emailFamiliar ?? '',
    );

    var mascaraDataNascimento = new MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    var mascaraCPF = new MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    var mascaraTelefone = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.nomeUsuario,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome completo:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                inputFormatters: [mascaraDataNascimento],
                controller: controller.dataNascimento,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Data de nascimento:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.sexo,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Sexo:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                inputFormatters: [mascaraCPF],
                controller: controller.cpf,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'CPF:',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.emailPessoal,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail pessoal:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: emailF,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail de familiar:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                inputFormatters: [mascaraTelefone],
                controller: controller.telefone,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Telefone:',
                ),
              ),
            ),
            // Spacer(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  controller.emailFamiliar = emailF.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Restricao()),
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
