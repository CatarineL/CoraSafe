import 'package:cora_safe/classes/SugestaoPratoUsuarioProvider.dart';
import 'package:cora_safe/classes/SugestaoPratosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../classes/SugestaoPratoUsuario.dart';
import '../../classes/UsuarioProvider.dart';

class pratoDia extends StatefulWidget {
  const pratoDia({super.key});

  @override
  State<pratoDia> createState() => _pratoDiaState();
}

class _pratoDiaState extends State<pratoDia> {
  @override
  void initState() {
    super.initState();

    //chamada das funções e incluindo os parametros
    Provider.of<Sugestaopratosprovider>(
      context,
      listen: false,
    ).lendoPratos('Diabetes');
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Sugestaopratosprovider>();
    final controller_sugestaoPratoUsuario = context.watch<SugestaoPratoUsuarioProvider>();
    final controller_usuario = context.watch<Usuarioprovider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prato do Dia",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: controller.pratos.length,
          itemBuilder: (context, index) {
            final prato = controller.pratos[index];
            final Uri url = Uri.parse(prato.linkPrato);
            bool value = false;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),

              child: ListTile(

                title: Text(prato.nomePrato),

                subtitle: Text(
                  "Ingredientes: ${prato.descricao}",
                  style: TextStyle(fontSize: 12),
                ),

                trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.open_in_new),
                        iconSize: 20,
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(prato.linkPrato),
                          );
                          final idUsuario_fk = int.parse(
                            controller_usuario.idUsuario.text,
                          );
                          controller_sugestaoPratoUsuario.criarSugestaoPratoUsuario(prato.idPrato, idUsuario_fk, 'Sugestão Aceita', DateTime.now());
                          print(idUsuario_fk);
                          print("clicado na função");
                        },
                      ),
                    ]

                )


              ),
            );
          },
        ),
      ),
    );

  }
}
