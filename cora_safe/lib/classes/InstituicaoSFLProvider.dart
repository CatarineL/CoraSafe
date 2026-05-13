import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class InstituicaosflProvider extends ChangeNotifier{
  final nomeISFL = TextEditingController();
  final nomeResponsavel = TextEditingController();
  final cnpj = TextEditingController();
  final tipoUsuario = TextEditingController();
  final emailISFL = TextEditingController();
  final senha = TextEditingController();
  final telefoneISFL = TextEditingController();
  final restricaoAlimentar = TextEditingController();

  //pegando os valores quando precisar
  String get nomeisfl => nomeISFL.text;
  String get nomeresponsavel => nomeResponsavel.text;
  String get CNPJ => cnpj.text;
  String get tipousuario => tipoUsuario.text;
  String get emailisfl => emailISFL.text;
  String get Senha => senha.text;
  String get telefoneisfl => telefoneISFL.text;
  String get restricaoalimentar => restricaoAlimentar.text;


  void criarISFL() async{
    final url = Uri.parse('http://192.168.0.5:8000/ISFL');//http://10.0.2.2:8000/usuarios

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          //"idUsuario": this.nomeUsuario,
          "nomeISFL": nomeISFL.text,
          "nomeResponsavel": nomeResponsavel.text,
          "cnpj": cnpj.text,//int.parse(cpf.text),
          "tipoUsuario": int.parse(tipoUsuario.text),
          "emailISFL": emailISFL.text,
          "telefoneISFL": telefoneISFL.text,
          "senha": senha.text,
          "restricaoAlimentar": null,//tipoUsuario.text == "true" ? true : false,
        })

    );

    if (response.statusCode ==200 || response.statusCode == 201) {
      print('usuario cadastrado');
    }else{
      print(response.body);
    }
  }
}