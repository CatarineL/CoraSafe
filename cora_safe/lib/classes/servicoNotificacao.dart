//import 'dart:js_interop';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationService {
  final idNotificacao = TextEditingController();
  String? idUsuario_fk;
  String? idUsuarioFamiliar_fk;
  String? idISFL_fk;
  String? Mensagem;
  String? Status;
  DateTime? dataCriacao;

  String get idnotificacao => idNotificacao.text;
  String get idusuario_fk => idUsuario_fk ?? '';
  String get idusuariofamiliar_fk => idUsuarioFamiliar_fk ?? '';
  String get idisfl_fk =>idISFL_fk ?? '';
  String get mensagem => Mensagem ?? '';
  String get status => Status ?? '';
  DateTime? get datacriacao => dataCriacao;


  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // Initialize notifications
  Future<void> initialize() async {
    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('icone');//@mipmap/ic_launcher//C:\Users\catar\AndroidStudioProjects\cora_safe\android\app\src\main\res\mipmap-hdpi\ic_launcher.png

    // Combined initialization settings
    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidSettings);
    // Initialize the plugin
    await _notificationsPlugin.initialize(initializationSettings);
  }
  // Show a simple notification
  Future<void> showNotificationUsuarioComum({
    int idNotificacao = 0,
    String idUsuario_fk = '',
    String Mensagem = '',
    //String Status = '',
    //String dataCriacao = '',

  }) async {
    // Android notification details
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'This is the default notification channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    // Combined notification details
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails
    );
    // Show the notification
    await _notificationsPlugin.show(idNotificacao, idUsuario_fk, Mensagem, notificationDetails,payload:  '$Status | $dataCriacao',);
  }



  // Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}