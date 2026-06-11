import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/criarSenhaUserResponsavel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';


class FormularioUserResponsavel extends StatelessWidget {
  FormularioUserResponsavel({super.key});

  // //criando variaveis do formulario
  // final TextEditingController nomeCompleto = TextEditingController();
  // final TextEditingController dataNascimento = TextEditingController();
  // final TextEditingController cpf = TextEditingController();
  // final TextEditingController sexo = TextEditingController.fromValue(value);
  // final TextEditingController emailPessoal = TextEditingController();
  // final TextEditingController telefone = TextEditingController();
  //
  // static TextEditingValue? value;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<UsuariofamiliarProvider>();

    var mascaraDataNascimento = new MaskTextInputFormatter(
        mask: '##/##/####',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    var mascaraCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    var mascaraTelefone = new MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controller.nome,
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
                inputFormatters: [mascaraCPF],
                controller: controller.cpf,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'CPF:',
                ),
              ),
            ),
            // Row(
            //   //crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: Text(
            //         "Sexo:",
            //         //style: TextStyle(fontSize: 18),//fontWeight: FontWeight.bold),
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //
            //     // sim
            //     Row(
            //       children: [
            //         const Text("Feminino"),
            //         Radio<String>(
            //           value: "feme",
            //           //groupValue: escolha,
            //           onChanged: (value) {
            //             //setState(() => escolha = value);
            //           },
            //         ),
            //       ],
            //     ),
            //
            //     // não
            //     Row(
            //       children: [
            //         const Text("Masculino"),
            //         Radio<String>(
            //           value: "masc",
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
                controller: controller.emailFamiliar,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail pessoal:',
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
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => criarSenhaUserResponsavel(),
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
