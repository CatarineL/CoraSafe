import 'package:cora_safe/classes/MedicamentoProvider.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/carregandoGeracaoMedicamentos.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/visualizarMedicamentos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
final ImagePicker picker = ImagePicker();


Future<void> abrirCameraMedicamento(BuildContext context) async {
  final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

  if (imagem != null) {
    final controller = Provider.of<MedicamentoProvider>(context, listen: false);
    final usuarioController = Provider.of<Usuarioprovider>(context, listen: false);
    final idUsuario_fk = usuarioController.idUsuario.text;

    print('Enviando emdicamento para usuário: "$idUsuario_fk"');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => carregandoGeracaoMedicamentos(),
      ),
    );

    final retornoDispensaMedicamento = await controller.adicionarMedicamento(imagem,idUsuario_fk);

    if(!context.mounted) return;
    Navigator.pop(context);

    if(retornoDispensaMedicamento){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => visualizarMedicamentos()));
    }else{
      print("Erro ao criar dispensa");
    }

  }
}