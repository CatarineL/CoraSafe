import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/classes/MedicamentoProvider.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/horarioMedicamentoISFL.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../classes/Notificacao.dart';
import '../../classes/NotificacaoProvider.dart';


class visualizarMedicamentosISFL extends StatefulWidget {
  const visualizarMedicamentosISFL({super.key});

  @override
  State<visualizarMedicamentosISFL> createState() => _visualizarMedicamentosISFLState();
}

class _visualizarMedicamentosISFLState extends State<visualizarMedicamentosISFL> {
  @override
  void initState() {
    super.initState();
    //variaveis
    final idISFL = Provider.of<InstituicaosflProvider>(
      context,
      listen: false,
    ).idISFL.text;

    //chamada das funções e incluindo os parametros
    Provider.of<MedicamentoProvider>(
      context,
      listen: false,
    ).lendoItensISFL(idISFL);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //variaveis
      final idISFL = Provider.of<InstituicaosflProvider>(
        context,
        listen: false,
      ).idISFL.text;;

      //chamada das funções e incluindo os parametros

      var mensagem = "";
      DateTime agora = DateTime.now();
      var envio = "Enviado";
      final controllerNotificacao = context.read<Notificacao>();
      final controllerNotificacaoProvider = context.read<NotificacaoProvider>();
      final medicamentos = await Provider.of<MedicamentoProvider>(
        context,
        listen: false,
      ).lendoItensISFL(idISFL);

      for (final medicamento in medicamentos) {
        int pordia = 0;
        bool verifica;
        if (horarioMedicamento != null &&
            medicamento.horarioMedicamentoIntervalo != null) {
          pordia = (24 / medicamento.horarioMedicamentoIntervalo!).floor();
        }
        mensagem =
        "${medicamento.nomeMedicamento}\nConsumir ${pordia}x por dia";
        controllerNotificacao.idMedicamento_fk = medicamento.idMedicamento;
        controllerNotificacao.Mensagem = mensagem;
        controllerNotificacao.dataCriacao = agora;
        controllerNotificacao.Status = envio;
        verifica = await (controllerNotificacaoProvider
            .verificaNotificacaoMedicamento(medicamento.idMedicamento!));

        print('Medicamento: ${medicamento.nomeMedicamento}');
        print('Notificação já existe: $verifica');

        print('ID do usuário antes de criar a notificação: $idISFL');
        print('Intervalo do medicamento: ${medicamento.horarioMedicamentoIntervalo}');
        print('Mensagem montada: "$mensagem"');
        print('Mensagem enviada: "$mensagem"');
        print('Frequência calculada: $pordia');
        if (verifica == false && medicamento.horarioMedicamentoIntervalo!=null) {

          await controllerNotificacaoProvider.criarNotificacao(
            null,
            null,
            idISFL,
            null,
            mensagem,
            controllerNotificacao.Status,
            controllerNotificacao.dataCriacao!,
            controllerNotificacao.idMedicamento_fk,
          );
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MedicamentoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicamentos atuais",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: controller.medicamentos.length,
          itemBuilder: (context, index) {
            //Produto produto = produtos[index];
            final medicamento = controller.medicamentos[index];
            int pordia = 0;
            if (horarioMedicamento!=null && medicamento.horarioMedicamentoIntervalo!=null){
              pordia = (24/medicamento.horarioMedicamentoIntervalo!).floor();
            }

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

              child: ListTile(

                title: Text(medicamento.nomeMedicamento),

                subtitle: Text(
                  "Horário: Cada ${medicamento.horarioMedicamentoIntervalo ?? ''}h - ${pordia}x por dia\nPara: ${medicamento.para}",
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      iconSize: 20,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            TextEditingController nomeMedicamentoNovo =
                                TextEditingController(
                                  text: medicamento.nomeMedicamento,
                                );
                            TextEditingController dataValidadeMedicamento =
                                TextEditingController(
                                  text: medicamento.validadeMedicamento,
                                );
                            TextEditingController paraQuem =
                            TextEditingController(
                              text: medicamento.para,
                            );
                            TextEditingController intervaloMed =
                                TextEditingController(
                                  text: medicamento.horarioMedicamentoIntervalo?.toString() ?? '',
                                );
                            var data;

                            return AlertDialog(
                              title: Text('Atualizar Medicamento'),
                              actions: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Nome do Medicamento:",
                                  ),
                                  controller: nomeMedicamentoNovo,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Intervalo de Horas",
                                  ),
                                  controller: intervaloMed,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Para",
                                  ),
                                  controller: paraQuem,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText:
                                        "Data de Validade do Medicamento",
                                  ),
                                  controller: dataValidadeMedicamento,
                                  onTap: () async {
                                    data = (await showDatePicker(
                                      context: dialogContext,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                      locale: const Locale('pt', 'BR'),
                                    ));
                                    if (data != null) {
                                      //formatando a data escolhida
                                      dataValidadeMedicamento.text =
                                          "${data.day.toString().padLeft(2, '0')}/"
                                          "${data.month.toString().padLeft(2, '0')}/"
                                          "${data.year}";
                                    }

                                  },
                                ),

                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(dialogContext, "Confirmar");
                                    controller.editarMedicamentoISFL(
                                      medicamento.idMedicamento,
                                      nomeMedicamentoNovo.text,
                                      dataValidadeMedicamento.text,
                                      paraQuem.text,
                                      intervaloMed.text,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Atualizado!'),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent[400],
                                  ),
                                  child: Text(
                                    "Confirmar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Cancelar"),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent[400],
                                  ),
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 20,
                      onPressed: () {
                        //função de excluir
                        controller.excluirMedicamento(
                          int.parse(medicamento.idMedicamento),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Medicamento excluído com sucesso!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
