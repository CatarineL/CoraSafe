import 'package:cora_safe/screens/menuPrincipal.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Restricao());

class Restricao extends StatelessWidget {
  const Restricao({super.key});

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
  bool checkboxValue1 = true;
  bool checkboxValue2 = true;
  bool checkboxValue3 = true;
  bool checkboxValue4 = true;
  bool checkboxValue5 = true;
  bool checkboxValue6 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restrição alimentar')),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
          CheckboxListTile(
            value: checkboxValue1,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue1 = value!;
              });
            },
            title: const Text('Pressão Alta'),
            subtitle: const Text('Supporting text'),
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
            subtitle: const Text('Supporting text'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: checkboxValue3,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue3 = value!;
              });
            },
            title: const Text('Problemas Cardiacos'),
            subtitle: const Text('Supporting text'),
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
            subtitle: const Text('Supporting text'),
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
            subtitle: const Text('Supporting text'),
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
            subtitle: const Text('Supporting text'),
          ),
          const Divider(height: 0),
          SizedBox(
            height:170,
          ),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPrincipal(),
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