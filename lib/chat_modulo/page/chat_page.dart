import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:farol_chat/chat_modulo/widget/drawer_participantes.dart';
import 'package:farol_chat/mensagem_modulo/controller/mensagens_controller.dart';
import 'package:farol_chat/mensagem_modulo/model/mensagem_model.dart';
import 'package:flutter/material.dart';

import '../../autenticacao_modulo/controller/sessao_controller.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String assunto;

  ChatPage(this.chatId, this.assunto, {Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final texto = TextEditingController(text: '');
  late MensagensController mensagensController;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    mensagensController = MensagensController(widget.chatId);
    super.initState();
  }

  @override
  void dispose() {
    mensagensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        endDrawer: Drawer(
          child: DrawerParticipantes(widget.chatId),
        ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(widget.assunto, style: const TextStyle(fontSize: 18),),
        ),
        bottomNavigationBar: Container(
          color: Colors.grey.withOpacity(0.4),
          child: ListTile(
            leading: const Icon(
              Icons.file_download,
              color: Colors.transparent,
            ),
            title: TextField(
              controller: texto,
              maxLines: 2,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                mensagensController.novo(texto.text);
                texto.clear();
              },
            ),
          ),
        ),
        body: ValueListenableBuilder<List<MensagemModel>>(
          valueListenable: mensagensController.mensagens,
          builder: (BuildContext context, lista, child) {
            // scrollController
            //     .jumpTo(scrollController.position.maxScrollExtent + 50);
            return ListView.builder(
                controller: scrollController,
                itemCount: lista.length,
                itemBuilder: (bcontext, index) {
                  final mensagem = lista[index];
                  return BubbleNormal(
                    text: mensagem.sms,
                    isSender: mensagem.souOAutor,
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    tail: true,
                   // seen: true,
                    delivered: true,

                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  );
                  // return Text(
                  //   mensagem.sms,
                  //   textAlign:
                  //       mensagem.souOAutor ? TextAlign.right : TextAlign.left,
                  // );
                });
          },
        ),
      ),
    );
  }
}
