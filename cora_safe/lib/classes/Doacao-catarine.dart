import 'package:flutter/cupertino.dart';

class Doacao {
  int idDoacao;
  int idISFL_fk;
  int idICFL_fk;
  String mensagemSolicitacao;
  String statusSolicitacao;
  String dataSolicitacao;
  String? emailISFL_fk;
  String? emailICFL_fk;

  Doacao({
    this.idDoacao = 0,
    this.idISFL_fk = 0,
    this.idICFL_fk = 0,
    this.mensagemSolicitacao = '',
    this.statusSolicitacao = '',
    this.dataSolicitacao = '',
    this.emailISFL_fk = '',
    this.emailICFL_fk = '',
  });

  //pegando os valores quando precisar
  int get iddoacao => idDoacao;
  int get idIsfl_fk => idISFL_fk;
  int get idIcfl_fk => idICFL_fk;
  String get mensagemsolicitacao => mensagemSolicitacao;
  String get statussolicitacao => statusSolicitacao;
  String get datasolicitacao => dataSolicitacao;
  String? get emailisfl_fk => emailISFL_fk;
  String? get emailicfl_fk => emailICFL_fk;
}
