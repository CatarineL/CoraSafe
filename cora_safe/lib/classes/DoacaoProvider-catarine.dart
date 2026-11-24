import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Doacao.dart';

class DoacaoProvider extends ChangeNotifier {
  List<Doacao> doacoes = [];

  //função de criação de usuário
  Future<void> criarSolicitacaoDoacao(
    int idisfl,
    idicfl,
    String mens,
    status,
    data,
    emailisfl,
    emailicfl,
  ) async {
    final url = Uri.parse('http://192.168.0.2:8000/criar_solicitacaoDoacao');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idISFL_fk": idisfl,
        "idICFL_fk": idicfl,
        "mensagemSolicitacao": mens,
        "statusSolicitacao": status,
        "dataSolicitacao": data,
        "emailISFL_fk": emailisfl,
        "emailICFL_fk": emailicfl,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('solicitacao criada');
    } else {
      print(response.body);
    }
  }

  //envio de email de solicitação com a mensagem
  Future<void> envioSolicitacaoDoacaoEmail(
    String nomeISFL,
    String nomeRes,
    String telefone,
    String emailisfl,
    String emailicfl,
    String msn,
  ) async {
    final url = Uri.http('192.168.0.2:8000', '/envioEmail_solicitacaoDoacao', {
      'nomeISFL': nomeISFL,
      'nomeRes': nomeRes,
      'telefone': telefone,
      'mensagem': msn,
      'emailInstituicaoSFL': emailisfl,
      'emailInstituicaoCFL': emailicfl,
    });
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mensagemSolicitacao": msn,
        "emailISFL_fk": emailisfl,
        "emailICFL_fk": emailicfl,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('solicitacao enviada');
    } else {
      print('erro ao enviar solicitação enviada');
      print(response.body);
    }
  }

  //lendo solicitações feitas
  Future<List<Doacao>> lendoSolicitacoes(int idisfl_fk) async {
    final url = Uri.parse(
        'http://192.168.0.2:8000/lendo_solicitacaoDoacao/$idisfl_fk');
    final response = await http.post(
      url
      /*, headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idISFL_fk": idisfl_fk}),*/
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> saidaDados = jsonDecode(utf8.decode(response.bodyBytes));
      doacoes = saidaDados.map<Doacao>((item) {
        return Doacao(
          idDoacao: int.tryParse(item["idDoacao"].toString()) ?? 0,
          idISFL_fk: item["idISFL_fk"],
          idICFL_fk: item["idICFL_fk"],
          mensagemSolicitacao: item["mensagemSolicitacao"]?.toString() ?? '',
          statusSolicitacao: item["statusSolicitacao"]?.toString() ?? '',
        );
      }).toList();

      print('Quantidade de notificações: ${doacoes.length}');
      notifyListeners();

      return doacoes;
    } else {
      return [];
    }
  }
}
