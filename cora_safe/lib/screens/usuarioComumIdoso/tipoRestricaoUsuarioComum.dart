import 'package:cora_safe/classes/TipoRestricaoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'criarSenhaUsuarioComum.dart';

//void main() => runApp(const tipoRestricao());

class tipoRestricaoUsuarioComum extends StatelessWidget {
  const tipoRestricaoUsuarioComum({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckboxListTileExample();
  }
}

class CheckboxListTileExample extends StatefulWidget {
  const CheckboxListTileExample({super.key});

  @override
  State<CheckboxListTileExample> createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {

  //variaveis para controlar o botão de confirmaçõa de restrição
  bool pressaoAlta = false;
  bool diabetes = false;
  bool osteoporose = false;
  bool doencaOcular = false;
  bool problemasRespiratorios = false;


  //variaveis pra controlar
  var confirmaPressaoAlta = "Pressão Alta", confirmaDiabetes = "Diabetes", confirmaOsteoporose = "Osteoporose", confirmadoencaOcular = "Doença Ocular", confirmaProblemasRespiratorios = "Problemas Respiratórios";

  //nessa tela o que deve acontecer:
  //1) chamar um cursor da tabela de tipo restrição
  //2) para cada uma das restrições apresentadas
  //3) nome da restrição e enviar para a tabela de restrição junto com o id do usuario

  @override
  Widget build(BuildContext context) {
  //cursor para a classe de Tipo Restrição
  final controller = context.read<Tiporestricaoprovider>();

    return Scaffold(
      //appBar: AppBar(title: const Text('')),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CheckboxListTile(
              value: pressaoAlta,
              onChanged: (bool? value) {
                setState(() {
                  pressaoAlta = value!;
                  controller.nomeRestricao = confirmaPressaoAlta;
                });
              },
              title: const Text('Pressão Alta'),
              subtitle: const Text('Pressões máxima e mínima iguais a 140/90 mmHg (ou 14 por 9).'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: diabetes,
              onChanged: (bool? value) {
                setState(() {
                  diabetes = value!;
                  //necessario ter uma variavel que vai receber o nome da restrição
                  controller.nomeRestricao = confirmaDiabetes;
                });
              },
              title: const Text('Diabetes'),
              subtitle: const Text('Diabetes tipo 1, 2, 3 e 4'),
            ),

            const Divider(height: 0),
            CheckboxListTile(
              value: osteoporose,
              onChanged: (bool? value) {
                setState(() {
                  osteoporose = value!;
                  //necessario ter uma variavel que vai receber o nome da restrição
                  controller.nomeRestricao = confirmaOsteoporose;
                });
              },
              title: const Text('Osteoporose'),
              subtitle: const Text('Tipo 1 e 2'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: doencaOcular,
              onChanged: (bool? value) {
                setState(() {
                  doencaOcular = value!;
                  //necessario ter uma variavel que vai receber o nome da restrição
                  controller.nomeRestricao = confirmadoencaOcular;
                });
              },
              title: const Text('Doença Ocular'),
              subtitle: const Text('Catarata, Glaucoma e outras'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: problemasRespiratorios,
              onChanged: (bool? value) {
                setState(() {
                  problemasRespiratorios = value!;
                  //necessario ter uma variavel que vai receber o nome da restrição
                  controller.nomeRestricao = confirmaProblemasRespiratorios;
                });
              },
              title: const Text('Problemas respiratórios'),
              subtitle: const Text('Bronquite, Pneumonia, DPOC e outras'),
            ),
            const Divider(height: 0),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  controller.criarRestricao();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => criarSenhaUsuarioComum(),
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