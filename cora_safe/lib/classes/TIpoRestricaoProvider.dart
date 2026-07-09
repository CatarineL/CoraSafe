import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class Tiporestricaoprovider extends ChangeNotifier {

  final idUsuario_fk = TextEditingController();
  final idISFL_fk = TextEditingController();
  String? nomeRestricao;


  //pegando os valores quando precisar
  String get idusuario_fk => idUsuario_fk.text;
  String get idisfl_fk => idISFL_fk.text;
  String get nomerestricao => nomeRestricao ?? '';

  //função de cadastrao de restrições
  void criarRestricao() async{
    final url = Uri.parse('http://192.168.0.5:8000/restricao');

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          //"idUsuario": this.nomeUsuario,
          "idUsuario_fk": idUsuario_fk.text,
          "idISFL_fk": idISFL_fk.text,
          "nomeRestricao": nomeRestricao,//int.parse(cpf.text),

        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Tipos de Restrição cadastardas');
    }else{
      print(response.body);
    }
  }

}