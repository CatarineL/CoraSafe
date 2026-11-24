import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Instituicaocflprovider extends ChangeNotifier {
  final idICFL = TextEditingController();
  final nomeICFL = TextEditingController();
  final telefoneICFL = TextEditingController();
  final emailICFl = TextEditingController();

  //pegando os valores quando precisar
  String get idicfl => idICFL.text;
  String get nomeicfl => nomeICFL.text;
  String get telefoneicfl => telefoneICFL.text;
  String get emailicfl => emailICFl.text;

  //lendo dados icfl
  Future<String> lendoDados(String idICFL_fk) async {
    final url = Uri.parse('http://192.168.0.2:8000/lendoDadosICFL/$idICFL_fk');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idICFL": idICFL_fk}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(response.body);

      print('TIPO: ${saidaDados.runtimeType}');
      print('DADOS: $saidaDados');
      emailICFl.text = saidaDados.toString();
      return emailICFl.text;
    } else {
      return 'email não encontrado';
    }
  }

  Future<String> lendoNome(int idICFL_fk) async {
    final url = Uri.parse('http://192.168.0.2:8000/lendoDadosNomeICFL/$idICFL_fk');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idICFL": idICFL_fk}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(response.body);

      nomeICFL.text = saidaDados.toString();
      return nomeICFL.text;
    } else {
      return 'nome não encontrado';
    }
  }
}
