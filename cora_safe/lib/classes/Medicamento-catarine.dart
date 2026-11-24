//import 'dart:nomebilbioteca';

//classe Medicamento
class Medicamento {
  //atributos da classe
  String idMedicamento;
  String? idUsuario_fk;
  String? idISFL_fk;
  String nomeMedicamento;
  String? validadeMedicamento;
  String? para;
  int? horarioMedicamentoIntervalo;

  Medicamento({
    this.idMedicamento = '',
    this.idUsuario_fk = '',
    this.idISFL_fk = '',
    this.nomeMedicamento = '',
    this.validadeMedicamento = '',
    this.para = '',
    this.horarioMedicamentoIntervalo
  });

  //pegando os valores quando precisar
  String get idmedicamento => idMedicamento;
  String? get idusuario_fk => idUsuario_fk;
  String? get idisfl_fk => idISFL_fk;
  String get nomemedicamento => nomeMedicamento;
  String? get validademedicamento => validadeMedicamento;
  String? get Para => para;
  int? get horariomedicamentointervalo => horarioMedicamentoIntervalo;





}