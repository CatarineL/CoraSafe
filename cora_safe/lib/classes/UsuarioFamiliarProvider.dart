import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuariofamiliarProvider extends ChangeNotifier {
  final idUsuarioFamiliar = TextEditingController();
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cpf = TextEditingController();
  String? tipoUsuario;
  final emailFamiliar = TextEditingController();
  final senha = TextEditingController();
  final sexo = TextEditingController();
  final telefone = TextEditingController();
  String? idUsuarioComumFK;

  //pegando os valores quando precisar
  String get idusuariofamiliar => idUsuarioFamiliar.text;
  String get Nome => nome.text;
  String get datanascimento => dataNascimento.text;
  String get CPF => cpf.text;
  String get tipousuario => tipoUsuario ?? '';
  String get emailfamiliar => emailFamiliar.text;
  String get Senha => senha.text;
  String get Sexo => sexo.text;
  String get Telefone => telefone.text;
  String get idusuariocomumFK => idUsuarioComumFK ?? '';

  Future<void> criarUsuario() async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/usuario_familiar',
    ); //ver sempre o ip da maquina local

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //"idUsuario": this.nomeUsuario,
        "nome": nome.text,
        "dataNascimento": dataNascimento.text,
        "cpf": cpf.text, //int.parse(cpf.text),
        "sexo": sexo.text,
        "emailFamiliar": emailFamiliar.text,
        "telefone": telefone.text,
        "senha": senha.text,
        "tipoUsuario": tipoUsuario, //tipoUsuario.text == "true" ? true : false,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(response.body);

      idUsuarioFamiliar.text = saidaDados['idUsuario'].toString();
      print('usuario cadastrado: ${idUsuarioFamiliar}');
    } else {
      print(response.body);
    }
  }

  //função de login
  Future<bool> loginUsuarioFamiliar(String email, String senha) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/loginUserResponsavel',
    ); //http://10.0.2.2:8000/usuarios
    Map<String, dynamic> saidaDados = {};

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"emailFamiliar": email, "senha": senha}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando um map para o resultado retornado pelo banco de dados
      saidaDados = jsonDecode(response.body);

      idUsuarioFamiliar.text = saidaDados['idUsuario'].toString();
      nome.text = saidaDados['nome'];
      dataNascimento.text = saidaDados['dataNascimento'];
      cpf.text = saidaDados['cpf'];
      telefone.text = saidaDados['telefone'];
      emailFamiliar.text = saidaDados['emailFamiliar'];
      sexo.text = saidaDados['sexo'];
      idUsuarioComumFK = saidaDados['idUsuarioComum']?.toString();

      return true;
    } else {
      //usuario não encontrado
      print('usuario não encontrado');
      return false;
    }
  }

  Future<void> lendoDados(String emailFam) async {
    final url = Uri.parse('http://192.168.0.3:8000/lendoDados');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"emailFamiliar": emailFam}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando um map para o resultado retornado pelo banco de dados
      final saidaDados = jsonDecode(response.body);
      print("STATUS LENDO DADOS: ${response.statusCode}");
      print("BODY LENDO DADOS: ${response.body}");

      idUsuarioFamiliar.text = saidaDados['idUsuario'].toString();
      nome.text = saidaDados['nome']?.toString() ?? '';
      dataNascimento.text = saidaDados['dataNascimento']?.toString() ?? '';
      cpf.text = saidaDados['cpf']?.toString() ?? '';
      telefone.text = saidaDados['telefone']?.toString() ?? '';
      emailFamiliar.text = saidaDados['emailFamiliar']?.toString() ?? '';
      //tipoUsuario = saidaDados['tipoUsuario'];
      sexo.text = saidaDados['sexo']?.toString() ?? '';
      print("NOME DENTRO DO PROVIDER: ${nome.text}");
      notifyListeners();
    } else {
      //usuario não encontrado
      print('usuario não encontrado');
    }
  }

  //metodo de editar dados gerais
  Future<void> editarInformacaoUserFamiliar(
    int idUsuario,
    String nomeUsuario,
    String tel,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_informacoesUserFamiliar/$idUsuario',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeUsuario": nomeUsuario,
        "telefone": tel,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Informações de usuário atualizadas com sucesso');
    } else {
      print(response.body);
    }
  }

  //metodo de atualização de id do usuario idoso na tabela de Usuario Familiar
  Future<void> editarIDUsuarioComum(
    String idUserComum,
    String idUserFamiliar,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_campoFK/$idUserFamiliar',
    );

    print("ID FAMILIAR = '$idUserFamiliar'");
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idUsuarioComum": idUserComum}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('id de pessoa idosa atualizado');
    } else {
      print(response.body);
    }
  }
}
