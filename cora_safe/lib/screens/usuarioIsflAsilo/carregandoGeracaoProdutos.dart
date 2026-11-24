import 'package:flutter/material.dart';

class carregandoGeracaoProdutos extends StatefulWidget {
  const carregandoGeracaoProdutos({super.key});

  @override
  State<carregandoGeracaoProdutos> createState() =>
      _carregandoGeracaoProdutos();
}

class _carregandoGeracaoProdutos extends State<carregandoGeracaoProdutos>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: .center,
          children: <Widget>[

            Text('Sua dispensa está sendo criada', style: TextStyle(fontSize: 18)),
            Padding(
              padding: const .symmetric(horizontal: 18),
              child: CircularProgressIndicator(year2023: carregando,color: Colors.redAccent[400],),
            ),
          ],
        ),
      ),
    );
  }
}
