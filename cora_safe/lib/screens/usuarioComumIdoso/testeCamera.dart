import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/carregandoGeracaoProdutos.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/visualizarDispensaUserComum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
final ImagePicker picker = ImagePicker();


Future<void> abrirCamera(BuildContext context) async {
  final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

  if (imagem != null) {
    final controller = Provider.of<Produtoprovider>(context, listen: false);
    final usuarioController = Provider.of<Usuarioprovider>(context, listen: false);
    final idUsuario_fk = usuarioController.idUsuario.text;

    print('Enviando produto para usuário: "$idUsuario_fk"');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => carregandoGeracaoProdutos(),
      ),
    );

    final retornoDispensa = await controller.adicionarProduto(imagem,idUsuario_fk);

    if(!context.mounted) return;
    Navigator.pop(context);

    if(retornoDispensa){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => visualizacaoDispensaUserComum()));
    }else{
      print("Erro ao criar dispensa");
    }
  }
}