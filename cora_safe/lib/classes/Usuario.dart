//classe usuario
//Modelo Lógico: Usuario(idUsuario_PK, nomeUsuario, dataNascimento, sexo, cpf, emailPessoal, telefone, senha, restrição, tipoUsuario

//criand a classe Usuario
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as htimport 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;


class Usuario{
  // //atributos da classe
  // //final int idUsuario_PK;
  final String nomeUsuario;
  final DateTime dataNascimento;
  final String cpf;
  final String tipoUsuario;
  final String emailPessoal;
  final String senha;
  final String sexo;
  final int telefone;
  final bool restricao;
  //
  // //Classe construtor
  Usuario(
  //   //this.idUsuario_PK,
    this.nomeUsuario,
    this.dataNascimento,
    this.cpf,
    this.sexo,
    this.emailPessoal,
    this.telefone,
    this.senha,
    this.restricao,
    this.tipoUsuario
  );

  //set e get
  //metodo que faz a requisição GET
  //Future<void> buscaUsuario() async{
  //   final response = await http.get(
  //     Uri.parse('http://10.0.2.2:8000/usuarios')
  //   );
  //
  //   if (response.statusCode == 200){
  //     var dados = jsonDecode(response.body);
  //     //print(dados);
  //   }
  //   else{
  //     //print('Erro: ${response.statusCode}');
  //   }
  // }
  //
  void criarUsuario() async{
     final response = await http.post(
       Uri.parse('http://10.0.2.2:8000/usuarios'),
       headers: {"Content-Type":"application/json"},
       body: jsonEncode({
         //"idUsuario": this.nomeUsuario,
         "nomeUsuario": this.nomeUsuario,
         "dataNascimento": this.dataNascimento,
         "sexo": this.sexo,
         "emailPessoal": this.emailPessoal,
         "telefone": this.telefone,
         "senha": this.senha,
         "restricao": this.restricao,
         "tipoUsuario": this.tipoUsuario,
         "restricao": this.restricao
       })

     );

     if (response.statusCode ==200) {
       print('usuario cadastrado');
     }else{
       print('erro ao cadastrar usuário');
     }
   }
  //
  // //metodos
  // //cadastroUsuario() : void
  // void cadastroUsuario(idUsuario_PK, nomeUsuario,dataNascimento, sexo, emailPessoal, telefone, senha, restricao, tipoUsuario){
  //   // objetivo - INSERT
  //   // receber dados do usuário e salvar eles na tabela usuário do banco de dados (local/nuvem)
  //   if(idUsuario_PK!=Null && nomeUsuario!=Null && dataNascimento!=Null && sexo!=Null && emailPessoal!=Null && telefone!=Null && senha!=Null
  //   && restricao!=Null && tipoUsuario!=Null){
  //     "INSERT INTO usuario (idUsuario, nomeUsuario, dataNascimentoUSuario, cfpUsuario, tipoUsuario, emailUsuario, senha, sexo, telefone) VALUES ($idUsuario_PK, $nomeUsuario, $dataNascimento, $sexo, $emailPessoal, $telefone, $senha, $restricao,$tipoUsuario);";
  //   }else{
  //     printToConsole("Erro");
  //   }
  //
  // }
  //
  // //loginUsuario() : void
  // void loginUsuario(){}
  //
  // //editarUsuario() : void
  // void editarUsuario() {}
  //
  // //seguranca() : void
  // void seguranca(){}
  //
  // //preferencia() : void
  // void preferencia() {}
  //
  // //ajuda() : void
  // void ajuda() {}
  //
  // //sair() : void
  // void sair() {}


}