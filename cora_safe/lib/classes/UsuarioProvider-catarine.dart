//classe de usuario provider
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuarioprovider extends ChangeNotifier {
  final idUsuario = TextEditingController();
  final nomeUsuario = TextEditingController();
  final dataNascimento = TextEditingController();
  final cpf = TextEditingController();
  String? tipoUsuario;
  final emailPessoal = TextEditingController();
  String? emailFamiliar;
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
  String get emailfamiliar => emailFamiliar ?? '';
  String get Senha => senha.text;
  String get Sexo => sexo.text;
  String get Telefone => telefone.text;
  String get Restricao => restricao.text;

  //função de criação de usuário
  Future<void> criarUsuario() async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/usuarios',
    ); //http://10.0.2.2:8000/usuarios

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario": idUsuario.text,
        "nomeUsuario": nomeUsuario.text,
        "dataNascimentoUsuario": dataNascimento.text,
        "cpfUsuario": cpf.text, //int.parse(cpf.text),
        "sexo": sexo.text,
        "emailUsuario": emailPessoal.text,
        "emailFamiliar": emailFamiliar,
        "telefone": telefone.text,
        "senha": senha.text,
        "restricaoAlimentar": restricao.text,
        "tipoUsuario": tipoUsuario, //tipoUsuario.text == "true" ? true : false,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('usuario cadastrado');
      final dados = jsonDecode(response.body);
      idUsuario.text = dados["idUsuario"].toString();

      print("Usuario criado - ID ${idUsuario.text}");
    } else {
      print(response.body);
    }
  }

  //função de login
  Future<bool> loginUsuario(String email, String senha) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/loginUserComum',
    ); //http://10.0.2.2:8000/usuarios
    Map<String, dynamic> saidaDados = {};

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"emailUsuario": email, "senha": senha}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando um map para o resultado retornado pelo banco de dados
      saidaDados = jsonDecode(response.body);

      idUsuario.text = saidaDados['idUsuario'].toString();
      nomeUsuario.text = saidaDados['nomeUsuario'];
      emailPessoal.text = saidaDados['emailUsuario'];
      telefone.text = saidaDados['telefone'];
      dataNascimento.text = saidaDados['dataNascimentoUsuario'];
      emailFamiliar = saidaDados['emailFamiliar'];

      return true;
    } else {
      //usuario não encontrado
      print('usuario não encontrado');
      return false;
    }
  }

  Future<void> editarInformacaoUserComum(
    String idUsuario,
    String nomeUsuario,
    String emailUsuario,
    String tel,
    String emailFam,
    String restAlm,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_informacoesUserComum/$idUsuario',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario": idUsuario,
        "nomeUsuario": nomeUsuario,
        "emailUsuario": emailUsuario,
        "telefone": tel,
        "emailFamiliar": emailFam,
        "restricaoAlimentar": restAlm,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Informações de usuário atualizadas com sucesso');
    } else {
      print(response.body);
    }
  }

  //função de verificacao de CPF
  Future<int?> buscaCPF(String CPF) async {
    final url = Uri.parse('http://192.168.0.3:8000/verificaCPF');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"cpfUsuario": CPF}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado
      final Map<String, dynamic> saidaDados = jsonDecode(response.body);
      //criando um map para o resultado retornado pelo banco de dados

      return saidaDados['idUsuario'];
    } else {
      //usuario não encontrado
      print('cpf de usuario não encontrado');
      return null;
    }
  }

  Future<String> lendoDadosUsuarioComum(int idUsuario) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/lendoDadosUsuarioComum/$idUsuario',
    );

    final response = await http.post(url);

    print("STATUS LENDO DADOS: ${response.statusCode}");
    print("BODY LENDO DADOS: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //criando um map para o resultado retornado pelo banco de dados
      final nome = jsonDecode(response.body).toString();
      nomeUsuario.text = nome;
      print("NOME DENTRO DO PROVIDER: ${nomeUsuario.text}");

      return nome;
    } else {
      //usuario não encontrado
      print('usuario não encontrado');
      return "Não encontrado o nome";
    }
  }
}
