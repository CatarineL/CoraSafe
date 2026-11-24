import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Sobre")),
      appBar: AppBar(
        title: Text(
          "Perguntas frequentes",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "O que é o CoraSafe?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "O  CoraSafe nasceu em 2025 com o objetivo de trazer acessibilidade a diferentes pessoas, sendo em especial pessoas idosas."
                    "No aplicativo o idoso pode integrar a nota fiscal de itens de mercado e medicamentos e o gerenciamento desses itens tornam importantes "
                    "para que a pessoa idosa consiga analisar seu itens de compra na palma da mão.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Mas e se eu tiver dificuldade?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Não tem problema. No app uma pessoa da sua confiança pode estar vinculado a você, para isto basta que seu familiar ou amigo"
                    "entre no app pelo celular dele e faça o cadastro com a opção de 'Responsável' e conforme ele fornece informações sobre você, e em"
                    "caso positivo o vinculo entre vocês será criado. Assim seu familiar poderá acessar informações sobre seus produtos e medicamentos.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "O CoraServe para Instituições",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Assim como duas pessoas podem estar vinculadas, instituições de longa permanência podem gerenciar itens de mercado da instituição e medicamentos de "
                    "diferentes utentes por um responsável da instituição.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Por quê as pessoas deveriam usar o App?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "O CoraSafe possui como um dos objetivos trazer a acessibilidade para pessoas idosas e contribuir para que haja uma redução de "
                    "resíduos sólidos nas dispensas reais do usuário.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
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
