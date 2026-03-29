import 'package:cora_safe/screens/restricao.dart';
import 'package:flutter/material.dart';


class FormularioUser extends StatelessWidget {
  FormularioUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome completo:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Data de nascimento:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
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
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail pessoal:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'E-mail de familiar:',
                ),
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Expanded(
                  child: Text(
                    "Restrição alimentar:",
                    //style: TextStyle(fontSize: 18),//fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // sim
                Row(
                  children: [
                    const Text("Sim"),
                    Radio<String>(
                      value: "sim",
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
                    const Text("Não"),
                    Radio<String>(
                      value: "não",
                      //groupValue: escolha,
                      onChanged: (value) {
                        //setState(() => escolha = value);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
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

            const SizedBox(height: 24),

        ],
        ),
      ),
  );
  }
}
