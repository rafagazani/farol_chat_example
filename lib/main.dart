import 'dart:convert';

import 'package:farol_chat/autenticacao_modulo/controller/sessao_controller.dart';
import 'package:farol_chat/autenticacao_modulo/page/login_page.dart';
import 'package:farol_chat/chat_modulo/page/chats_page.dart';
import 'package:farol_chat/servidor_appwrite/servidor_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SessaoController.instance.carregarSessao();
  ServidorAppwrite.instance.init();
  var themeStr = await rootBundle.loadString('assets/farol_theme.json');
  var themeJson = json.decode(themeStr);

  var theme = ThemeDecoder.decodeThemeData(themeJson) ?? ThemeData();

  runApp(MyApp(
    tema: theme,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData tema;
   MyApp({Key? key, required this.tema}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farol chat',
      theme: tema,
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder<bool>(
        valueListenable: SessaoController.instance.auteticado,
        builder: (context, autenticado, ee){
          print(autenticado);
          return autenticado?
              ChatsPage():
              LoginPage();
        },
      ),


    );
  }
}
