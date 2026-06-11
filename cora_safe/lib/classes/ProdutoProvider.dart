//classe provider
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Produtoprovider  extends ChangeNotifier{
  String? idProduto;
  String nomeProduto;
  String? dataValidade;
  List<Produtoprovider> produtos = [];



  //pegando os valores quando precisar
  String get idproduto => idProduto  ?? '';
  String get nomeproduto => nomeProduto;
  String get datavalidade => dataValidade ?? '';


  Produtoprovider({
    this.idProduto,
    required this.nomeProduto,
    this.dataValidade
  });

  


  //função de leitura de itens
  /*List<Produtoprovider> itensFromJson(List<dynamic> itensjson){
    return itensjson
        .map((item) => Produtoprovider.fromJson(item))
        .toList();
  }*/
  /*void lendoItens() async{
    final url = Uri.parse('http://192.168.0.5:8000/produtos_cadastrados');


    final retorno = await http.post(
        //lista dinamica de itens a serem recebidos
        //List<dynamic> dados = jsonDecode(retorno.body);
        //List<Produtoprovider> produtos = produtosFromJson(dados);
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({

          "idProduto": idProduto,
          "nomeProduto": nomeProduto,
          "dataValidade": dataValidade,

        })

    );

    if (retorno.statusCode == 200 || retorno.statusCode == 201) {
      print('Produto cadastrado');
    }else{
      print(retorno.body);
    }
  }*/
  factory Produtoprovider.fromJson(Map<String, dynamic> json) {
    return Produtoprovider(
      idProduto: json['idProduto'],
      nomeProduto: json['item'],
      dataValidade: json['dataValidade'],
    );
  }

  Future<List<Produtoprovider>> lendoItens() async{
    final url = Uri.parse('http://192.168.0.7:8000/produtos_identificados');

    final retorno = await  http.get(url);
    if (retorno.statusCode ==200){
      Map<String, dynamic> objeto = jsonDecode(retorno.body);

      List<dynamic> dados = objeto["itens"];

      produtos = dados
          .map((item) => Produtoprovider.fromJson(item))
          .toList();

      notifyListeners();
      print("Entrou em lendoItens()");
      return produtos;
    }
    else{
      throw Exception('Erro ao carregar produtos');
    }
  }


}
