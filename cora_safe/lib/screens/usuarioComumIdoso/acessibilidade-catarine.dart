import 'package:flutter/material.dart';

class acessibilidade extends StatelessWidget {
  acessibilidade({super.key});

  @override
  Widget build(BuildContext context) {
    var light;
    return Scaffold(
      //appBar: AppBar(title: Text("Acessibilidade")),
      appBar: AppBar(
        title: Text(
          "Acessibilidade",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Aumento da fonte"),
              subtitle: const Text("Ative o aumento da fonte em 30%"),
              value: light,
              activeThumbColor: Colors.red,
              onChanged: (bool value) {

              },
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}
