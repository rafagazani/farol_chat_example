import 'package:appwrite/models.dart';
import 'package:farol_chat/autenticacao_modulo/controller/sessao_controller.dart';
import 'package:farol_chat/servidor_appwrite/servidor_appwrite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  String email = '';
  String senha = '';
  var storage = FlutterSecureStorage();

  Future<bool> entrar(String email, senha) async {
    try {
      Session sessao =
          await ServidorAppwrite.instance.account.createEmailSession(
        email: email,
        password: senha,
      );

      await storage.write(key: "id", value: sessao.$id);
      await storage.write(key: "userId", value: sessao.userId);

      print(await storage.read(key: "id"));

      if (sessao.$id.isNotEmpty) {
        SessaoController.instance.auteticado.value = true;
        return true;
      }

      return false;
    } catch (e) {
      print("login entrar: ${e.toString()}");
      return false;
    }
  }
}
