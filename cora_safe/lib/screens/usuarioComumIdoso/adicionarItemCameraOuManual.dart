import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/Produto.dart';

class adicionarItemCameraOuManual extends StatelessWidget {
  adicionarItemCameraOuManual({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Produtoprovider>();
    final nomeProduto = TextEditingController();
    final validadeProduto = TextEditingController();

    //função de abrir a camera
    final ImagePicker picker = ImagePicker();
    Future<void> abrirCamera() async {
      final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

      if (imagem != null) {

        controller.enviandoImagem(imagem);

        //print(imagem.path);
      }
    }



    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adicionar Item",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),


      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Cadastro pela Câmera",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),

            SizedBox(
              //LER ITEM INDIVIDUAL POR CAMERA
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      icon: Image.asset(
                        'assets/images/exemploPF.jpg',
                        height: 200,
                      ),
                      title: Text('Dicas para uma boa captura'),
                      content:
                      Text(
                        'Para uma boa qualidade de imagem, observe o exemplo acima e se atente as seguintes sugestões:\n 1) Tire a imagem em um lugar iluminado;\n 2) Tente enquadrar a imagem na vertical, no sentido de leitura\n\nObs: um produto fracionado é aquele que é embalado pelo próprio supermercado, geralmente em bandejas com filme plástico e uma etiqueta contendo informações como nome e data de validade.', textAlign: TextAlign.justify),
                      actions: [
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
                            await abrirCamera();
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
                  "Adicionar produto fracionado",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

            SizedBox(height: 40),
            Text(
              "Ou",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),

            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: Text(
                "Cadastro manual",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              //ITEM INDIVIDUAL MANUAL
              width: double.infinity,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  title: TextField(
                    controller: nomeProduto,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nome do produto',
                    ),
                  ),

                  subtitle: TextField(
                    controller: validadeProduto,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Validade (dia/mês/ano)',
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle),
                        iconSize: 30,
                        color: Colors.redAccent[400],
                        onPressed: () {
                          //concluir a adição
                          Produto produto = Produto(
                            nomeProduto: nomeProduto.text,
                            validadeProduto: validadeProduto.text,
                          );
                          ////controller.adicionarProduto(produto);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
