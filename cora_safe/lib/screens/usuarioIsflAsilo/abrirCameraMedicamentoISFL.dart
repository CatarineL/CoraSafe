import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/visualizarMedicamentosISFL.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/carregandoGeracaoMedicamentos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../classes/MedicamentoProvider.dart';
final ImagePicker picker = ImagePicker();

Future<void> abrirCameraMedicamentoISFL(BuildContext context) async {
  final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

  if (imagem != null) {
    final controller = Provider.of<MedicamentoProvider>(context, listen: false);
    final ISFLController = Provider.of<InstituicaosflProvider>(context, listen: false);
    final idISFL_fk = ISFLController.idISFL.text;

    print('Enviando emdicamento para usuário: "$idISFL_fk"');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => carregandoGeracaoMedicamentos(),
      ),
    );

    final retornoDispensa = await controller.adicionarMedicamentoISFL(imagem,idISFL_fk);

    if(!context.mounted) return;
    Navigator.pop(context);

    if(retornoDispensa){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => visualizarMedicamentosISFL()));
    }else{
      print("Erro ao criar dispensa");
    }

  }
}