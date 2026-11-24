import 'package:flutter/cupertino.dart';

class Notificacao {
  int idNotificacao;
  String? idUsuario_fk;
  String? idUsuarioFamiliar_fk;
  String? idISFL_fk;
  String? idProduto_fk;
  String Mensagem;
  String Status;
  DateTime? dataCriacao;
  String? idMedicamento_fk;

  Notificacao({
    this.idNotificacao = 0,
    this.idUsuario_fk = '',
    this.idUsuarioFamiliar_fk = '',
    this.idISFL_fk = '',
    this.idProduto_fk = '',
    this.Mensagem = '',
    this.Status = '',
    this.dataCriacao,
    this.idMedicamento_fk =''
  });

  int get idnotificacao => idNotificacao;
  String? get idusuario_fk => idUsuario_fk;
  String? get idusuariofamiliar_fk => idUsuarioFamiliar_fk;
  String? get idisfl_fk => idISFL_fk;
  String? get idproduto_fk => idProduto_fk;
  String get mensagem => Mensagem;
  String get status => Status;
  DateTime? get datacriacao => dataCriacao;
  String? get idmedicamento_fk => idMedicamento_fk;
}
