import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Produto.dart';
import 'package:image_picker/image_picker.dart';

class Produtoprovider extends ChangeNotifier {
  List<Produto> produtos = [];

  //enviando a imagem para a api
  Future<void> enviandoImagem(XFile imagem) async {
    final url = Uri.parse('http://192.168.0.3:8000/selecao_imagem');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('imagem', imagem.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Imagem enviada para a API');
    }
  }

  //+ adicionarProduto() : void
  Future<bool> adicionarProduto(XFile imagem, String idUsuario_fk) async {
    //Produto produto
    final url = Uri.parse('http://192.168.0.3:8000/criar_produto');
    final request = http.MultipartRequest('POST', url);

    request.fields['idUsuario_fk'] = idUsuario_fk;

    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Lista cadastrada");
      return true;
    }
    else {
      print(response.body);
      return false;
    }
  }

  //+ adicionarProduto() : void
  Future<bool> adicionarProdutoISFL(XFile imagem, String idISFL_fk) async {
    //Produto produto
    final url = Uri.parse('http://192.168.0.3:8000/criar_produtoISFL');
    print('Enviando requisição...');

    final request = http.MultipartRequest('POST', url);

    request.fields['idISFL_fk'] = idISFL_fk;

    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('produto cadastrado');
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  //*****de alguma forma tenho que passar o id da pessoa logada para a função de criar item*****
  Future<List<Produto>> lendoItens(String idUsuarioComum) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/visualizandoProdutos',
    ); //http://10.0.2.2:8000/usuarios

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idUsuario_fk": idUsuarioComum}),
    );
    //print('Enviando idUsuario_fk: "$idUsuarioComum"');
    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando uma lista dinamica para o resultado retornado pelo banco de dados
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      print('Resposta da API: ${response.body}');

      produtos = saidaDados.map((item) {
        return Produto(
          idProduto: item["idProduto"].toString(),
          idUsuario_fk: item["idUsuario_fk"],
          idISFL_fk: item["idISFL_fk"],
          nomeProduto: item["nomeProduto"] ?? '',
          validadeProduto: item["validadeProduto"],
          statusProduto: item["statusProduto"],
          dataConsumo: item["dataConsumo"],
        );
      }).toList();
      notifyListeners();

      return produtos;
    } else {
      //usuario não encontrado
      print('produtos de usuario não encontrados');
      return [];
    }
  }

  Future<List<Produto>> lendoItensISFL(String idISFL) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/visualizandoProdutosISFL',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idISFL_fk": idISFL}),
    );
    //print('Enviando idUsuario_fk: "$idUsuarioComum"');
    if (response.statusCode == 200 || response.statusCode == 201) {
      //usuario encontrado

      //criando uma lista dinamica para o resultado retornado pelo banco de dados
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));

      print('Resposta da API: ${response.body}');

      produtos = saidaDados.map((item) {
        return Produto(
          idProduto: item["idProduto"].toString(),
          idUsuario_fk: item["idUsuario_fk"],
          idISFL_fk: item["idISFL_fk"],
          nomeProduto: item["nomeProduto"] ?? '',
          validadeProduto: item["validadeProduto"],
          statusProduto: item["statusProduto"],
          dataConsumo: item["dataConsumo"],
        );
      }).toList();
      notifyListeners();

      return produtos;
    } else {
      //usuario não encontrado
      print('produtos de usuario não encontrados');
      return [];
    }
  }

  //+ editarProduto() : void
  //void editarProduto() {}
  Future<void> editarProduto(
    String idProduto,
    String nomeProduto,
    String validadeProduto, String? dataC,
    bool? status,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_produtos/$idProduto',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idProduto": idProduto,
        "nomeProduto": nomeProduto,
        "validadeProduto": validadeProduto,
        "statusProduto": status,
        "dataConsumo": dataC,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('produto atualizado');
    } else {
      print(response.body);
    }
  }

  Future<void> editarProdutoStatus(String idProduto, dataC, bool status) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_produtos/$idProduto',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idProduto": idProduto, "statusProduto": status}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('status de produto atualizado');
    } else {
      print(response.body);
    }
  }

  //+ excluirProduto() : void
  Future<void> excluirProduto(String idProduto) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/excluindoProdutos/$idProduto',
    );

    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('produto excluído');
    } else {
      print(response.body);
    }
  }
}
