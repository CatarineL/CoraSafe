import 'package:flutter/material.dart';


class Sobre extends StatelessWidget {
  Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Sobre")),
      appBar: AppBar(
        title: Text("Sobre",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(

        children: [

        Padding(
        padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
            "Why do we use it?\n"
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. "
            "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. "
            "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. "
            "Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\n"

            "\nWhere does it come from?\n"
            "Contrary to popular belief, Lorem Ipsum is not simply random text. "
            "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
            "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more "
            "obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, "
            "discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "
            "This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, comes from a line in section 1.10.32.",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 15),
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
      ]
      ),
    ),

    );

  }
}