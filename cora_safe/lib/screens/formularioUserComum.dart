import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/restricao.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as context;
import 'package:provider/provider.dart';

class FormularioUser extends StatelessWidget {
  FormularioUser({super.key});

  //criando variaveis do formulario
  // final TextEditingController nomeCompleto = TextEditingController();
  // final TextEditingController dataNascimento = TextEditingController();
  // final TextEditingController cpf = TextEditingController();
  // final TextEditingController sexo = TextEditingController.fromValue(value);
  // final TextEditingController emailPessoal = TextEditingController();
  // final TextEditingController emailFamiliar = TextEditingController();

  // static TextEditingValue? value;


  @override
  Widget build(BuildContext context) {
    final controller = context.read<Usuarioprovider>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 40,),
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
                controller: controller.cpf,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'CPF:',
                ),
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Sexo:",
                    //style: TextStyle(fontSize: 18),//fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // sim
                Row(
                  children: [
                    const Text("Feminino"),
                    Radio<String>(
                      value: "feme",
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
                    const Text("Masculino"),
                    Radio<String>(
                      value: "masc",
                      //groupValue: escolha,
                      onChanged: (value) {
                        //setState(() => escolha = value);
                      },
                    ),
                  ],
                ),
              ],
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: TextFormField(
            //     controller: controller.emailFamiliar,
            //     decoration: const InputDecoration(
            //       border: UnderlineInputBorder(),
            //       labelText: 'E-mail de familiar:',
            //     ),
            //   ),
            // ),
            //
            // Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Restricao(),
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
