class Sugestaopratos {
  int idPrato;
  String nomePrato;
  String Descricao;
  String Restricao;
  String linkPrato;

  Sugestaopratos({
    this.idPrato = 0,
    this.nomePrato = '',
    this.Descricao = '',
    this.Restricao = '',
    this.linkPrato = ''

  });
  //pegando os valores quando precisar
  int get idprato => idPrato;
  String get nomeprato => nomePrato;
  String get descricao => Descricao;
  String get restricao => Restricao;
  String get linkprato => linkPrato;
}