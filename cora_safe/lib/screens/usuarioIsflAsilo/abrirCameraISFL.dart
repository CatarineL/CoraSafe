import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/visualizarDispensaISFL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'carregandoGeracaoProdutos.dart';

final ImagePicker picker = ImagePicker();

Future<void> abrirCameraISFL(BuildContext context) async {
  final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

  if (imagem != null) {
    final controller = Provider.of<Produtoprovider>(context, listen: false);
    final isflController = Provider.of<InstituicaosflProvider>(context, listen: false);
    final idISFL_fk = isflController.idISFL.text;

    print('Enviando produto para usuário: "$idISFL_fk"');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => carregandoGeracaoProdutos(),
      ),
    );

    final retornoDispensa = await controller.adicionarProdutoISFL(imagem,idISFL_fk);

    if(!context.mounted) return;
    Navigator.pop(context);

    if(retornoDispensa){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => visualizacaoDispensaISFL()));
    }else{
      print("Erro ao criar dispensa");
    }
  }
}