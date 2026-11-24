import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/ajuda.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_hortaComunitaria.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_mercado.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/medicamentos.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/perfil.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/pratodia.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/produtos.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_farmacia.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_prefeitura.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/pedidosDoacoes.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/relatorioMonitoramentoISFL.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/restricaoISFL.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../classes/NotificacaoProvider.dart';
import '../../classes/RelatorioSemanalProvider.dart';
import '../../classes/RelatorioSemanalSugestaoPratoProvider.dart';

class MenuPrincipalInstituicao extends StatefulWidget {
  const MenuPrincipalInstituicao({super.key});

  @override
  State<MenuPrincipalInstituicao> createState() => _MenuPrincipalInstituicaoState();
}

class _MenuPrincipalInstituicaoState extends State<MenuPrincipalInstituicao> {

  @override
  void initState() {
    super.initState();
    carregarDadosISFL();
    verificacao();
  }
  String paginaAtual = '';
  int telaAtual = 0;

  Future<void> carregarDadosISFL() async {
    final idISFL_ = Provider.of<InstituicaosflProvider>(
      context,
      listen: false,
    ).idISFL.text;

    try {
      final notificacoes = await Provider.of<NotificacaoProvider>(
        context,
        listen: false,
      ).lendoNotificacoesUsuarioComum(idISFL_);
      print(
        'Notificações retornada pela leitura: '
        '${notificacoes.length}',
      );
    } catch (e) {
      print("Erro na notificação de vinculo");
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
  Future<void> verificacao() async{

    final controler_isfl = context.read<InstituicaosflProvider>();
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

    final Map<String, dynamic> verificaRelatorio =  await controller_relatorioSemanal
        .verificandoRelatorioSemanalISFL(
      controler_isfl.idISFL.text,
      controller_relatorioSemanal.inicioSemana as String,
      controller_relatorioSemanal.finalSemana as String,
    );

    final Map<String, dynamic> verificaRelatorio_ =  await controller_relatorioSemanalSugestaoPrato
        .verificandoRelatorioSemanalISFL(
      controler_isfl.idISFL.text,
      controller_relatorioSemanalSugestaoPrato.inicioSemana as String,
      controller_relatorioSemanalSugestaoPrato.finalSemana as String,
    );

    final bool ver = verificaRelatorio["encontrado"];
    final bool ver_ = verificaRelatorio_["encontrado"];
    print("Valor encontrado: ${verificaRelatorio["encontrado"]}");
    print("Tipo do valor: ${verificaRelatorio["encontrado"].runtimeType}");
    print("Variável ver: $ver");
    if (ver == false) {
      await controller_relatorioSemanal.criar_relatorioSemanal(
       null,
        null,
        int.parse(controler_isfl.idISFL.text),
        controller_relatorioSemanal.inicioSemana as String,
        controller_relatorioSemanal.finalSemana as String,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
    }
    if(ver_==false){
      await controller_relatorioSemanalSugestaoPrato.criar_relatorioSemanal(
       null,
        null,
        int.parse(controler_isfl.idISFL.text),
        controller_relatorioSemanalSugestaoPrato.inicioSemana as String,
        controller_relatorioSemanalSugestaoPrato.finalSemana as String,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
    }
  }

  Future<void> carregandoNotificacoesISFL() async {
    final idISFL = Provider.of<InstituicaosflProvider>(
      context,
      listen: false,
    ).idISFL;

    try {
      final notificacoes = await Provider.of<NotificacaoProvider>(
        context,
        listen: false,
      ).lendoNotificacoesISFL(int.parse(idISFL.text));
      print(
        'Notificações retornada pela leitura: '
        '${notificacoes.length}',
      );
    } catch (e) {
      print("Erro na notificação");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final controllerNotificacaoProdutos = context.read<NotificacaoProvider>();
    final controllerISFL_ = context.read<InstituicaosflProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent[400]),
              child: const Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => perfilUser()),
                );

                setState(() {
                  paginaAtual = 'Perfil';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Produtos()),
                );

                setState(() {
                  paginaAtual = 'Produtos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: const Text('Medicamentos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Medicamentos()),
                );

                setState(() {
                  paginaAtual = 'Medicamentos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.no_food),
              title: const Text('Restrições'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestricaoISFL()),
                );
                setState(() {
                  paginaAtual = 'Restrições';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Economia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => relatorioMonitoramentoISFL(),
                  ),
                );
                setState(() {
                  paginaAtual = 'Painel de Economia';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_center_outlined),
              title: const Text('Ajuda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ajuda()),
                );

                setState(() {
                  paginaAtual = 'Ajuda';
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) async {
          setState(() {
            telaAtual = index;
          });
          if (index == 2) {
            await carregandoNotificacoesISFL();
          }
        },
        indicatorColor: Colors.red[200],
        selectedIndex: telaAtual,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.volunteer_activism),
            label: 'Doações',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'Notificações',
          ),
        ],
      ),

      body: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                color: Colors.red[100],
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Responsável logado'),
                      subtitle: Text(
                        '${controllerISFL_.nomeResponsavel.text} - ${controllerISFL_.nomeISFL.text}',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.kitchen),
                      title: Text('Atenção a sua dispensa'),
                      subtitle: Text(
                        'Você pode ter produtos com validade próxima',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 7),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        minimumSize: const Size(120, 100),
                        maximumSize: const Size(120, 100),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Produtos()),
                        );
                      },
                      //child: const Text('Produtos'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/qr-code_.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 4),
                          Text(
                            'Incluir Produtos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA63232),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        minimumSize: const Size(120, 100),
                        maximumSize: const Size(120, 100),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Medicamentos(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/vitamin.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Incluir Medicamentos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA63232),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      //child: const Text('Adicionar Medicamentos'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        minimumSize: const Size(120, 100),
                        maximumSize: const Size(120, 100),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pratoDia()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/dinner.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Prato do Dia',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA63232),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        minimumSize: const Size(120, 100),
                        maximumSize: const Size(120, 100),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => relatorioMonitoramentoISFL(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/business.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Painel de Economia',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA63232),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 15),

              Text(
                "Sugestões para você                                            ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 24),

              SizedBox(
                width: 370,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoacaoFarmacia()),
                    );
                  },
                  icon: const Icon(Icons.medication_outlined),
                  label: Text(
                    "Farmácia - Farma Lar",
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFF000000),
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 13),
              SizedBox(
                width: 370,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoacaoPrefeitura(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_balance),
                  label: Text(
                    "Prefeitura - Município",
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFF000000),
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 370,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoacaoMercado()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(
                    "Mercado - Savegnago",
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFF000000),
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 13),
              SizedBox(
                width: 370,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoacaoHortacomunitaria(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.eco),
                  label: Text(
                    "Horta - Comunitária do município",
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFF000000),
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Divider(indent: 100, endIndent: 100, thickness: 1),

              SizedBox(
                width: 290,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pedidosdoacoes()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Acessar solicitações feitas", style: TextStyle(fontSize: 15),),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controllerNotificacaoProdutos.notificacoes.length,
                  itemBuilder: (context, index) {
                    final notificacao =
                        controllerNotificacaoProdutos.notificacoes[index];
                    print('Mensagem da notificação: "${notificacao.Mensagem}"');
                    bool value = false;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),

                      child: ListTile(
                        title: Text("Notificação"),
                        subtitle: Text(
                          notificacao.Mensagem,
                          style: TextStyle(fontSize: 12),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            IconButton(
                              icon: const Icon(Icons.check),
                              iconSize: 20,
                              onPressed: () async {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              iconSize: 20,
                              onPressed: () {
                                //função de excluir
                                controllerNotificacaoProdutos
                                    .excluirNotificacao(
                                      notificacao.idNotificacao,
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Notificação excluída com sucesso!',
                                    ),
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
            ],
          ),
        ),
      ][telaAtual],
    );
  }
}
