import 'package:cora_safe/classes/RelatorioSemanalProvider.dart';
import 'package:cora_safe/classes/RelatorioSemanalSugestaoPratoProvider.dart';
import 'package:cora_safe/classes/SugestaoPratoUsuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:provider/provider.dart';
import '../../classes/ProdutoProvider.dart';
import '../../classes/UsuarioProvider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class relatorioMonitoramento extends StatefulWidget {
  const relatorioMonitoramento({super.key});

  @override
  State<relatorioMonitoramento> createState() => _relatorioMonitoramentoState();
}

class _relatorioMonitoramentoState extends State<relatorioMonitoramento> {
  GlobalKey _relatorioMonitoramento = GlobalKey();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      carregarDados();
    });
  }

  Future<void> carregarDados() async {
    final idUsuario = Provider.of<Usuarioprovider>(
      context,
      listen: false,
    ).idUsuario.text;

    //chamada das funções e incluindo os parametros
    await context.read<Produtoprovider>().lendoItens(idUsuario);
    await context.read<SugestaoPratoUsuarioProvider>().lendoSugestao(
      int.parse(idUsuario),
    );

    await encontrandoIdSemana();
    await encontrandoIdSemanaSugestaoPratoDiario();

    final controller_relatorioSemanal = context
        .read<RelatorioSemanalProvider>();
    final controller_relatorioSemanalSugestaoPrato = context
        .read<RelatorioSemanalSugestaoPratoProvider>();
    DateTime dataIniSemana = DateTime.now();
    DateTime dataIni_ = conversaoDataIni(dataIniSemana);
    controller_relatorioSemanal.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFin = dataIni_.add(const Duration(days: 6));
    controller_relatorioSemanal.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFin);

    controller_relatorioSemanalSugestaoPrato.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFinal = dataIni_.add(const Duration(days: 6));
    controller_relatorioSemanalSugestaoPrato.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFinal);
    final controlerDadosIdoso = context.read<Usuarioprovider>();
    final Map<String, dynamic> verificaRelatorio =
        await controller_relatorioSemanal.verificandoRelatorioSemanalUserComum(
          controlerDadosIdoso.idUsuario.text,
          controller_relatorioSemanal.inicioSemana as String,
          controller_relatorioSemanal.finalSemana as String,
        );
    final Map<String, dynamic> verificaRelatorio_ =
        await controller_relatorioSemanalSugestaoPrato
            .verificandoRelatorioSemanal(
              controlerDadosIdoso.idUsuario.text,
              controller_relatorioSemanalSugestaoPrato.inicioSemana as String,
              controller_relatorioSemanalSugestaoPrato.finalSemana as String,
            );

    final bool ver = verificaRelatorio["encontrado"];
    final String idS = verificaRelatorio["idSemana"].toString();
    final bool ver_ = verificaRelatorio_["encontrado"];
    final String idS_ = verificaRelatorio_["idSemana"].toString();

    if (ver == true) {
      await controller_relatorioSemanal.lendoConsumoDiario(int.parse(idS));
    }
    if (ver_ == true) {
      await controller_relatorioSemanalSugestaoPrato.lendoSugestaoPratoDiario(
        int.parse(idS_),
      );
    }
    await itensConsumidosDiario();
    await itensSugestaoPratoDiario();

    if (ver == true) {
      await controller_relatorioSemanal.lendoConsumoDiario(int.parse(idS));
    }
    if (ver_ == true) {
      await controller_relatorioSemanalSugestaoPrato.lendoSugestaoPratoDiario(
        int.parse(idS_),
      );
    }
  }

  DateTime conversaoDataIni(DateTime data_) {
    int numeroDiaIniSemana = data_.weekday;
    DateTime teste = data_;

    if (numeroDiaIniSemana == 1) {
      teste = teste.subtract(const Duration(days: 0));
    } else if (numeroDiaIniSemana == 2) {
      teste = teste.subtract(const Duration(days: 1));
    } else if (numeroDiaIniSemana == 3) {
      teste = teste.subtract(const Duration(days: 2));
    } else if (numeroDiaIniSemana == 4) {
      teste = teste.subtract(const Duration(days: 3));
    } else if (numeroDiaIniSemana == 5) {
      teste = teste.subtract(const Duration(days: 4));
    } else if (numeroDiaIniSemana == 6) {
      teste = teste.subtract(const Duration(days: 5));
    } else if (numeroDiaIniSemana == 7) {
      teste = teste.subtract(const Duration(days: 6));
    }
    return teste;
  }

  Future<String> encontrandoIdSemana() async {
    final controlerDadosIdoso = context.read<Usuarioprovider>();
    final controller_relatorioSemanal = context
        .read<RelatorioSemanalProvider>();
    final controller_relatorioSemanalSugestaoPrato = context
        .read<RelatorioSemanalSugestaoPratoProvider>();
    DateTime dataIniSemana = DateTime.now();
    DateTime dataIni_ = conversaoDataIni(dataIniSemana);
    controller_relatorioSemanal.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFin = dataIni_.add(const Duration(days: 6));
    controller_relatorioSemanal.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFin);
    controller_relatorioSemanalSugestaoPrato.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFinal = dataIni_.add(const Duration(days: 6));
    controller_relatorioSemanalSugestaoPrato.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFinal);
    final Map<String, dynamic> verificaRelatorio =
        await controller_relatorioSemanal.verificandoRelatorioSemanalUserComum(
          controlerDadosIdoso.idUsuario.text,
          controller_relatorioSemanal.inicioSemana as String,
          controller_relatorioSemanal.finalSemana as String,
        );
    final Map<String, dynamic> verificaRelatorio_ =
        await controller_relatorioSemanalSugestaoPrato
            .verificandoRelatorioSemanal(
              controlerDadosIdoso.idUsuario.text,
              controller_relatorioSemanalSugestaoPrato.inicioSemana as String,
              controller_relatorioSemanalSugestaoPrato.finalSemana as String,
            );

    final bool ver = verificaRelatorio["encontrado"];
    final String idS = verificaRelatorio["idSemana"].toString();
    final bool ver_ = verificaRelatorio_["encontrado"];
    final String idS_ = verificaRelatorio_["idSemana"].toString();
    print("Valor encontrado: ${verificaRelatorio["encontrado"]}");
    print("Tipo do valor: ${verificaRelatorio["encontrado"].runtimeType}");
    print("Variável ver: $ver");
    if (ver == true) {
      return idS.toString();
    } if (ver_ == true) {
      return idS_.toString();
    } else {
      return "Id da semana não encontrado";
    }
  }

  Future<String> encontrandoIdSemanaSugestaoPratoDiario() async {
    final controlerDadosIdoso = context.read<Usuarioprovider>();

    final controller_relatorioSemanalSugestaoPrato = context
        .read<RelatorioSemanalSugestaoPratoProvider>();
    DateTime dataIniSemana = DateTime.now();
    DateTime dataIni_ = conversaoDataIni(dataIniSemana);
    controller_relatorioSemanalSugestaoPrato.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFinal = dataIni_.add(const Duration(days: 6));
    controller_relatorioSemanalSugestaoPrato.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFinal);

    final Map<String, dynamic> verificaRelatorio_ =
        await controller_relatorioSemanalSugestaoPrato
            .verificandoRelatorioSemanal(
              controlerDadosIdoso.idUsuario.text,
              controller_relatorioSemanalSugestaoPrato.inicioSemana as String,
              controller_relatorioSemanalSugestaoPrato.finalSemana as String,
            );

    final bool ver_ = verificaRelatorio_["encontrado"];
    final String idS_ = verificaRelatorio_["idSemana"].toString();

    if (ver_ == true) {
      return idS_.toString();
    } else {
      return "Id da semana não encontrado";
    }
  }

  Future<void> itensConsumidosDiario() async {
    final controller = context.read<Produtoprovider>();
    final controllerRelatorioSemanal = context.read<RelatorioSemanalProvider>();
    final idUsuario_ = Provider.of<Usuarioprovider>(
      context,
      listen: false,
    ).idUsuario.text;
    int consumidosSegunda = 0,
        consumidosTerca = 0,
        consumidosQuarta = 0,
        consumidosQuinta = 0,
        consumidosSexta = 0,
        consumidosSabado = 0,
        consumidosDomingo = 0;
    DateTime inicioSemana = DateFormat('dd/MM/yyyy').parse(controllerRelatorioSemanal.inicioSemana!,);
    DateTime finalSemana = DateFormat('dd/MM/yyyy').parse(controllerRelatorioSemanal.finalSemana!,);
    String idSem = await encontrandoIdSemana();

    for (final produto in controller.produtos) {
      if (produto.statusProduto == true &&
          produto.dataConsumo != null &&
          produto.dataConsumo!.isNotEmpty) {
        DateTime dataConsumo = DateTime.parse(produto.dataConsumo!);

        DateTime dataConsumoDia = DateTime(
          dataConsumo.year,
          dataConsumo.month,
          dataConsumo.day,
        );
    bool pertenceSemana = !dataConsumoDia.isBefore(inicioSemana) && !dataConsumoDia.isAfter(finalSemana);

    if(pertenceSemana){
      int numeroDia = dataConsumo.weekday;
      if (numeroDia == 1) {
        consumidosSegunda = consumidosSegunda + 1;
      } else if (numeroDia == 2) {
        consumidosTerca = consumidosTerca + 1;
      } else if (numeroDia == 3) {
        consumidosQuarta = consumidosQuarta + 1;
      } else if (numeroDia == 4) {
        consumidosQuinta = consumidosQuinta + 1;
      } else if (numeroDia == 5) {
        consumidosSexta = consumidosSexta + 1;
      } else if (numeroDia == 6) {
        consumidosSabado = consumidosSabado + 1;
      } else {
        consumidosDomingo = consumidosDomingo + 1;
      }
    }
    }

    }

    //atribuindo os valores
    controllerRelatorioSemanal.segunda = consumidosSegunda;
    controllerRelatorioSemanal.terca = consumidosTerca;
    controllerRelatorioSemanal.quarta = consumidosQuarta;
    controllerRelatorioSemanal.quinta = consumidosQuinta;
    controllerRelatorioSemanal.sexta = consumidosSexta;
    controllerRelatorioSemanal.sabado = consumidosSabado;
    controllerRelatorioSemanal.domingo = consumidosDomingo;

    await controllerRelatorioSemanal.editandoConsumoSemanaUserComum(
      int.parse(idSem),
      idUsuario_,
      controllerRelatorioSemanal.inicioSemana!,
      controllerRelatorioSemanal.finalSemana,
      controllerRelatorioSemanal.segunda,
      controllerRelatorioSemanal.terca,
      controllerRelatorioSemanal.quarta,
      controllerRelatorioSemanal.quinta,
      controllerRelatorioSemanal.sexta,
      controllerRelatorioSemanal.sabado,
      controllerRelatorioSemanal.domingo,
    );
  }

  Future<void> itensSugestaoPratoDiario() async {
    final controller_sugestao_aceita = context
        .read<SugestaoPratoUsuarioProvider>();
    final controllerRelatorioSemanalSugestaoPrato = context
        .read<RelatorioSemanalSugestaoPratoProvider>();
    final idUsuario_ = Provider.of<Usuarioprovider>(
      context,
      listen: false,
    ).idUsuario.text;
    int statusSegunda = 0,
        statusTerca = 0,
        statusQuarta = 0,
        statusQuinta = 0,
        statusSexta = 0,
        statusSabado = 0,
        statusDomingo = 0;
    DateTime inicioSemana = DateFormat('dd/MM/yyyy').parse(controllerRelatorioSemanalSugestaoPrato.inicioSemana!,);
    DateTime finalSemana = DateFormat('dd/MM/yyyy').parse(controllerRelatorioSemanalSugestaoPrato.finalSemana!,);

    String idSem = await encontrandoIdSemanaSugestaoPratoDiario();
    for (final prato in controller_sugestao_aceita.pratos) {
      if (prato.datacriacao != null  && prato.status == 'Sugestão Aceita') {
        int numeroDiaSugestaoAceita = (prato.datacriacao)!.weekday;

        DateTime dataSugestaoAceita = prato.datacriacao!;


        DateTime dataSugestaoAceitaDia = DateTime(
          dataSugestaoAceita.year,
          dataSugestaoAceita.month,
          dataSugestaoAceita.day,
        );
        bool pertenceSemana = !dataSugestaoAceitaDia.isBefore(inicioSemana) && !dataSugestaoAceitaDia.isAfter(finalSemana);

        if(pertenceSemana){
          if (numeroDiaSugestaoAceita == 1) {
            statusSegunda = statusSegunda + 1;
          } else if (numeroDiaSugestaoAceita == 2) {
            statusTerca = statusTerca + 1;
          } else if (numeroDiaSugestaoAceita == 3) {
            statusQuarta = statusQuarta + 1;
          } else if (numeroDiaSugestaoAceita == 4) {
            statusQuinta = statusQuinta + 1;
          } else if (numeroDiaSugestaoAceita == 5) {
            statusSexta = statusSexta + 1;
          } else if (numeroDiaSugestaoAceita == 6) {
            statusSabado = statusSabado + 1;
          } else if (numeroDiaSugestaoAceita == 7) {
            statusDomingo = statusDomingo + 1;
          }
        }
      }
    }

    //atribuindo os valores
    controllerRelatorioSemanalSugestaoPrato.segunda = statusSegunda;
    controllerRelatorioSemanalSugestaoPrato.terca = statusTerca;
    controllerRelatorioSemanalSugestaoPrato.quarta = statusQuarta;
    controllerRelatorioSemanalSugestaoPrato.quinta = statusQuinta;
    controllerRelatorioSemanalSugestaoPrato.sexta = statusSexta;
    controllerRelatorioSemanalSugestaoPrato.sabado = statusSabado;
    controllerRelatorioSemanalSugestaoPrato.domingo = statusDomingo;

    await controllerRelatorioSemanalSugestaoPrato
        .editandoConsumoSemanaUserComum(
        int.parse(idSem),
        idUsuario_,
        controllerRelatorioSemanalSugestaoPrato.inicioSemana!,
        controllerRelatorioSemanalSugestaoPrato.finalSemana,
        controllerRelatorioSemanalSugestaoPrato.segunda,
        controllerRelatorioSemanalSugestaoPrato.terca,
        controllerRelatorioSemanalSugestaoPrato.quarta,
        controllerRelatorioSemanalSugestaoPrato.quinta,
        controllerRelatorioSemanalSugestaoPrato.sexta,
        controllerRelatorioSemanalSugestaoPrato.sabado,
        controllerRelatorioSemanalSugestaoPrato.domingo,
      );
  }

  @override
  Widget build(BuildContext context) {
    final controllerRelatorioSemanal = context
        .watch<RelatorioSemanalProvider>();
    final controllerRelatorioSemanalSugestaoPrato = context
        .watch<RelatorioSemanalSugestaoPratoProvider>();
    DateTime dataIniSemana = DateTime.now();
    DateTime dataIni_ = conversaoDataIni(dataIniSemana);
    controllerRelatorioSemanal.inicioSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataIni_);
    DateTime dataFin = dataIni_.add(const Duration(days: 6));
    controllerRelatorioSemanal.finalSemana = DateFormat(
      'dd/MM/yyyy',
    ).format(dataFin);

    Future<void> baixarRelatorio() async {
      final RenderRepaintBoundary boundary =
          _relatorioMonitoramento.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        return;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      await Gal.putImageBytes(pngBytes);
    }

    Future<void> compartilharRelatorio() async {
      final RenderRepaintBoundary boundary =
          _relatorioMonitoramento.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return;

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final directory = await getTemporaryDirectory();

      final arquivo = File('${directory.path}/grafico_corasafe.png');

      await arquivo.writeAsBytes(pngBytes);

      await Share.shareXFiles([
        XFile(arquivo.path),
      ], text: 'Relatório do CoraSafe');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Painel de Monitoramento",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(17),
        margin: const EdgeInsets.all(8),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Monitoramento Semanal:\nQuantidade de itens consumidos e Sugestões aceitas por dia",
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            SizedBox(height: 10),
            RepaintBoundary(
              key: _relatorioMonitoramento,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 310,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 9,

                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.white,

                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.toInt()}',
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.segunda ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .segunda ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.terca ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .terca ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.quarta ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .quarta ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.quinta ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .quinta ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.sexta ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .sexta ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.sabado ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .sabado ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(
                            toY: (controllerRelatorioSemanal.domingo ?? 0)
                                .toDouble(),
                            color: Colors.redAccent[400],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY:
                                (controllerRelatorioSemanalSugestaoPrato
                                            .domingo ??
                                        0)
                                    .toDouble(),
                            color: Colors.redAccent[200],
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const labels = [
                              'Seg',
                              'Ter',
                              'Qua',
                              'Qui',
                              'Sex',
                              'Sáb',
                              'Dom',
                            ];
                            return Text(labels[value.toInt()]);
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent[100],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),

              child: ListTile(
                title: Text(
                  "Relatório de Monitoramento",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(
                      //btn de baixar
                      icon: const Icon(Icons.file_download),
                      iconSize: 20,
                      onPressed: () async {
                        baixarRelatorio();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Relatório baixado com sucesso'),
                          ),
                        );
                      },
                    ),

                    IconButton(
                      //btn de compartilhar
                      icon: const Icon(Icons.share),
                      iconSize: 20,
                      onPressed: () async {
                        await compartilharRelatorio();
                      },
                    ),
                  ],
                ),
                tileColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
