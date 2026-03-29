import 'package:flutter/material.dart';


class perfilUser extends StatelessWidget {
  perfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Center(
       // child: Text("Você chegou aqui!"),
        // Página Dispensa
        child: const Padding(
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
    ),

    );

  }
}