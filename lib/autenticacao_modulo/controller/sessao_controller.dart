import 'package:farol_chat/servidor_appwrite/servidor_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessaoController {
  final  storage = FlutterSecureStorage();
  static SessaoController? _instance;
  ValueNotifier<bool> auteticado = ValueNotifier(false);
   ValueNotifier<Map<String, dynamic>>sessao= ValueNotifier({});

   static SessaoController get instance {
     return _instance ??=   SessaoController._();
   }
  SessaoController._();

  
  Future<void> carregarSessao() async{
     sessao.value = await storage.readAll();
    estaAutenticado();
  }
  
  void estaAutenticado(){
    SessaoController.instance.auteticado.value= sessao.value.isNotEmpty;
  }

  Future<void> sair()async{
     try {

       print("olha aqui: ${sessao.value["id"]}");
       await ServidorAppwrite.instance.account.deleteSession(
           sessionId: sessao.value["id"]);
      await storage.deleteAll();
      auteticado.value = false;
     }catch(e){
       print("aquiiiii $e");
       await storage.deleteAll();
       auteticado.value = false;
     }

  }
  
}