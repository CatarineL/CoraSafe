//classe de usuario provider
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuarioprovider  extends ChangeNotifier{

  final idUsuario = TextEditingController();
  final nomeUsuario = TextEditingController();
  final dataNascimento = TextEditingController();
  final cpf = TextEditingController();
  String? tipoUsuario;
  final emailPessoal = TextEditingController();
  final emailFamiliar = TextEditingController();
  final senha = TextEditingController();
  final sexo = TextEditingController();
  final telefone = TextEditingController();
  final restricao = TextEditingController();

  //pegando os valores quando precisar
  String get idusuario => idUsuario.text;
  String get nome => nomeUsuario.text;
  String get datanascimento => dataNascimento.text;
  String get CPF => cpf.text;
  String get tipousuario => tipoUsuario ?? '';
  String get emailpessoal => emailPessoal.text;
  String get emailfamiliar => emailFamiliar.text;
  String get Senha => senha.text;
  String get Sexo => sexo.text;
  String get Telefone => telefone.text;
  String get Restricao => restricao.text;


  //função de criação de usuário
  void criarUsuario() async{
    final url = Uri.parse('http://192.168.0.6:8000/usuarios');//http://10.0.2.2:8000/usuarios

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "idUsuario": idUsuario.text,
          "nomeUsuario": nomeUsuario.text,
          "dataNascimentoUsuario": dataNascimento.text,
          "cpfUsuario": cpf.text,//int.parse(cpf.text),
          "sexo": sexo.text,
          "emailUsuario": emailPessoal.text,
          "emailFamiliar": emailFamiliar.text,
          "telefone": telefone.text,
          "senha": senha.text,
          "restricaoAlimentar": restricao.text,
          "tipoUsuario": tipoUsuario,//tipoUsuario.text == "true" ? true : false,
        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('usuario cadastrado');
    }else{
      print(response.body);
    }
  }

  //função de login
  Future<bool> loginUsuario(String email, String senha) async{
    final url = Uri.parse('http://192.168.0.6:8000/loginUserComum');//http://10.0.2.2:8000/usuarios
    Map<String, dynamic> saidaDados = {};

    final response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({

          "emailUsuario": email,
          "senha": senha,

        })

    );

    if (response.statusCode == 200 || response.statusCode == 201) {//usuario encontrado

      //criando um map para o resultado retornado pelo banco de dados
      saidaDados = jsonDecode(response.body);

      nomeUsuario.text = saidaDados['nomeUsuario'];
      emailPessoal.text = saidaDados['emailUsuario'];
      telefone.text = saidaDados['telefone'];
      dataNascimento.text = saidaDados['dataNascimentoUsuario'];
      emailFamiliar.text = saidaDados['emailFamiliar'];

      return true;
    }else{//usuario não encontrado
      print('usuario não encontrado');
      return false;
    }
  }
}