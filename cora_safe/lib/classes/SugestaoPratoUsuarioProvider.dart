import 'package:cora_safe/classes/SugestaoPratoUsuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class SugestaoPratoUsuarioProvider extends ChangeNotifier {
  List<SugestaoPratoUsuario> pratos = [];

  //metodo de criacao dedados
  Future<void> criarSugestaoPratoUsuario(int idPrato, int idUsuario_fk, String status, DateTime data) async{
    final url = Uri.parse('http://192.168.0.3:8000/sugestao_prato_usuario');
    int idSugestaoPratoUsuario = 0;

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idPrato": idPrato,
          "idUsuario_fk": idUsuario_fk,
          "status": status,
          "datacriacao": data.toIso8601String().split('T')[0], //DateTime.now().toIso8601String(),
        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dados = jsonDecode(response.body);
      idSugestaoPratoUsuario = dados["idsugestaopratousuario"];

    }else{
      print(response.body);
    }
  }

  //metodo de leitura de dados
  Future<List<SugestaoPratoUsuario>> lendoSugestao(int idUsuario_fk) async{
    final url = Uri.parse('http://192.168.0.3:8000/sugestao_pratoAceitas');

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idUsuario_fk": idUsuario_fk,
        })

    );
    print("STATUS: ${response.statusCode}");
    print("ERRO DETALHADO: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {//usuario encontrado

      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      print('Resposta da API: ${response.body}');

      pratos = saidaDados.map<SugestaoPratoUsuario>((item)  {
        return SugestaoPratoUsuario(
          idPrato: item["idprato"],
          idUsuario_fk: item["idusuario_fk"],
          status: item["status"],
          datacriacao: item["datacriacao"]!= null
              ? DateTime.parse(item["datacriacao"])
              : null,
        );
      }).toList();
      notifyListeners();
      print("Quantidade de sugestões recebidas: ${saidaDados.length}");
      print("Dados recebidos: $saidaDados");
      return  pratos;
    }else{//usuario não encontrado
      print('sugestão de usuário não encontrado');

      return [];
    }
  }
}

