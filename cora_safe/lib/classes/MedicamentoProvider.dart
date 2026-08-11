import 'dart:convert';
import 'package:cora_safe/classes/Medicamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MedicamentoProvider extends ChangeNotifier {
  List<Medicamento> medicamentos = [];

  //enviando a imagem para a api
  Future<void> enviandoImagem(XFile imagem) async {
    final url = Uri.parse('http://192.168.0.6:8003/selecao_imagem');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('imagem', imagem.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Imagem enviada para a API');
    }
  }

  //+ adicionarProduto() : void
  Future<void> adicionarProduto(XFile imagem, String idUsuario_fk) async {
    //Produto produto
    final url = Uri.parse('http://192.168.0.6:8003/criar_medicamento');
    print('Enviando requisição...');

    final request = http.MultipartRequest('POST', url);

    request.fields['idUsuario_fk'] = idUsuario_fk;

    request.files.add(await http.MultipartFile.fromPath('imagem', imagem.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('produto cadastrado');
    } else {
      print(response.body);
    }
  }

  //*****de alguma forma tenho que passar o id da pessoa logada para a função de criar item*****
  Future<List<Medicamento>> lendoItens(String idUsuarioComum) async {
    final url = Uri.parse(
      'http://192.168.0.6:8003/visualizandoMedicamentos',
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
          idUsuario_fk: item["idUsuario_fk"],
          idISFL_fk: item["idISFL_fk"],
          nomeMedicamento: item["nomeMedicamento"] ?? '',
          validadeMedicamento: item["validadeMedicamento"],
          para: item["para"],
          horarioMedicamentoIntervalo: item["horarioMedicamentoIntervalo"]
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
  Future<void> editarProduto(
    String idMedicamento,
    String nomeMedicamento,
    String validadeMedicamento,
    String para,
    String horarioMedicamentoIntervalo,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.6:8003/atualizando_medicamentos/$idMedicamento',
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeMedicamento": nomeMedicamento,
        "validadeMedicamento": validadeMedicamento,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('medicamento atualizado');
    } else {
      print(response.body);
    }
  }

  //+ excluirProduto() : void
  //void excluirProduto() {}
  Future<void> excluirProduto(String idMedicamento) async {
    final url = Uri.parse(
      'http://192.168.0.6:8002/excluindoMedicamentos/$idMedicamento',
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

  //metodos
  //+ adicionarMedicamento() : void
  void adicionarMedicamento() {}
  //+ horarioMedicacao() : void
  void horarioMedicacao() {}
  //+ editarMedicamento() : void
  void editarMedicamento() {}
  //+ visualizarMedicamento() : void
  void visualizarMedicamento() {}
  //+ excluirMedicamento() : void
  void excluirMedicamento() {}
}
