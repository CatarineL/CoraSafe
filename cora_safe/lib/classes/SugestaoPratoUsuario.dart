class SugestaoPratoUsuario {
  int idSugestaoPratoUsuario;
  int idPrato;
  int idUsuario_fk;
  String status = '';
  DateTime? datacriacao;

  SugestaoPratoUsuario({
    this.idSugestaoPratoUsuario = 0,
    this.idPrato = 0,
    this.idUsuario_fk = 0,
    this.status = '',
    this.datacriacao,
  });

  int get idsugestaopratousuario => idSugestaoPratoUsuario;
  int get idprato => idPrato;
  int get idusuario_fk => idUsuario_fk;
  String get Status => status;
  DateTime? get Datacricao => datacriacao;
}
