import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuariofamiliarProvider extends ChangeNotifier{

  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cpf = TextEditingController();
  String? tipoUsuario;
  final emailFamiliar = TextEditingController();
  final senha = TextEditingController();
  final sexo = TextEditingController();
  final telefone = TextEditingController();

  //pegando os valores quando precisar
  String get nomeFamiliar => nome.text;
  String get datanascimento => dataNascimento.text;
  String get CPF => cpf.text;
  String get tipousuario => tipoUsuario ?? '';
  String get emailfamiliar => emailFamiliar.text;
  String get Senha => senha.text;
  String get Sexo => sexo.text;
  String get Telefone => telefone.text;


  void criarUsuario() async{
    final url = Uri.parse('http://192.168.0.5:8000/usuario_familiar');//http://10.0.2.2:8000/usuarios

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          //"idUsuario": this.nomeUsuario,
          "nome": nome.text,
          "dataNascimento": dataNascimento.text,
          "cpf": cpf.text,//int.parse(cpf.text),
          "sexo": sexo.text,
          "emailFamiliar": emailFamiliar.text,
          "telefone": telefone.text,
          "senha": senha.text,
          "tipoUsuario": tipoUsuario,//tipoUsuario.text == "true" ? true : false,
        })

    );

    if (response.statusCode ==200 || response.statusCode == 201) {
      print('usuario cadastrado');
    }else{
      print(response.body);
    }
  }
}