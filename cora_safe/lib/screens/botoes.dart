import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/criarSenhaUsuarioComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/excluirconta.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/loginUserComum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/RestricaoUsuarioProvider.dart';

enum ExerciseFilter {
  pressaoAlta("Pressão Alta"),
  diabetes("Diabetes"),
  osteoporose("Osteoporose"),
  doencaOcular("Doença Ocular"),
  doencaCardiaca("Doença Cardiaca");

  final String nome;

  const ExerciseFilter(this.nome);
}

class ChipApp extends StatelessWidget {
  const ChipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const FilterChipExample(),
      ),
    );
  }
}

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = context.read<TipoRestricaoUsuarioProvider>();
    final controller_userComum = context.read<Usuarioprovider>();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 50,),
          Text('Possui alguma dessas restrições?', style: TextStyle(fontSize: 20),),
          const SizedBox(height: 5.0),
          Wrap(
            spacing: 5.0,
            children: ExerciseFilter.values.map((ExerciseFilter exercise) {
              return FilterChip(
                label: Text(exercise.nome),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      print("ID NO USUARIO PROVIDER: '${controller_userComum.idUsuario.text}'");
                      if (exercise.nome == "Pressão Alta") {
                        controller.idUsuario_fk = controller_userComum.idUsuario.text as int;
                        controller.criarRestricaoUsuario();
                      }
                      if (exercise.nome == "Diabetes") {
                        print("ID NO USUARIO PROVIDER: '${controller_userComum.idUsuario.text}'");
                        controller.idUsuario_fk = controller_userComum.idUsuario.text as int;
                        controller.criarRestricaoUsuario();
                      }
                      if (exercise.nome == "Osteoporose") {
                        controller.idUsuario_fk = controller_userComum.idUsuario.text as int;
                        controller.criarRestricaoUsuario();
                      }
                      filters.add(exercise);
                    }
                    if (exercise.nome == "Doença Ocular") {
                      controller.idUsuario_fk = controller_userComum.idUsuario.text as int;
                      controller.criarRestricaoUsuario();
                    }
                    if (exercise.nome == "Doença Cardiaca") {
                      controller.idUsuario_fk = controller_userComum.idUsuario.text as int;
                      controller.criarRestricaoUsuario();
                    }
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10.0),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginUserComum(),
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
    );
  }
}
