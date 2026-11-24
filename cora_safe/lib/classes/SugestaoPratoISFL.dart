class SugestaoPratoISFL {
  int idSugestaoPratoUsuarioISFL;
  int idPrato;
  int idISFL_fk;
  String status = '';
  DateTime? datacriacao;

  SugestaoPratoISFL({
    this.idSugestaoPratoUsuarioISFL = 0,
    this.idPrato = 0,
    this.idISFL_fk = 0,
    this.status = '',
    this.datacriacao,
  });

  int get idsugestaopratousuarioisfl => idSugestaoPratoUsuarioISFL;
  int get idprato => idPrato;
  int get idisfl_fk => idISFL_fk;
  String get Status => status;
  DateTime? get Datacricao => datacriacao;
}
