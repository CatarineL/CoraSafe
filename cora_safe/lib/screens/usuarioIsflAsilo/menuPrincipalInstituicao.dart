import 'package:cora_safe/screens/usuarioIsflAsilo/ajuda.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacoes.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/medicamentos.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/paineleconomia.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/perfil.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/pratodia.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/produtos.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/visualizacaoProdutosIdoso.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/sobre.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MenuPrincipalInstituicao());

class MenuPrincipalInstituicao extends StatelessWidget {
  const MenuPrincipalInstituicao({super.key});

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
                setState(() {
                  selectedPage = 'Perfil';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Produtos'),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                setState(() {
                  selectedPage = 'Produtos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: const Text('Medicamentos'),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                setState(() {
                  selectedPage = 'Medicamentos';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.volunteer_activism),
              title: const Text('Doações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Doacoes()),
                );
                setState(() {
                  selectedPage = 'Doações';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Economia'),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                setState(() {
                  selectedPage = 'Painel de Economia';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_center_outlined),
              title: const Text('Ajuda'),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                setState(() {
                  selectedPage = 'Ajuda';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
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
            icon: Icon(Icons.document_scanner_outlined),
            label: 'Dispensa',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
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
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                },
                //child: const Text('Produtos'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/qr-code.png', height: 60),
                    const SizedBox(height: 8),
                    const Text(
                      'Incluir Produtos',
                      style: TextStyle(color: Colors.black),
                    ),
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
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/pills.png', height: 50),
                    const SizedBox(height: 8),
                    const Text(
                      'Incluir Medicamentos',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),

                //child: const Text('Adicionar Medicamentos'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/garfo-e-faca-de-prato.png',
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Prato do Dia',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                //child: const Text('Prato do Dia'),
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
                    MaterialPageRoute(builder: (context) => Doacoes()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/doacao-de-alimentos.png',
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Doações',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                //child: const Text('Doações'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/painel.png', height: 60),
                    const SizedBox(height: 8),
                    const Text(
                      'Painel de Economia',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                //child: const Text('Painel de economia'),
              ),
            ],
          ),
        ),

        // Página Dispensa
        ListTile(
          //leading: const Icon(Icons.account_circle),
          title: const Text('Produtos'),
          onTap: () {
            /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Produtos(),
                  ),
                );
                */
          },
        ),

        //pagina de perfil
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
