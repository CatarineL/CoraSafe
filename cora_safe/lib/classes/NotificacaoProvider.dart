import 'package:cora_safe/classes/Notificacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NotificacaoProvider extends ChangeNotifier {
  List<Notificacao> notificacoes = [];
  //metodos

  //criarNotificacao() : void
  Future<void> criarNotificacao(
    String? idUsuario,
    String? idUsuarioFamiliar,
    String? idISFL,
    String? idProduto,
    String mensagem,
    String status,
    DateTime dataC,
    String? idMed_fk
  ) async {
    final url = Uri.parse('http://192.168.0.3:8000/notificacao');

    print('ID do usuário enviado: "$idUsuario"');
    print('ID do produto enviado: "$idProduto"');
    print('Mensagem enviada: "$mensagem"');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "idUsuario_fk": idUsuario,
        "idUsuarioFamiliar_fk": idUsuarioFamiliar,
        "idISFL_fk": idISFL,
        "idProduto_fk": idProduto,
        "Mensagem": mensagem,
        "Status": status,
        "dataCriacao": DateFormat('yyyy-MM-dd').format(dataC),
        "idMedicamento_fk": idMed_fk
      }),
    );
    print('Status da verificação: ${response.statusCode}');
    print('Resposta da verificação: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Notificacao cadastrada');
    } else {
      print(response.body);
    }
  }

  Future<String?> retornoIdNotificacaoProduto(String idProdutoFK) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/retornoIDNotificacaoProd?idProd_fk=$idProdutoFK',
    );

    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(utf8.decode(response.bodyBytes));
      if (saidaDados == null){
        return null;
      }
      return saidaDados.toString();
    } else {
      print('Erro na busca');
      return null;
    }
  }

  Future<String?> retornoIdNotificacaoMedicamento(String idMedicamentoFK) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/retornoIDNotificacaoMed?idMed_fk=$idMedicamentoFK',
    );

    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final saidaDados = jsonDecode(utf8.decode(response.bodyBytes));
      if (saidaDados == null){
        return null;
      }
      return saidaDados.toString();
    } else {
      print('Erro na busca');
      return null;
    }
  }

  Future<bool> verificaNotificacaoProduto(String idProdutoFK) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/verificaNotificacaoProd?idProd_fk=$idProdutoFK',
    );

    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body) as bool;
    } else {
      return false;
    }
  }
  Future<bool> verificaNotificacaoMedicamento(String idMedFK) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/verificaNotificacaoMed?idMed_fk=$idMedFK',
    );

    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body) as bool;
    } else {
      return false;
    }
  }

  Future<List<Notificacao>> lendoNotificacoesUsuarioComum(
    String idUsuario,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/lendoNotificacoesUsuarioComum/$idUsuario',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idUsuario_fk": idUsuario}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));
      print('JSON recebido: $saidaDados');
      print('Resposta da API: ${response.body}');

      notificacoes = saidaDados.map<Notificacao>((item) {
        print('ID recebido: ${item["idNotificacao"]}');
        print('Chaves recebidas: ${item.keys.toList()}');
        print('Registro completo: $item');
        return Notificacao(
          idNotificacao: int.tryParse(item["idNotificacao"].toString()) ?? 0,
          idUsuario_fk: item["idUsuario_fk"]?.toString() ?? '',
          idUsuarioFamiliar_fk: item["idUsuarioFamiliar"]?.toString() ?? '',
          idISFL_fk: item["idISFL_fk"]?.toString() ?? '',
          idProduto_fk: item["idProduto_fk"]?.toString() ?? '',
          Mensagem: item["Mensagem"]?.toString() ?? '',
          Status: item["status"]?.toString() ?? '',
          dataCriacao: item["dataCriacao"] != null
              ? DateTime.tryParse(item["dataCriacao"].toString())
              : null,
          idMedicamento_fk: item["idMedicamento_fk"]?.toString()
        );
      }).toList();

      print('Quantidade de notificações: ${notificacoes.length}');
      notifyListeners();

      return notificacoes;
    } else {
      //usuario não encontrado
      print('notificações de usuario não encontrada');
      return [];
    }
  }

  Future<List<Notificacao>> lendoNotificacoesISFL(int idISFL) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/lendoNotificacoesISFL/$idISFL',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idISFL_fk": idISFL}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));
      print('JSON recebido: $saidaDados');
      print('Resposta da API: ${response.body}');

      notificacoes = saidaDados.map<Notificacao>((item) {
        print('ID recebido: ${item["idNotificacao"]}');
        print('Chaves recebidas: ${item.keys.toList()}');
        print('Registro completo: $item');
        return Notificacao(
          idNotificacao: int.tryParse(item["idNotificacao"].toString()) ?? 0,
          idUsuario_fk: item["idUsuario_fk"]?.toString() ?? '',
          idUsuarioFamiliar_fk: item["idUsuarioFamiliar"]?.toString() ?? '',
          idISFL_fk: item["idISFL_fk"]?.toString() ?? '',
          idProduto_fk: item["idProduto_fk"]?.toString() ?? '',
          Mensagem: item["Mensagem"]?.toString() ?? '',
          Status: item["status"]?.toString() ?? '',
          dataCriacao: item["dataCriacao"] != null
              ? DateTime.tryParse(item["dataCriacao"].toString())
              : null,
          idMedicamento_fk: item["idMedicamento_fk"]?.toString() ?? ''
        );
      }).toList();

      print('Quantidade de notificações: ${notificacoes.length}');
      notifyListeners();

      return notificacoes;
    } else {
      //usuario não encontrado
      print('notificações de idISFL não encontrada');
      return [];
    }
  }

  //atualizando not
  Future<void> atualizaNotificacao(int idNotificacao, String mens) async{
    final url = Uri.parse(
      'http://192.168.0.3:8000/atualiza_notificacao/$idNotificacao',
    );
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idNotificacao": idNotificacao,
        "Mensagem": mens}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('notificação atualizada');
    } else {
      print(response.body);
    }
  }

  Future<void> excluirNotificacao(int idNotificacao) async {
    print('ID da notificação para excluir: $idNotificacao');
    final url = Uri.parse(
      'http://192.168.0.3:8000/excluir_notificacao/$idNotificacao',
    );

    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('notificação excluída');
    } else {
      print(response.body);
    }
  }
}
