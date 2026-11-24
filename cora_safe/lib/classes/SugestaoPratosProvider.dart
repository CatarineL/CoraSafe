import 'dart:core';
import 'package:cora_safe/classes/SugestaoPratos.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sugestaopratosprovider extends ChangeNotifier {
  List<Sugestaopratos> pratos = [];

  Future<List<Sugestaopratos>> lendoPratos(String restricao) async {
    final url = Uri.parse('http://192.168.0.3:8000/sugestao_prato');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"restricao": restricao}),
    );

    print("STATUS: ${response.statusCode}");
    print("RESPOSTA: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //criando uma lista dinamica para o resultado retornado pelo banco de dados
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      print('Resposta da API: ${response.body}');

      pratos = saidaDados.map((item) {
        return Sugestaopratos(
          idPrato: item["idPrato"],
          nomePrato: item["nomePrato"],
          Descricao: item["descricao"],
          Restricao: item["restricao"],
          linkPrato: item["linkPrato"],
        );
      }).toList();
      notifyListeners();

      return pratos;
    } else {
      print('pratos de usuario não encontrados');
      return [];
    }
  }
}
