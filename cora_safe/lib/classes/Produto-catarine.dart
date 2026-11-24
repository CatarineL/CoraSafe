//criação da classe produto
import 'dart:core';


class Produto{

  String idProduto;
  String? idUsuario_fk;
  String? idISFL_fk;
  String nomeProduto;
  String? validadeProduto;
  bool? statusProduto;
  String? dataConsumo;


  Produto({
    this.idProduto = '',
    this.idUsuario_fk = '',
    this.idISFL_fk = '',
    this.nomeProduto = '',
    this.validadeProduto = '',
    this.statusProduto = false,
    this.dataConsumo = ''
  });

  //pegando os valores quando precisar
  String get idproduto => idProduto;
  String get idusuario_fk => idUsuario_fk  ?? '';
  String get idisfl_fk => idISFL_fk  ?? '';
  String get nomeproduto => nomeProduto;
  String get validadeproduto => validadeProduto ?? '';
  bool get statusproduto => statusProduto ?? false;
  String get dataconsumo => dataConsumo ?? '';

}