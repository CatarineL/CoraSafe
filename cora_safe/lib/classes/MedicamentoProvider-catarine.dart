import 'dart:convert';
import 'package:cora_safe/classes/Medicamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MedicamentoProvider extends ChangeNotifier {
  List<Medicamento> medicamentos = [];

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

  Future<bool> adicionarMedicamento(XFile imagem, String idUsuario_fk) async {
    final url = Uri.parse('http://192.168.0.3:8000/criar_medicamento');
    final request = http.MultipartRequest('POST', url);

    request.fields['idUsuario_fk'] = idUsuario_fk;

    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('medicamento cadastrado');
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  //*****de alguma forma tenho que passar o id da pessoa logada para a função de criar item*****
  Future<List<Medicamento>> lendoItens(String idUsuarioComum) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/visualizandoMedicamentos',
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

      medicamentos = saidaDados.map((item) {
        return Medicamento(
          idMedicamento: item["idMedicamento"].toString(),
          nomeMedicamento: item["nomeMedicamento"] ?? '',
          validadeMedicamento: item["validadeMedicamento"],
          para: item["para"],
          horarioMedicamentoIntervalo: item["horarioMedicamentoIntervalo"],
        );
      }).toList();
      notifyListeners();

      return medicamentos;
    } else {
      //usuario não encontrado
      print('produtos de usuario não encontrado');
      return [];
    }
  }

  //+ adicionarProduto() : void
  Future<bool> adicionarMedicamentoISFL(XFile imagem, String idISFL_fk) async {
    //Produto produto
    final url = Uri.parse('http://192.168.0.3:8000/criar_medicamentoISFL'); //8003
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
  Future<List<Medicamento>> lendoItensISFL(String idISFL) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/visualizandoMedicamentosISFL',
    ); //http://10.0.2.2:8000/usuarios

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

      medicamentos = saidaDados.map((item) {
        return Medicamento(
          idMedicamento: item["idMedicamento"].toString(),
          nomeMedicamento: item["nomeMedicamento"] ?? '',
          validadeMedicamento: item["validadeMedicamento"],
          para: item["para"],
          horarioMedicamentoIntervalo: item["horarioMedicamentoIntervalo"],
        );
      }).toList();
      notifyListeners();

      return medicamentos;
    } else {
      //usuario não encontrado
      print('produtos de usuario não encontrado');
      return [];
    }
  }

  //+ editarProduto() : void
  //void editarProduto() {}
  Future<void> editarMedicamento(
    String idMedicamento,
    String nomeMedicamento,
    String validadeMedicamento,
    String horarioMedicamentoIntervalo,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_medicamentos/$idMedicamento',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeMedicamento": nomeMedicamento,
        "validadeMedicamento": validadeMedicamento,
        "horarioMedicamentoIntervalo": horarioMedicamentoIntervalo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('medicamento atualizado');
    } else {
      print(response.body);
    }
  }

  Future<void> editarMedicamentoISFL(
      String idMedicamento,
      String nomeMedicamento,
      String validadeMedicamento,
      String para,
      String horarioMedicamentoIntervalo,
      ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualizando_medicamentosISFL/$idMedicamento',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeMedicamento": nomeMedicamento,
        "validadeMedicamento": validadeMedicamento,
        "para": para,
        "horarioMedicamentoIntervalo": horarioMedicamentoIntervalo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('medicamento atualizado');
    } else {
      print(response.body);
    }
  }

  Future<void> excluirMedicamento(int idMedicamento) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/excluindoMedicamentos/$idMedicamento',
    );

    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('medicamento excluído');
    } else {
      print(response.body);
    }
  }
}
