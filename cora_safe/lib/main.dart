import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/classes/TIpoRestricaoProvider.dart';
import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/cadastroSelecaoTipoUsuario.dart';
import 'package:cora_safe/screens/exemplomenu.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/formularioUserComum.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/loginUserFamiliar.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/formularioUserInstituicao.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/formularioUserResponsavel.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/loginUserComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/menuPrincipalUserComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/perfil.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/restricao.dart';
import 'package:cora_safe/screens/tela_logincads.dart';
import 'package:cora_safe/screens/testeDataNascimento.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'classes/UsuarioProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuarioprovider()),
        ChangeNotifierProvider(create: (_) => UsuariofamiliarProvider()),
        ChangeNotifierProvider(create: (_) => InstituicaosflProvider()),
        ChangeNotifierProvider(create: (_) => Produtoprovider()),
        ChangeNotifierProvider(create: (_) => Tiporestricaoprovider()),
      ],
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //const Color coralBackground = Color(0xFFFAECE7);
    return MaterialApp(
      title: 'Projeto CoraSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: LoginUserFamiliar()//FormularioUser(),//FormularioUserResponsavel(),// FormularioUser()//CadastroSelecaoTipoUsuario()//LoginCadastro(), //perfilUser()////MenuPrincipal(),//Restricao()//FormularioUser(),//CadastroSelecaoTipoUsuario(),//LoginScreen()//LoginCadastro(),//chamando a tela de login a principio

    );
  }
}