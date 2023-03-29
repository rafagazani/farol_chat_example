import 'package:another_flushbar/flushbar.dart';
import 'package:farol_chat/aplicativo_modulo/widget/appbar_widget.dart';
import 'package:farol_chat/autenticacao_modulo/controller/login_controller.dart';
import 'package:flutter/material.dart';

import '../../aplicativo_modulo/widget/logo_farol_widget.dart';
import '../../chat_modulo/page/chats_page.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = LoginController();
  final TextEditingController email =
      TextEditingController(text: 'remail@email.com');
  final TextEditingController senha = TextEditingController(text: 'rafarafa');
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoFarolWidget(
                width: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: email,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(controller: senha),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (await loginController.entrar(email.text, senha.text)) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => ChatsPage()));
                      return;
                    }
                    Flushbar(
                      message: "Tá errado meu parceiro",
                      icon: const Icon(
                        Icons.error_outline,
                        size: 28.0,
                        color: Colors.redAccent,
                      ),
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.redAccent,
                    ).show(context);
                  },
                  child: const Text("ENTRAR")),
            ],
          ),
        ),
      ),
    );
  }
}
