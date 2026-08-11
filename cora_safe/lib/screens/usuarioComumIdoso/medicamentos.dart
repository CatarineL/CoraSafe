import 'package:flutter/material.dart';
import 'abrirCamera.dart';


class Medicamentos extends StatelessWidget {
  Medicamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Medicamentos")),
      appBar: AppBar(
        title: Text("Medicamentos",
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
                height: 70,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      //criando dialogo de alerta para que o usuário tire a foto com algumas restrições
                      context: context,
                      builder: (BuildContext dialogContext) => AlertDialog(
                        //builder: (BuildContext context) => AlertDialog(
                        icon: Image.asset(
                          'assets/images/exemploNFM.jpeg',
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
                              await abrirCamera(context); // agora sim, o context de verdade da tela
                            },
                            style: TextButton.styleFrom(backgroundColor: Colors.redAccent[400]),
                            child: Text("Entendi", style: TextStyle(color: Colors.white)),

                          ),
                        ],
                      ),
                    );


                  },
                  label: Text("Ler Medicamento", style: TextStyle(fontWeight: FontWeight.bold)),
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
                //LER ITEM INDIVIDUAL POR CAMERA
                width: double.infinity,
                height: 70,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: Image.asset(
                          'assets/images/exemploMD.jpg',
                          height: 200,
                        ),
                        title: Text('Dicas para uma boa captura'),
                        content:
                        Text(
                            'Para uma boa qualidade de imagem, observe o exemplo acima e se atente as seguintes sugestões:\n 1) Tire a imagem em um lugar iluminado;\n 2) Tente enquadrar a imagem no sentido de leitura\n', textAlign: TextAlign.justify,),        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, "Cancelar"),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.redAccent[400],
                            ),
                            child: Text("Cancelar", style: TextStyle(color: Colors.white),),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context, "Entendi");
                              await abrirCamera(context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.redAccent[400],
                            ),
                            child: Text("Entendi", style: TextStyle(color: Colors.white, )),
                          ),
                        ],

                      ),
                    );
                  },
                  label: Text(
                    "Adicionar medicamento fracionado",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(Icons.photo_camera, size: 25), //view_in_ar
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
              SizedBox(height: 20,),
              Divider(),
              SizedBox(
                width: 350,//double.infinity,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.medical_services_outlined),
                  label: Text("Lista de Medicamentos", style: TextStyle(fontWeight: FontWeight.bold)),
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
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => proximapagina(),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.medication),
                  label: Text("Horário - Medicação",style: TextStyle(fontWeight: FontWeight.bold)),
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