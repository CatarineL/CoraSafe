import 'package:cora_safe/classes/NotificacaoProvider.dart';
import 'package:cora_safe/classes/NotificacaoVinculoProvider.dart';
import 'package:cora_safe/classes/RelatorioSemanalSugestaoPratoProvider.dart';
import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/relatorioMonitoramento.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/ajuda.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/medicamentos.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/perfil.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/pratodia.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/produtos.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/tipoRestricaoUsuarioComum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../classes/RelatorioSemanalProvider.dart';
import '../../classes/UsuarioProvider.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int paginaAtual = 0;
  @override
  void initState() {
    super.initState();
    carregarDadosFamiliar();
    verificacao();
  }

  Future<void> carregarDadosFamiliar() async {
    final idUsuario = Provider
        .of<Usuarioprovider>(
      context,
      listen: false,
    ).idUsuario.text;

    final emailFam = Provider
        .of<Usuarioprovider>(
      context,
      listen: false,
    ).emailFamiliar;

    if (emailFam != null && emailFam.isNotEmpty) {
      await Provider.of<UsuariofamiliarProvider>(
        context,
        listen: false,
      ).lendoDados(emailFam);
    }

    try {
      await Provider.of<NotificacaoVinculoProvider>(
        context,
        listen: false,
      ).visualizandoNotificacaoVinculo(int.parse(idUsuario));
    } catch (e) {
      print("Erro na notificação de vinculo");
    }
    final notificacoes = await Provider.of<NotificacaoProvider>(
      context,
      listen: false,
    ).lendoNotificacoesUsuarioComum(idUsuario);
    print(
      'Notificações retornada pela leitura: '
          '${notificacoes.length}',
    );
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

    final Map<String, dynamic> verificaRelatorio =  await controller_relatorioSemanal
        .verificandoRelatorioSemanalUserComum(
      controlerDadosIdoso.idUsuario.text,
      controller_relatorioSemanal.inicioSemana as String,
      controller_relatorioSemanal.finalSemana as String,
    );

    final Map<String, dynamic> verificaRelatorio_ =  await controller_relatorioSemanalSugestaoPrato
        .verificandoRelatorioSemanal(
      controlerDadosIdoso.idUsuario.text,
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
        int.parse(controlerDadosIdoso.idUsuario.text),
        null,
        null,
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
        int.parse(controlerDadosIdoso.idUsuario.text),
        null,
        null,
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String selectedPage = '';
    final controlerDadosIdoso = context.read<Usuarioprovider>();
    final controlerDadosFamiliar = context.watch<UsuariofamiliarProvider>();
    final controllerNotificacao = context.watch<NotificacaoVinculoProvider>();
    final controllerReadNotificacao = context
        .read<NotificacaoVinculoProvider>();
    final controllerNotificacoes = context.watch<NotificacaoProvider>();

    print(
      'Notificações no Provider: '
      '${controllerNotificacoes.notificacoes.length}',
    );
    final nomeFamiliar = controlerDadosFamiliar.nome.text;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bem vindo (a), ${controlerDadosIdoso.nome}',
          style: TextStyle(fontSize: 17),
        ),
      ),
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
                  selectedPage = 'Perfil';
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
                  selectedPage = 'Produtos';
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
                  selectedPage = 'Medicamentos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.no_food),
              title: const Text('Restrição Alimentar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => tipoRestricaoUsuarioComum(),
                  ),
                );
                setState(() {
                  selectedPage = 'Restrição Alimentar';
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Monitoramento'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => relatorioMonitoramento()),
                );
                setState(() {
                  selectedPage = 'Painel de Monitoramento';
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
                  selectedPage = 'Ajuda';
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            paginaAtual = index;
          });
        },
        indicatorColor: Colors.red[200],
        selectedIndex: paginaAtual,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),

          NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'Notificações',
          ),
        ],
      ),

      body: <Widget>[
        // Página Inicial
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                color: Colors.red[100],
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
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
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                child: Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Pessoa vinculada à você'),
                      subtitle: Text('${nomeFamiliar}'),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
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
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 8),
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
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                            builder: (context) => relatorioMonitoramento(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/business.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Painel de Monitoramento',
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text("Alguém deseja criar um vínculo com você"),

                  subtitle: Text(
                    "Solicitação de Vínculo ${controllerReadNotificacao.status}",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        iconSize: 20,
                        onPressed: () {
                          controllerNotificacao.editarStatusNotificacaoVinculo(
                            int.parse(controlerDadosIdoso.idUsuario.text),
                            "Aceito",
                          );
                          controlerDadosFamiliar.editarIDUsuarioComum(
                            controlerDadosIdoso.idUsuario.text,
                            controlerDadosFamiliar.idUsuarioFamiliar.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Vínculo aceito')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        iconSize: 20,
                        onPressed: () {
                          controllerNotificacao.editarStatusNotificacaoVinculo(
                            int.parse(controlerDadosIdoso.idUsuario.text),
                            "Recusado"
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Vínculo recusado')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controllerNotificacoes.notificacoes.length,
                  itemBuilder: (context, index) {
                    final notificacao =
                        controllerNotificacoes.notificacoes[index];
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
                                controllerNotificacoes
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
      ][paginaAtual],
    );
  }
}
