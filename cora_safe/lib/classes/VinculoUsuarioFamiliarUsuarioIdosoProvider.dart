import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class VinculoUsuarioFamiliarUsuarioIdosoProvider extends ChangeNotifier {
  int idVinculoFamiliar;
  int idUsuarioFamiliar;
  int idUsuarioIdoso;
  String status;

  VinculoUsuarioFamiliarUsuarioIdosoProvider({
    this.idVinculoFamiliar = 0,
    this.idUsuarioFamiliar = 0,
    this.idUsuarioIdoso = 0,
    this.status = 'Pendente',
  });

  int get idvinculofamiliar => idVinculoFamiliar;
  int get idusuariofamiliar => idUsuarioFamiliar;
  int get idusuarioidoso => idUsuarioIdoso;
  String get Status => status;

  Future<void> criarVinculoUsuarioFamiliarIdoso(
    int idUsuarioFamiliar,
    int idUsuarioIdoso,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.4:8000/vinculo_usuarioFamiliar_usuarioIdoso',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuarioFamiliar": idUsuarioFamiliar,
        "idUsuarioIdoso": idUsuarioIdoso,
        "status": status,
      }),
    );
    print("STATUS: ${response.statusCode}");
    print("RESPOSTA: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(response.body);
      idVinculoFamiliar = saidaDados['idVinculoFamiliar'];
      print('vinculo criado');
    } else {
      print(response.body);
    }
  }

  Future<void> lendoVinculo(int idUsuarioFam) async {
    final url = Uri.parse(
      'http://192.168.0.4:8000/visualizandoNotificacaoVinculoUserComum',
    );
    Map<String, dynamic> saidaDados = {};
    print("ID FAMILIAR ANTES DO POST: $idUsuarioFam");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idUsuario": idUsuarioFam}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print("STATUS LENDO VINCULO: ${response.statusCode}");
      print("BODY LENDO VINCULO: ${response.body}");

      saidaDados = jsonDecode(response.body);

      idVinculoFamiliar = saidaDados['idVinculoFamiliar'];
      idUsuarioFamiliar = saidaDados['idUsuarioFamiliar'];
      idUsuarioIdoso = saidaDados['idUsuarioIdoso'];
      status = saidaDados['status'];
    } else {
      //usuario não encontrado
      print('vinculo não encontrado');
    }
  }
}
