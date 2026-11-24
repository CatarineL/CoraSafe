import 'package:flutter/material.dart';


class politicaPrivacidade extends StatelessWidget {
  politicaPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Política de Privacidade")),
      appBar: AppBar(
        title: Text("Política de Privacidade",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [

                  Text(
                    "A sua privacidade é importante para nós. Esta Política de Privacidade descreve como coletamos, usamos e protegemos os dados fornecidos por você por meio do nosso formulário de contato.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Uso das Informações",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "As informações fornecidas são utilizadas apenas para:\n"
                    "- Entrar em contato com você em resposta à sua solicitação;\n"
                    "- Prestar esclarecimentos ou enviar informações relacionadas ao serviço jurídico solicitado.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Compartilhamento de Dados",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Não compartilhamos, vendemos ou repassamos suas informações para terceiros.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Segurança",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tomamos medidas razoáveis para proteger os seus dados contra acesso não autorizado. No entanto, é importante lembrar que nenhuma transmissão de dados pela internet é 100% segura.\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Consentimento",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ao utilizar o formulário de contato do nosso site, você concorda com esta política de privacidade..\n",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Alterações nesta Política",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Podemos atualizar esta política periodicamente. Quaisquer alterações serão publicadas nesta página.\n",
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