import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_farmacia.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/doacao_prefeitura.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/pedidosDoacoes.dart';
import 'package:flutter/material.dart';

import 'doacao_hortaComunitaria.dart';
import 'doacao_mercado.dart';

class Doacoes extends StatelessWidget {
  Doacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Solicitação de Doações",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10,),
            Text("Veja os estabelecimentos parceiros", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,)),

          ],
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      //background local
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 15,),

            Text("Sugestões para você                                            ",
                textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),

            SizedBox(height: 20,),

            SizedBox(
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoacaoFarmacia(),
                    ),
                  );
                },
                icon: const Icon(Icons.medication_outlined),
                label: Text(
                  "Farmácia - Farma Lar",
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFF000000),
                      width: 0.2,
                    ),
                  ),
                ),
              ),

            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoacaoPrefeitura(),
                    ),
                  );

                },
                icon: const Icon(Icons.account_balance),
                label: Text(
                  "Prefeitura - Município",
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFF000000),
                      width: 0.2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoacaoMercado(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  "Mercado - Savegnago",
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFF000000),
                      width: 0.2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350, //double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoacaoHortacomunitaria(),
                    ),
                  );

                },
                icon: const Icon(Icons.eco),
                label: Text(
                  "Horta - Comunitária do município",
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFF000000),
                      width: 0.2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Divider(
              indent: 100,
              endIndent: 100,
              thickness: 1,
            ),

            SizedBox(
              width: 250,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (context) => Pedidosdoacoes(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Acessar pedidos feitos"),
              ),
            ),
            SizedBox(height: 15,),


            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '©CoraSafe - Todos os Direitos Reservados',
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
