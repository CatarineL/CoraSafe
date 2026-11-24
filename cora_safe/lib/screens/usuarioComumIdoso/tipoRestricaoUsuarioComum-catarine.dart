import 'package:cora_safe/classes/RestricaoUsuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/UsuarioProvider.dart';
import 'criarSenhaUsuarioComum.dart';

enum ExerciseFilter {
  pressaoAlta("Pressão Alta"),
  diabetes("Diabetes"),
  osteoporose("Osteoporose"),
  doencaOcular("Doença Ocular"),
  doencaCardiaca("Doença Cardiaca");

  final String nome;

  const ExerciseFilter(this.nome);
}

class tipoRestricaoUsuarioComum extends StatelessWidget {
  const tipoRestricaoUsuarioComum({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CheckboxListTileExample());
  }
}

class CheckboxListTileExample extends StatefulWidget {
  const CheckboxListTileExample({super.key});

  @override
  State<CheckboxListTileExample> createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = context.read<TipoRestricaoUsuarioProvider>();
    final controller_userComum = context.read<Usuarioprovider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minhas Restrições e +",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Incluir nova restrição:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: ExerciseFilter.values.map((ExerciseFilter exercise) {
                return Center(
                  child: FilterChip(
                    label: Text(exercise.nome),
                    selected: filters.contains(exercise),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          filters.add(exercise);
                          if (exercise.nome == "Pressão Alta") {
                            controller.idRestricao = 1;
                          }
                          if (exercise.nome == "Diabetes") {
                            controller.idRestricao = 2;
                          }
                          if (exercise.nome == "Osteoporose") {
                            controller.idRestricao = 3;
                          }
                        }
                        if (exercise.nome == "Doença Ocular") {
                          controller.idRestricao = 4;
                        }
                        if (exercise.nome == "Doença Cardiaca") {
                          controller.idRestricao = 5;
                        }
                        controller.idUsuario_fk = int.parse(
                          controller_userComum.idUsuario.text,
                        );
                        controller.criarRestricaoUsuario();
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            Spacer(),

            SizedBox(
              width: 200,
              height: 55,

              child: ElevatedButton(
                onPressed: () {},
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
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
