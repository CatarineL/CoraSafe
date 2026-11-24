import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InstituicaosflProvider extends ChangeNotifier {
  final idISFL = TextEditingController();
  final nomeISFL = TextEditingController();
  final nomeResponsavel = TextEditingController();
  final cnpj = TextEditingController();
  String? tipoUsuario;
  final emailISFL = TextEditingController();
  final senha = TextEditingController();
  final telefoneISFL = TextEditingController();
  bool? restricaoAlimentar;

  //pegando os valores quando precisar
  String get idisfl => idISFL.text;
  String get nomeisfl => nomeISFL.text;
  String get nomeresponsavel => nomeResponsavel.text;
  String get CNPJ => cnpj.text;
  String get tipousuario => tipoUsuario ?? '';
  String get emailisfl => emailISFL.text;
  String get Senha => senha.text;
  String get telefoneisfl => telefoneISFL.text;
  bool get restricaoalimentar => restricaoAlimentar ?? false;

  void criarISFL() async {
    final url = Uri.parse('http://192.168.0.3:8000/ISFL');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeISFL": nomeISFL.text,
        "nomeResponsavel": nomeResponsavel.text,
        "cnpj": cnpj.text,
        "tipoUsuario": tipoUsuario,
        "emailISFL": emailISFL.text,
        "telefoneISFL": telefoneISFL.text,
        "senha": senha.text,
        "restricaoAlimentar": restricaoAlimentar,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('usuario cadastrado');
    } else {
      print(response.body);
    }
  }

  Future<bool> loginISFL(String email_ISFL, String senhaISFL) async {
    final url = Uri.parse('http://192.168.0.3:8000/loginUserISFL');
    Map<String, dynamic> saidaDados = {};

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"emailISFL": email_ISFL, "senha": senhaISFL}),
    );
    print("STATUS LOGIN: ${response.statusCode}");
    print("RESPOSTA LOGIN: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      saidaDados = jsonDecode(response.body);

      idISFL.text = saidaDados['idISFL'].toString();
      nomeISFL.text = saidaDados['nomeISFL'];
      nomeResponsavel.text = saidaDados['nomeResponsavel'];
      cnpj.text = saidaDados['cnpj'];
      tipoUsuario = saidaDados['tipoUsuario'];
      emailISFL.text = saidaDados['emailISFL'];
      telefoneISFL.text = saidaDados['telefoneISFL'];
      senha.text = saidaDados['senha'];
      restricaoAlimentar = saidaDados['restricaoAlimentar'] as bool?;
      return true;
    } else {
      print('Instituição não encontrada');
      return false;
    }
  }

  Future<void> editarInformacaoISFL(
    int idISFLNovo,
    String nomeISFLNovo,
    String nomeResponsavelNovo,
    String emailISFLNovo,
    String telNovo,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizandoISFL/$idISFLNovo',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeISFL": nomeISFLNovo,
        "nomeResponsavel": nomeResponsavelNovo,
        "emailISFL": emailISFLNovo,
        "telefoneISFL": telNovo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      nomeISFL.text = nomeISFLNovo;
      nomeResponsavel.text = nomeResponsavelNovo;
      emailISFL.text = emailISFLNovo;
      telefoneISFL.text = telNovo;

      notifyListeners();
      print('Informações de usuário atualizadas com sucesso');
    } else {
      print(response.body);
    }
  }
}
