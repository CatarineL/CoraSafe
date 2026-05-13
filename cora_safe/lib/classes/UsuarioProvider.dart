//classe de usuario provider
import 'package:flutter/cupertino.dart';
//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuarioprovider  extends ChangeNotifier{

  final nomeUsuario = TextEditingController();
  final dataNascimento = TextEditingController();
  final cpf = TextEditingController();
  final tipoUsuario = TextEditingController();
  final emailPessoal = TextEditingController();
  final senha = TextEditingController();
  final sexo = TextEditingController();
  final telefone = TextEditingController();
  final restricao = TextEditingController();

  //pegando os valores quando precisar
  String get nome => nomeUsuario.text;
  String get datanascimento => dataNascimento.text;
  String get CPF => cpf.text;
  String get tipousuario => tipoUsuario.text;
  String get emailpessoal => emailPessoal.text;
  String get Senha => senha.text;
  String get Sexo => sexo.text;
  String get Telefone => telefone.text;
  String get Restricao => restricao.text;

  void criarUsuario() async{
    final url = Uri.parse('http://192.168.0.5:8000/usuarios');//http://10.0.2.2:8000/usuarios

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          //"idUsuario": this.nomeUsuario,
          "nomeUsuario": nomeUsuario.text,
          "dataNascimentoUsuario": dataNascimento.text,
          "cpfUsuario": cpf.text,//int.parse(cpf.text),
          "sexo": sexo.text,
          "emailUsuario": emailPessoal.text,
          "telefone": telefone.text,
          "senha": senha.text,
          "restricaoAlimentar": null,//restricao.text == "true" ? true : false,
          "tipoUsuario": null,//tipoUsuario.text == "true" ? true : false,
        })

    );

    if (response.statusCode ==200 || response.statusCode == 201) {
      print('usuario cadastrado');
    }else{
      print(response.body);
    }
  }
}