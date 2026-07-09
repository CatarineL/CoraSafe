//classe provider
import 'dart:core';
import 'package:cora_safe/screens/visualizarDispensaUserComum.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Produto.dart';

class Produtoprovider extends ChangeNotifier {
  List<Produto> produtos = [];

  //de alguma forma tenho que passar o id da pessoa logada para a função de criar item

  Future<List<Produto>> lendoItens(String idUsuarioComum) async {
    final url = Uri.parse(
      'http://192.168.0.6:8002/visualizandoProdutos',
    ); //http://10.0.2.2:8000/usuarios

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idUsuario_fk": idUsuarioComum}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando um map para o resultado retornado pelo banco de dados
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      produtos = saidaDados.map((item) {
        return Produto(
          idProduto: item["idProduto"] ?? '',
          idUsuario_fk: item["idUsuario_fk"],
          idISFL_fk: item["idISFL_fk"],
          nomeProduto: item["nomeProduto"] ?? '',
          validadeProduto: item["validadeProduto"],
        );
      }).toList();
      notifyListeners();

      return produtos;
    } else {
      //usuario não encontrado
      print('produtos de usuario não encontrado');
      return [];
    }
  }

  //metodos da classe
  //+ adicionarProduto() : void
  void adicionarProduto() {}

  //+ editarProduto() : void
  void editarProduto() {}

  //+ vizualizarProduto() : void
  void vizualizarProduto() {}

  //+ visualizarDispensaAtual() : void
  void visualizarDispensaAtual() {}

  //+ excluirProduto() : void
  void excluirProduto() {}

  //+ produtoValidadeProxima() : void- produtoFrequente() : void
  void produtoValidadeProxima() {}

  //+ pratoDia() : void
  void pratoDia() {}

  //- criarRelatorio() : void
  void criarRelatorio() {}

  //+ visualizarRelatorio() : void
  void visualizarRelatorio() {}

  //+ baixarRelatorio() : void
  void baixarRelatorio() {}

  //+ compartilharRelatorio() : void
  void compartilharRelatorio() {}
  /*
  String? idProduto;
  String? idUsuario_fk;
  String? idISFL_fk;
  String nomeProduto;
  String? validadeProduto;
  List<Produtoprovider> produtos = [];

  //pegando os valores quando precisar
  String get idproduto => idProduto ?? '';
  String get idusuario_fk => idUsuario_fk  ?? '';
  String get idisfl_fk => idISFL_fk  ?? '';
  String get nomeproduto => nomeProduto;
  String get validadeproduto => validadeProduto ?? '';

  Produtoprovider({
    required this.idProduto,
    this.idUsuario_fk,
    this.idISFL_fk,
    required this.nomeProduto,
    this.validadeProduto
  });

  factory Produtoprovider.fromJson(Map<String, dynamic> json) {
    return Produtoprovider(
      idProduto: json['idProduto'],
      idUsuario_fk: json['idUsuario_fk'],
      idISFL_fk: json['idISFL_fk'],
      nomeProduto: json['nomeProduto'],
      validadeProduto: json['dataValidade'],
    );
  }

  Future<List<Produtoprovider>> lendoItens() async{
    final url = Uri.parse('http://192.168.0.4:8002/produtos_identificados');

    final retorno = await  http.get(url);
    if (retorno.statusCode ==200){
      //Map<String, dynamic> objeto = jsonDecode(retorno.body);


      List<dynamic> dados = jsonDecode(utf8.decode(retorno.bodyBytes));

      produtos = dados
          .map((item) => Produtoprovider.fromJson(item))
          .toList();

      notifyListeners();
      print("Entrou em lendoItens()");
      print(retorno.statusCode);
      print(retorno.body);
      return produtos;
    }
    else{
      throw Exception('Erro ao carregar produtos');
    }
  }

*/
}
