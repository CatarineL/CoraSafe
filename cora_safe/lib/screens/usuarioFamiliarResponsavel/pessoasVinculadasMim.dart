import 'package:cora_safe/classes/UsuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class pessoasVinculadasMim extends StatelessWidget {
  pessoasVinculadasMim({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<Usuarioprovider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resumo de informações",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Dados de pessoa vínculada à mim:',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.black, fontSize: 15,)
            ),
            SizedBox(height: 50,),
            Text(
              'Nome do familiar: ${controller.nome}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'E-mail do familiar: ${controller.emailFamiliar}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),
            Text(
              'Telefone: ${controller.telefone.text}',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Divider(),
            SizedBox(height: 40,),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Center(
                child: Text(
                  '©CoraSafe',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
