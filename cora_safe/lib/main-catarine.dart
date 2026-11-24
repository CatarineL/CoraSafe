import 'package:cora_safe/classes/DoacaoProvider.dart';
import 'package:cora_safe/classes/InstituicaoCFLProvider.dart';
import 'package:cora_safe/classes/InstituicaoSFLProvider.dart';
import 'package:cora_safe/classes/MedicamentoProvider.dart';
import 'package:cora_safe/classes/NotificacaoProvider.dart';
import 'package:cora_safe/classes/NotificacaoVinculoProvider.dart';
import 'package:cora_safe/classes/ProdutoProvider.dart';
import 'package:cora_safe/classes/RelatorioSemanalProvider.dart';
import 'package:cora_safe/classes/RestricaoUsuarioProvider.dart';
import 'package:cora_safe/classes/VinculoUsuarioFamiliarUsuarioIdosoProvider.dart';
import 'classes/Doacao.dart';
import 'classes/Notificacao.dart';
import 'classes/RelatorioSemanalSugestaoPratoProvider.dart';
import 'classes/SugestaoPratoISFLProvider.dart';
import 'classes/SugestaoPratosProvider.dart';
import 'classes/SugestaoPratoUsuarioProvider.dart';
import 'package:cora_safe/classes/UsuarioFamiliarProvider.dart';
import 'package:cora_safe/screens/cadastroSelecaoTipoUsuario.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/relatorioMonitoramento.dart';
import 'package:cora_safe/screens/exemplomenu.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/formularioUserComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/pratodia.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/testeNotificacao.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/loginUserFamiliar.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/menuPrincipalUserResponsavel.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/formularioUserInstituicao.dart';
import 'package:cora_safe/screens/usuarioFamiliarResponsavel/formularioUserResponsavel.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/loginUserComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/menuPrincipalUserComum.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/perfil.dart';
import 'package:cora_safe/screens/usuarioComumIdoso/restricao.dart';
import 'package:cora_safe/screens/tela_logincads.dart';
import 'package:cora_safe/screens/testeDataNascimento.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/loginUserISFL.dart';
import 'package:cora_safe/screens/usuarioIsflAsilo/menuPrincipalInstituicao.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'classes/UsuarioProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'classes/servicoNotificacao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuarioprovider()),
        ChangeNotifierProvider(create: (_) => UsuariofamiliarProvider()),
        ChangeNotifierProvider(create: (_) => InstituicaosflProvider()),
        ChangeNotifierProvider(create: (_) => Produtoprovider()),
        ChangeNotifierProvider(create: (_) => MedicamentoProvider()),
        ChangeNotifierProvider(create: (_) => TipoRestricaoUsuarioProvider()),
        ChangeNotifierProvider(create: (_) => NotificacaoProvider()),
        ChangeNotifierProvider(create: (_) => Instituicaocflprovider()),
        ChangeNotifierProvider(create: (_) => Sugestaopratosprovider()),
        ChangeNotifierProvider(create: (_) => SugestaoPratoUsuarioProvider()),
        ChangeNotifierProvider(create: (_) => SugestaoPratoISFLProvider()),
        ChangeNotifierProvider(
          create: (_) => VinculoUsuarioFamiliarUsuarioIdosoProvider(),
        ),
        ChangeNotifierProvider(create: (_) => NotificacaoVinculoProvider()),
        Provider(create: (_) => Doacao()),
        ChangeNotifierProvider(create: (_) => DoacaoProvider()),
        ChangeNotifierProvider(create: (_) => RelatorioSemanalProvider()),
        ChangeNotifierProvider(
          create: (_) => RelatorioSemanalSugestaoPratoProvider(),
        ),
        Provider(create: (_) => Notificacao()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('pt', 'BR')],

      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home:
          LoginUserISFL(), //CadastroSelecaoTipoUsuario(), //GraficoSimples()//NotificationScreen()//MenuPrincipal(), //FormularioUser(),//FormularioUserResponsavel(),// FormularioUser()//CadastroSelecaoTipoUsuario()//LoginCadastro(), //perfilUser()////MenuPrincipal(),//Restricao()//FormularioUser(),//CadastroSelecaoTipoUsuario(),//LoginScreen()//LoginCadastro(),//chamando a tela de login a principio
    );
  }
}
