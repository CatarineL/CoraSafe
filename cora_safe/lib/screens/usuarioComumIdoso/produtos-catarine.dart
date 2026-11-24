import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/adicionarItemCameraOuManual.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/itensFrequentes.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/visualizarDispensaUserComum.dart';
import 'package:flutter/material.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/itensValidadeProximaUserComum.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'relatorioMonitoramento.dart';
import 'abrirCamera.dart';

class Produtos extends StatelessWidget {
  Produtos({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(title: Text("Produtos")),
      appBar: AppBar(
        title: Text(
          "Produtos",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            //pagina de tema de tela
            ListTile(
              //leading: const Icon(Icons.account_circle),
              title: const Text(
                'Ativar câmera',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Colors
                  .red[300], //Color(#hexa)//Colors.red[600],//Colors.redAccent[200],
              onTap: () {},
            ),
            Divider(),
            SizedBox(height: 20),

            SizedBox(
              //LER LISTA DE ITENS DA NOTA FISCAL
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await showDialog(
                    //criando dialogo de alerta para que o usuário tire a foto com algumas restrições
                    context: context,
                    builder: (BuildContext dialogContext) => AlertDialog(
                    //builder: (BuildContext context) => AlertDialog(
                      icon: Image.asset(
                        'assets/images/exemploNF.JPG',
                        height: 200,
                      ),
                      title: Text('Dicas para uma boa captura'),
                      content: Text(
                        'Para uma boa qualidade de imagem, observe o exemplo acima e se atente as seguintes sugestões:\n 1) Tire a imagem em um lugar iluminado;\n 2) Tente enquadrar a imagem na vertical, no sentido da nota fiscal',
                        textAlign: TextAlign.justify,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, "Cancelar"),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent[400],
                          ),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(dialogContext, "Entendi");
                            await abrirCamera(context);
                          },
                          style: TextButton.styleFrom(backgroundColor: Colors.redAccent[400]),
                          child: Text("Entendi", style: TextStyle(color: Colors.white)),

                        ),
                      ],
                    ),
                  );
                },

                label: Text(
                  "Ler Lista",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.document_scanner_sharp, size: 25),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[400],
                  foregroundColor: Colors.white,
                  alignment: Alignment.center,
                  iconAlignment: IconAlignment.end,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),

            SizedBox(
              //LER ITEM INDIVIDUAL POR CAMERA OU ADICIONAR MANUALMENTE
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => adicionarItemCameraOuManual(),
                    ),
                  );
                },
                label: Text(
                  "Adicionar item",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.add, size: 25), //view_in_ar
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[400],
                  foregroundColor: Colors.white,
                  alignment: Alignment.center,
                  iconAlignment: IconAlignment.end,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            Divider(),

            SizedBox(
              //VISUALIZAR DISPENSA VIRTUAL
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => visualizacaoDispensaUserComum(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(
                  "Visualizar dispensa virtual",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              //VISUALIZAR ITENS COM VALIDADE PROXIMA
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => itensValidadeProximaUserComum(),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  "Validades Próximas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              //VISUALIZAR ITENS FREQUENTES
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => itensFrequentes(),
                            ),
                  );
                },
                icon: const Icon(Icons.shopping_basket_outlined),
                label: Text(
                  "Itens Frequentes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              //VISUALIZAR PAINEL DDE ECONOMIA
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => relatorioMonitoramento()),
                  );
                },
                icon: const Icon(Icons.show_chart),
                label: Text(
                  "Painel de Economia",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '©CoraSafe',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
