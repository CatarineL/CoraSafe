import 'package:flutter/material.dart';
import '../../classes/servicoNotificacao.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            /*
            NotificationService().showNotificationUsuarioComum(

              'Hello!',
              'This is your notification message',

            );*/
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          ),
          child: const Text(
            'Show Notification',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}