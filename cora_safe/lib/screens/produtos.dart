import 'package:cora_safe/screens/abrirCamera.dart';
import 'package:cora_safe/screens/visualizarDispensaUserComum.dart';
import 'package:flutter/material.dart';
import 'package:cora_safe/screens/itensValidadeProximaUserComum.dart';


class Produtos extends StatelessWidget {
  Produtos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Produtos")),
      appBar: AppBar(
        title: Text("Produtos",
        style: TextStyle(color: Colors.white, fontSize: 18)),
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
              title: const Text('Ativar câmera',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Colors.red[300],//Color(#hexa)//Colors.red[600],//Colors.redAccent[200],
              onTap: () {

              },
            ),
            Divider(),
            SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await abrirCamera();
                },
                label: Text("Ler Lista", style: TextStyle(fontWeight: FontWeight.bold)),
                icon: Icon(Icons.document_scanner_sharp, size: 25,),
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
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await abrirCamera();
                },
                label: Text("Ler Item", style: TextStyle(fontWeight: FontWeight.bold)),
                icon: Icon(Icons.view_in_ar, size: 25,),
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
            SizedBox(height: 15,),
            Divider(),
            SizedBox(
              width: 350,//double.infinity,
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
                label: Text("Visualizar dispensa virtual", style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,//double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) =>  itensValidadeProximaUserComum(),
                     ),
                   );
                },
                icon: const Icon(Icons.calendar_month),
                label: Text("Validades Próximas",style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,//double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => proximapagina(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.shopping_basket_outlined),
                label: Text("Itens Frequentes",style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,//double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => proximapagina(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.show_chart),
                label: Text("Painel de Economia",style: TextStyle(fontWeight: FontWeight.bold)),
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
        )
    );

  }
}