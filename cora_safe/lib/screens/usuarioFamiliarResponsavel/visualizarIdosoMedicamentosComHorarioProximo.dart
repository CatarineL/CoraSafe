import 'package:cora_safe/classes/MedicamentoProvider.dart';
import 'package:cora_safe/classes/Produto.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';

import '../../classes/Medicamento.dart';

class visualizarMedicamentosFamiliar extends StatefulWidget {
  const visualizarMedicamentosFamiliar({super.key});

  @override
  State<visualizarMedicamentosFamiliar> createState() =>
      _visualizarMedicamentosFamiliarState();
}

class _visualizarMedicamentosFamiliarState
    extends State<visualizarMedicamentosFamiliar> {
  int filtroBotoes = 0;

  @override
  void initState() {
    super.initState();

    //variaveis
    final idUsuario = Provider.of<UsuariofamiliarProvider>(
      context,
      listen: false,
    ).idUsuarioComumFK;

    //chamada das funções e incluindo os parametros
    Provider.of<MedicamentoProvider>(
      context,
      listen: false,
    ).lendoItens(idUsuario!);


  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MedicamentoProvider>();
    int diferencaDias = 0;
    final List<Medicamento> medicamentos12horas = [];
    final List<Medicamento> medicamentos1dia = [];
    List<Medicamento> listaExibicao = [];

    for (final medicamento in controller.medicamentos) {
      final intervaloHoras = medicamento.horarioMedicamentoIntervalo;

      if (intervaloHoras != null) {
        //preenchendo as listas
        if (intervaloHoras <= 12) {
          medicamentos12horas.add(medicamento);
        } else if (intervaloHoras > 12) {
          medicamentos1dia.add(medicamento);
        }
      }
    }
    if (filtroBotoes == 0) {
      //todos os produtos
      listaExibicao = medicamentos12horas + medicamentos1dia;
    } else if (filtroBotoes == 1) {
      listaExibicao = medicamentos12horas;
    } else if (filtroBotoes == 2) {
      listaExibicao = medicamentos1dia;
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Horário de Medicação",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "Veja quais serão as próximas doses",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("#Todos"),
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "12 Horas",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filtroBotoes = 2;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("1 Dia", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),

            Divider(),
            Expanded(
              //height: 300,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: listaExibicao.length,
                  itemBuilder: (context, index) {
                    final medicamento = listaExibicao[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),

                      child: ListTile(
                        title: Text(medicamento.nomeMedicamento),
                        subtitle: Text(
                          "Intervalo de: ${medicamento.horarioMedicamentoIntervalo}h",
                          style: TextStyle(color: Colors.redAccent[400]),
                        ),
                        tileColor: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
