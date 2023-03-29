import 'package:appwrite/appwrite.dart';
import 'package:farol_chat/chat_modulo/model/chat_model.dart';
import 'package:farol_chat/servidor_appwrite/servidor_appwrite.dart';
import 'package:flutter/cupertino.dart';

import '../../autenticacao_modulo/controller/sessao_controller.dart';

class ChatsController extends ValueNotifier<List<ChatModel>> {
  final subscription = ServidorAppwrite.instance.realtime
      .subscribe(['collections.chats.documents']);
  ChatsController() : super([]) {
    carregar();
    escutar();
  }

  void escutar() {
    subscription.stream.listen((response) {
      if (response.events
              .indexWhere((element) => element.contains('*.create')) !=
          -1) {
        debugPrint("inserir chat ${response.payload["\u0024id"]}");
        final chat = ChatModel.fromJson(response.payload);
        inserir(chat);
        return;
      }
      if (response.events
              .indexWhere((element) => element.contains('*.update')) !=
          -1) {
        debugPrint("atualizar chat ${response.payload["\u0024id"]}");
        final chat = ChatModel.fromJson(response.payload);
        atualizar(chat);
        return;
      }

      if (response.events
              .indexWhere((element) => element.contains('*.delete')) !=
          -1) {
        debugPrint("excluir chat ${response.payload["\u0024id"]}");
        excluir(response.payload["\u0024id"]);
      }
    });
  }

  void inserir(ChatModel chat) {
    value.add(chat);
    value = [...value];
  }

  void atualizar(ChatModel chat) {
    int index = value.indexWhere((element) => element.id == chat.id);
    if (index != -1) {
      value[index] = chat;
      value = [...value];
      return;
    }
    inserir(chat);
  }

  void atualizarAssunto(ChatModel chat) async {
    ServidorAppwrite.instance.database.updateDocument(
        databaseId: 'chat',
        collectionId: chat.collection,
        documentId: chat.id,
        data: chat.toJson());
  }

  void excluir(String id) {
    value.removeWhere((element) => element.id == id);
    value = [...value];
  }

  Future<void> carregar() async {
    var response = await ServidorAppwrite.instance.database
        .listDocuments(databaseId: 'chat', collectionId: 'chats');
    for (var item in response.documents) {
      atualizar(ChatModel.fromJson(item.data));
    }
  }

  Future<void> novo(String titulo) async {
    var chat = ChatModel(
        criacao: DateTime.now().millisecondsSinceEpoch,
        ultimoSms: '',
        read: [],
        id: '',
        collection: 'chats',
        titulo: titulo);
    ServidorAppwrite.instance.database.createDocument(
        databaseId: 'chat',
        collectionId: chat.collection,
        documentId: 'unique()',
        permissions: [
          Permission.write(
              Role.user(SessaoController.instance.sessao.value["userId"])),
          Permission.read(SessaoController.instance.sessao.value["userId"]),
        ],
        data: chat.toJson());
  }

  void dispose() {
    print("fechou chats");
    subscription.close();
    super.dispose();
  }
}
