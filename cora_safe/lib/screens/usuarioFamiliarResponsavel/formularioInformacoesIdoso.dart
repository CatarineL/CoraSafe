import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/menuPrincipalUserResponsavel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';


class FormularioInformacoesIdoso extends StatelessWidget {
  FormularioInformacoesIdoso({super.key});

  TextEditingController _nomeIdoso = TextEditingController();
  TextEditingController _cpfIdoso = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final controllerUserComum = context.read<Usuarioprovider>();
    final controllerUserFamiliar = context.read<UsuariofamiliarProvider>();
    var coletaidUserComum;

    //cpf do idoso
    var mascaraCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _nomeIdoso,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome do(a) Idoso(a):',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                inputFormatters: [mascaraCPF],
                controller: _cpfIdoso,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'CPF:',
                ),
              ),
            ),


            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  print("================================");
                  print("DADOS DA TELA");
                  print("Nome digitado: '${_nomeIdoso.text}'");
                  print("CPF digitado: '${_cpfIdoso.text}'");

                  print("DADOS DO PROVIDER");
                  print("Nome provider: '${controllerUserComum.nome}'");
                  print("CPF provider: '${controllerUserComum.CPF}'");
                  print("ID provider: '${controllerUserComum.idusuario}'");

                  print("COMPARAÇÕES");
                  print("Nome: ${controllerUserComum.nome == _nomeIdoso.text}");
                  print("CPF: ${controllerUserComum.CPF == _cpfIdoso.text}");
                  print("================================");

                  //fazer um metodo ou algo que pegue
                  //O que você precisa fazer
                  //Você precisa buscar a Maria no banco antes de fazer essa comparação e preencher o Usuarioprovider.

                  if ((controllerUserComum.cpf.text == _cpfIdoso) && (controllerUserComum.nome == _nomeIdoso.text)){//se id ainda não existe
                    //atribuindo o id do usuario idoso como chave estrangeira para respo
                    controllerUserFamiliar.idUsuarioComumFK = controllerUserComum.idusuario;
                    coletaidUserComum = controllerUserFamiliar.idUsuarioComumFK;
                    //metodo de solicitar acesso ao idoso e metodo de atualizar dados - classes notificações e  usuario comum
                    controllerUserFamiliar.editarIDUsuarioComum(coletaidUserComum, controllerUserFamiliar.idusuariofamiliar);
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPrincipalResponsavel(),
                      ),
                    );
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Continuar"),
              ),
            ),

            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
