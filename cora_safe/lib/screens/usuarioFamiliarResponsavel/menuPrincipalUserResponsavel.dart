import 'package:cora_safe/screens/usuarioFamiliarResponsavel/ajuda.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/paineleconomia.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/perfil.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/visualizacaoProdutosIdoso.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/sobre.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/visualizarMedicamentosFamiliar.dart';
import 'package:flutter/material.dart';

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
  String selectedPage = '';
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
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
                  MaterialPageRoute(
                    builder: (context) => perfilUserFamiliar(),//corrigir pagina
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
                    builder: (context) => visualizacaoDispensaUserFamiliar(),
                  ),
                );
                setState(() {
                  selectedPage = 'Produtos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: const Text('Horário de Ingestão de Medicamentos'),//corrigir
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
                  MaterialPageRoute(
                    builder: (context) => Paineleconomia(),
                  ),
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
                  MaterialPageRoute(
                    builder: (context) => Ajuda(),
                  ),
                );
                setState(() {
                  selectedPage = 'Ajuda';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sobre(),
                  ),
                );
                setState(() {
                  selectedPage = 'Sobre';
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.deepOrange[100],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'Notificações',
          )
        ],
      ),


      body: <Widget>[
        // Página Inicial
        Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => visualizacaoDispensaUserFamiliar(),
                    ),
                  );
                },
                //child: const Text('Produtos'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/qr-code.png',
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    const Text('Produtos com validade próxima', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => visualizarMedicamentosFamiliar(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pills.png',
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text('Horário de ingestão de Medicamentos', style: TextStyle(color: Colors.black)),
                    ],
                  )
                //child: const Text('Adicionar Medicamentos'),

              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Paineleconomia(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/garfo-e-faca-de-prato.png',
                        height: 60,
                      ),
                      const SizedBox(height: 8),
                      const Text('Painel de Economia', style: TextStyle(color: Colors.black)),
                    ],
                  )
                //child: const Text('Prato do Dia'),
              ),

            ],
          ),
        ),

        //pagina de notificações
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notificação 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notificação 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

      ][currentPageIndex],

    );
  }
}