import 'package:farol_chat/chat_modulo/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../page/chat_page.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatModel chat;
  const ChatItemWidget(this.chat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(chat.id, chat.titulo)));
        },
        child: ListTile(
          leading: const Icon(Icons.supervised_user_circle_outlined),
          title: Text(chat.titulo),
          subtitle: Text(chat.ultimoSms),
          trailing: const Icon(Icons.comment),
        ),
      ),
    );
  }
}
