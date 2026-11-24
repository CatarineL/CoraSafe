import 'package:flutter/material.dart';

class carregandoGeracaoMedicamentos extends StatefulWidget {
  const carregandoGeracaoMedicamentos({super.key});

  @override
  State<carregandoGeracaoMedicamentos> createState() =>
      _carregandoGeracaoMedicamentos();
}

class _carregandoGeracaoMedicamentos extends State<carregandoGeracaoMedicamentos>
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

            Text('Sua lista de medicamentos está sendo criada', style: TextStyle(fontSize: 15)),
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
