import 'package:flutter/material.dart';

class reportarProblema extends StatelessWidget {
  reportarProblema({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Reportar Problema")),
      appBar: AppBar(
        title: Text(
          "Reportar problema",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    "Atendimento - Como podemos te ajudar?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Valorizamos seu tempo e por isso estamos  dispostos a te ajudar.\n\nEmail suporte: corasafe.suporte@comercial.com",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),

                  SizedBox(height: 25),

                  Divider(),

                  Text(
                    "Através do formulário nosso time entrará em contato em até 3 dias úteis",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 16,
                    ),
                    child: TextFormField(
                      //controller: controller.emailFamiliar,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Insira aqui a descrição de seu problema',
                      ),
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          //função de envio do problema
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                        child: const Text("Enviar"),
                      ),

                    )


                  ),
                ],
              ),
            ),

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
          ],
        ),
      ),
    );
  }
}
