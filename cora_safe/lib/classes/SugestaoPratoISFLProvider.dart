import 'package:cora_safe/classes/SugestaoPratoISFL.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';


class SugestaoPratoISFLProvider extends ChangeNotifier {
  List<SugestaoPratoISFL> pratos = [];

  //metodo de criacao dedados
  Future<void> criarSugestaoPratoUsuarioISFL(int idPrato, int idisfl_fk, String status, DateTime data) async{
    final url = Uri.parse('http://192.168.0.4:8000/sugestao_prato_isfl');
    int idSugestaoPratoUsuarioISFL = 0;

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idPrato": idPrato,
          "idISFL_fk": idisfl_fk,
          "status": status,
          "datacriacao": data.toIso8601String().split('T')[0],
        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dados = jsonDecode(response.body);
      idSugestaoPratoUsuarioISFL = dados["idsugestaopratousuarioisfl"];

    }else{
      print(response.body);
    }
  }

  //metodo de leitura de dados
  Future<List<SugestaoPratoISFL>> lendoSugestaoISFL(int idisfl_fk) async{
    final url = Uri.parse('http://192.168.0.4:8000/sugestao_pratoAceitas_isfl');

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idISFL_fk": idisfl_fk,
        })

    );
    print("STATUS: ${response.statusCode}");
    print("ERRO DETALHADO: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {//usuario encontrado

      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      print('Resposta da API: ${response.body}');

      pratos = saidaDados.map<SugestaoPratoISFL>((item)  {
        return SugestaoPratoISFL(
          idPrato: item["idprato"],
          idISFL_fk: item["idisfl_fk"],
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
      print('sugestão de instituição não encontrada');

      return [];
    }
  }
}

