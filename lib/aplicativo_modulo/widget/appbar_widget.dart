import 'package:farol_chat/autenticacao_modulo/controller/sessao_controller.dart';
import 'package:farol_chat/autenticacao_modulo/page/login_page.dart';
import 'package:flutter/material.dart';

import 'logo_farol_widget.dart';

// ignore: must_be_immutable
class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  bool center = false;
  AppbarWidget({Key? key, this.center = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LogoFarolWidget(),
      leading: Container(),
      centerTitle: center,
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: SessaoController.instance.auteticado,
          builder: (context, autenticado, chidl) {
            print(autenticado);
            return Visibility(
              visible:autenticado,
              child: IconButton(
                  onPressed: () async {
                    await SessaoController.instance.sair();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.exit_to_app)),
            );
          }
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}
