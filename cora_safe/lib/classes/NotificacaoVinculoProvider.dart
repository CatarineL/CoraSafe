import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NotificacaoVinculoProvider extends ChangeNotifier {
  int idNotificacaoVinculo;
  int idUsuario;
  int idUsuarioFamiliar_fk;
  String Mensagem;
  String Status;
  DateTime? dataCriacao;

  NotificacaoVinculoProvider({
    this.idNotificacaoVinculo = 0,
    this.idUsuario = 0,
    this.idUsuarioFamiliar_fk = 0,
    this.Mensagem = '',
    this.Status = '',
    this.dataCriacao,
  });

  int get idnotificacao => idNotificacaoVinculo;
  int get idusuario => idUsuario;
  int get idusuariofamiliar_fk => idUsuarioFamiliar_fk;
  String get mensagem => Mensagem;
  String get status => Status;
  DateTime? get datacriacao => dataCriacao;

  //metodos
  Future<void> criarNotificacaoVinculo(int idUsuario, int idUsuarioFam) async {
    final url = Uri.parse('http://192.168.0.3:8000/notificacao_vinculo');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "idUsuario": idUsuario,
        "idUsuarioFamiliar": idUsuarioFam,
        "Mensagem": "Solicitação de Vínculo",
        "Status": "Enviado",
        "dataCriacao": DateTime.now().toIso8601String().split('T')[0],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Notificacao de vinculo cadastrada');
    } else {
      print(response.body);
    }
  }

  Future<void> visualizandoNotificacaoVinculo(int idUsuario) async {
    final url = Uri.parse('http://192.168.0.3:8000/visualizandoNotificacaoVinculoUserComum');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "idUsuario": idUsuario,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(response.body);

      idNotificacaoVinculo = saidaDados['idNotificacaoVinculo'];
      this.idUsuario =  saidaDados['idUsuario'];
      idUsuarioFamiliar_fk = saidaDados['idUsuarioFamiliar_fk'];
      Mensagem = saidaDados['Mensagem'];
      Status = saidaDados['Status'];
      dataCriacao = saidaDados['dataCriacao'];
      print('Notificacao de vinculo cadastrada');
    } else {
      print(response.body);
    }
  }

  Future<void> editarStatusNotificacaoVinculo(int idUsuarioIdoso, String statusNovo) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualiza_notificacao_vinculo/$idUsuarioIdoso',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario": idUsuarioIdoso,
        "Status": statusNovo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Informações de usuário atualizadas com sucesso');
    } else {
      print(response.body);
    }

  }

}
