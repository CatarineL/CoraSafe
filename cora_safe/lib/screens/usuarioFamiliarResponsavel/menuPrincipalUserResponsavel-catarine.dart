import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/ajuda.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/perfil.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/pessoasVinculadasMim.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/relatorioMonitoramentoFamiliar.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/visualizacaoIdosoProdutosComValidadeProxima.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/visualizarIdosoMedicamentosComHorarioProximo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../classes/NotificacaoProvider.dart';
import '../../classes/UsuarioProvider.dart';

//Produtos próximos da validade
//Horário de ingestão de medicamentos
//Painel de Economia

void main() => runApp(const MenuPrincipalResponsavel());

class MenuPrincipalResponsavel extends StatelessWidget {
  const MenuPrincipalResponsavel({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerExample(),
    );
  }
}

class DrawerExample extends StatefulWidget {
  const DrawerExample({super.key});

  @override
  State<DrawerExample> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample> {
  String selectedPage = '', nomeFamiliarIdoso ='';
  int paginaAtual = 0;
  void initState() {
    super.initState();
    carregarNotificacoesFamiliar();
  }

  Future<void> carregarNotificacoesFamiliar() async {
    final idUsuario = Provider.of<UsuariofamiliarProvider>(
      context,
      listen: false,
    ).idUsuarioComumFK;

    final nome = await Provider.of<Usuarioprovider>(
      context,
      listen: false,
    ).lendoDadosUsuarioComum(int.parse(idUsuario!));

    if(!mounted) return;

    setState(() {
      if(nome.isNotEmpty){
        nomeFamiliarIdoso = nome;
      }
      else {
        nomeFamiliarIdoso = "Ninguém vinculado à você.";
      }
    });

    try {
      final notificacoes = await Provider.of<NotificacaoProvider>(
        context,
        listen: false,
      ).lendoNotificacoesUsuarioComum(idUsuario!);
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


    final controlerDados = context.read<UsuariofamiliarProvider>();
    final controllerNotificacaoProdutos = context.read<NotificacaoProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bem vindo (a), ${controlerDados.nome.text}',
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
                  MaterialPageRoute(
                    builder: (context) =>
                        perfilUserFamiliar(), //corrigir pagina
                  ),
                );
                setState(() {
                  selectedPage = 'Perfil';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Pessoa vinculada à mim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        pessoasVinculadasMim(), //corrigir pagina
                  ),
                );
                setState(() {
                  selectedPage = 'Perfil';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Produtos com validade próxima'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        visualizacaoDispensaUserFamiliarCorrigido(),
                  ),
                );
                setState(() {
                  selectedPage = 'Produtos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: const Text(
                'Horário de Ingestão de Medicamentos',
              ), //corrigir
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => visualizarMedicamentosFamiliar(),
                  ),
                );
                setState(() {
                  selectedPage = 'Medicamentos';
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Economia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => relatorioMonitoramento()),
                );
                setState(() {
                  selectedPage = 'Painel de Economia';
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
                      title: Text('Idoso vinculado à você'),
                      subtitle: Text('${nomeFamiliarIdoso}'),
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
                          MaterialPageRoute(
                            builder: (context) =>
                                visualizacaoDispensaUserFamiliarCorrigido(),
                          ),
                        );
                      },
                      //child: const Text('Produtos'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/shelf-life.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Produtos com validade próxima',
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
                            builder: (context) =>
                                visualizarMedicamentosFamiliar(),
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
                            'Horário de ingestão de Medicamentos',
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
                      //child: const Text('Prato do Dia'),
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
              Expanded(
                child: ListView.builder(
                  itemCount: controllerNotificacaoProdutos.notificacoes.length,
                  itemBuilder: (context, index) {
                    final notificacao =
                        controllerNotificacaoProdutos.notificacoes[index];
                    print('Mensagem da notificação: "${notificacao.Mensagem}"');
                    //final produto = controllerProduto.produtos[index];
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
      ][paginaAtual],
    );
  }
}
