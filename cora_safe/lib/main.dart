import 'package:cora_safe/screens/cadastroSelecaoTipoUsuario.dart';
import 'package:cora_safe/screens/exemplomenu.dart';
import 'package:cora_safe/screens/formularioUser.dart';
import 'package:cora_safe/screens/menuPrincipal.dart';
import 'package:cora_safe/screens/restricao.dart';
import 'package:cora_safe/screens/tela_logincads.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto CoraSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: LoginCadastro()//CadastroSelecaoTipoUsuario()//MenuPrincipal(),//Restricao()//FormularioUser(),//CadastroSelecaoTipoUsuario(),//LoginScreen()//LoginCadastro(),//chamando a tela de login a principio
    );
  }
}