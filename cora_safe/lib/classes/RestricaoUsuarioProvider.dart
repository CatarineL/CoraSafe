import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class TipoRestricaoUsuarioProvider extends ChangeNotifier {

  int idRestricao = 0;
  int idUsuario_fk = 0;


  int get idrestricao => idRestricao;
  int get idusuario_fk => idUsuario_fk;

  //função de cadastrao de restrições
  void criarRestricaoUsuario() async{
    final url = Uri.parse('http://192.168.0.4:8000/restricao_usuario');

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idRestricao": idRestricao,
          "idUsuario_fk": idUsuario_fk,

        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Tipo de Restrição de usuário cadastrada');
    }else{
      print(response.body);
    }
  }

}