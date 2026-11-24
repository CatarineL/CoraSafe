import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RelatorioSemanalSugestaoPratoProvider extends ChangeNotifier {
  int idSemana;
  int? idUsuario_fk;
  int? idUsuarioFamiliar_fk;
  int? idISFL_fk;
  String? inicioSemana;
  String? finalSemana;
  int? segunda;
  int? terca;
  int? quarta;
  int? quinta;
  int? sexta;
  int? sabado;
  int? domingo;

  RelatorioSemanalSugestaoPratoProvider({
    this.idSemana = 0,
    this.idUsuario_fk = 0,
    this.idUsuarioFamiliar_fk = 0,
    this.idISFL_fk = 0,
    this.inicioSemana = '',
    this.finalSemana = '',
    this.segunda = 0,
    this.terca = 0,
    this.quarta = 0,
    this.quinta = 0,
    this.sexta = 0,
    this.sabado = 0,
    this.domingo = 0,
  });

  //pegando os valores quando precisar
  int get idsemana => idSemana;
  int? get idusuario_fk => idUsuario_fk;
  int? get idusuariofamiliar_fk => idUsuarioFamiliar_fk;
  int? get idIsfl_fk => idISFL_fk;
  String? get iniciosemana => inicioSemana;
  String? get finalsemana => finalSemana;
  int? get Segunda => segunda;
  int? get Terca => terca;
  int? get Quarta => quarta;
  int? get Quinta => quinta;
  int? get Sexta => sexta;
  int? get Sabado => sabado;
  int? get Domingo => domingo;

  //função de criação de usuário
  Future<void> criar_relatorioSemanal(
    int? idUser,
    int? idFamiliar,
    int? idisfl,
    String dataIni,
    String dataFinal,
    int? seg,
    int? ter,
    int? qua,
    int? qui,
    int? sex,
    int? sab,
    int? dom,
  ) async {
    final url = Uri.parse('http://192.168.0.3:8000/criar_relatorioSemanalSugestaoPrato');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario_fk": idUser,
        "idUsuarioFamiliar_fk": idFamiliar,
        "idISFL_fk": idisfl,
        "inicioSemana": dataIni,
        "finalSemana": dataFinal,
        "segunda": seg,
        "terca": ter,
        "quarta": qua,
        "quinta": qui,
        "sexta": sex,
        "sabado": sab,
        "domingo": dom,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Relatório Semanal Criado');
    } else {
      print('erro ao criar relatorio');
      print(response.body);
    }
  }
  Future<Map<String, dynamic>> verificandoRelatorioSemanal(
      String idUser,
      String dataIni,
      String dataFin,
      ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/verifica_relatorioSemanalSugestaoPratoUserComum',
    );
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario_fk": idUser,
        "inicioSemana": dataIni,
        "finalSemana": dataFin,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dados = jsonDecode(response.body);
      print("Resposta da verificação: ${response.body}");
      print("Dados decodificados: $dados");
      return{
        "encontrado": dados["encontrado"] == true,
        "idSemana": dados["idSemana"],
      };

    } else {
      return{
        "encontrado": false,
        "idSemana": null,
      };
    }
  }

  //verificacao de semana - relatorio, retorna o id da semana
  Future<Map<String, dynamic>> verificandoRelatorioSemanalISFL(
    String idISFL,
    String dataIni,
    String dataFin,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/verifica_relatorioSemanalSugestaoPratoISFL',
    );
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idISFL_fk": idISFL,
        "inicioSemana": dataIni,
        "finalSemana": dataFin,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dados = jsonDecode(response.body);
      print("Resposta da verificação: ${response.body}");
      print("Dados decodificados: $dados");
     return{
       "encontrado": dados["encontrado"] == true,
       "idSemana": dados["idSemana"],
     };

    } else {
      return{
        "encontrado": false,
        "idSemana": null,
      };
    }
  }

  //atualizando campos de consumo
  Future<void> editandoConsumoSemanaUserComum(
    int idSem,
    String idUser,
    String dataIni,
    dataFin,
    int? seg,
    ter,
    qua,
    qui,
    sex,
    sab,
    dom,
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/editando_relatorioSemanalSugestaoPrato/$idSem',
    );
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUsuario_fk": idUser,
        "inicioSemana": dataIni,
        "finalSemana": dataFin,
        "segunda": seg,
        "terca": ter,
        "quarta": qua,
        "quinta": qui,
        "sexta": sex,
        "sabado": sab,
        "domingo": dom,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('relatorio atualizado');
    } else {
      print(response.body);
    }
  }

  Future<void> editandoConsumoSemanaISFL(
      int idSem,
      String idISFL,
      String dataIni,
      dataFin,
      int? seg,
      ter,
      qua,
      qui,
      sex,
      sab,
      dom,
      ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/editando_relatorioSemanalSugestaoPratoISFL/$idSem',
    );
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idISFL_fk": idISFL,
        "inicioSemana": dataIni,
        "finalSemana": dataFin,
        "segunda": seg,
        "terca": ter,
        "quarta": qua,
        "quinta": qui,
        "sexta": sex,
        "sabado": sab,
        "domingo": dom,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('relatorio atualizado');
    } else {
      print(response.body);
    }
  }
  //lendo campos de consumo
  Future<void> lendoSugestaoPratoDiario(
    int idSem
  ) async {
    final url = Uri.parse(
      'http://192.168.0.3:8000/lendo_SugestaoPratoDiaria/$idSem',
    );
    Map<String, dynamic> saidaDados = {};
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idSemana": idSem
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('JSON recebido: $saidaDados');
      print('Resposta da API: ${response.body}');

      saidaDados = jsonDecode(response.body);

      segunda = saidaDados['segunda'];
      terca = saidaDados['terca'];
      quarta = saidaDados['quarta'];
      quinta = saidaDados['quinta'];
      sexta = saidaDados['sexta'];
      sabado = saidaDados['sabado'];
      domingo = saidaDados['domingo'];
      notifyListeners();
    } else {
      print("Erro ao ler dados do relatório semanal");
    }
  }
}
