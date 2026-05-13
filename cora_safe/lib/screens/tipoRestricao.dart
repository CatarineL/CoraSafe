import 'package:cora_safe/screens/menuPrincipalUserComum.dart';
import 'package:flutter/material.dart';
import 'criarSenhaUsuarioComum.dart';

//void main() => runApp(const tipoRestricao());

class tipoRestricao extends StatelessWidget {
  const tipoRestricao({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CheckboxListTileExample());
  }
}

class CheckboxListTileExample extends StatefulWidget {
  const CheckboxListTileExample({super.key});

  @override
  State<CheckboxListTileExample> createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {
  bool pressaoAlta = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;
  bool checkboxValue6 = false;

  @override
  Widget build(BuildContext context) {
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
                });
              },
              title: const Text('Pressão Alta'),
              subtitle: const Text('Pressões máxima e mínima iguais a 140/90 mmHg (ou 14 por 9).'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: checkboxValue2,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue2 = value!;
                });
              },
              title: const Text('Diabetes'),
              subtitle: const Text('Diabetes tipo 1, 2, 3 e 4'),
            ),

            const Divider(height: 0),
            CheckboxListTile(
              value: checkboxValue4,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue4 = value!;
                });
              },
              title: const Text('Osteoporose'),
              subtitle: const Text('Tipo 1 e 2'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: checkboxValue5,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue5 = value!;
                });
              },
              title: const Text('Doença Ocular'),
              subtitle: const Text('Catarata, Glaucoma e outras'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: checkboxValue6,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue6 = value!;
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
            //const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}