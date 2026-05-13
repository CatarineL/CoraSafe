//Classe
class InstituicaoSFL {
  //atributos
  String nomeISFL;
  String nomeResponsavel;
  int CNPJ;
  String emailISFL;
  int telefoneISFL;
  String senhaResponsavel;
  bool Restricao;
  String tipoUsuario;

  //metodo construtor
  InstituicaoSFL(
    this.nomeISFL,
    this.nomeResponsavel,
    this.CNPJ,
    this.emailISFL,
    this.telefoneISFL,
    this.senhaResponsavel,
    this.Restricao,
    this.tipoUsuario
  );

  //metodos
  void cadastroInstituicao(){}
  void loginInstituicao(){}
  void editarInstituicao(){}
  void seguranca(){}
  void preferencia(){}
  void ajuda(){}
  void sair(){}
}

