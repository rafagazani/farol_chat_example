import 'package:farol_chat/aplicativo_modulo/widget/appbar_widget.dart';
import 'package:farol_chat/chat_modulo/controller/chats_controller.dart';
import 'package:flutter/material.dart';

import '../model/chat_model.dart';
import '../widget/chat_item_widget.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final ChatsController chats;

  @override
  void initState() {
    chats = ChatsController();
    super.initState();
  }

  @override
  void dispose() {
    chats.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        center: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TextEditingController controller = TextEditingController(text: '');
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("qual o assunto?"),
                    content: TextField(
                      controller: controller,
                      maxLength: 50,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.text.isEmpty) return;
                          chats.novo(controller.text);
                          Navigator.pop(context);
                        },
                        child: Text("Criar"),
                      ),
                    ],
                  ));
        },
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SafeArea(
            child: ValueListenableBuilder<List<ChatModel>>(
              valueListenable: chats,
              builder: (BuildContext context, lista, child) {
                return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                          onLongPress: (){
                            TextEditingController controller = TextEditingController(text: lista[index].titulo);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Editar assunto"),
                                  content: TextField(
                                    controller: controller,
                                    maxLength: 50,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (controller.text.isEmpty) return;
                                        lista[index].titulo= controller.text;
                                        chats.atualizarAssunto(lista[index]);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Salvar"),
                                    ),
                                  ],
                                ));
                          },
                          child: ChatItemWidget(lista[index]));
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
