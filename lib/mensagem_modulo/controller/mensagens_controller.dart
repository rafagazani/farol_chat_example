import 'package:appwrite/appwrite.dart';
import 'package:farol_chat/mensagem_modulo/model/mensagem_model.dart';
import 'package:farol_chat/servidor_appwrite/servidor_appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MensagensController {
  ValueNotifier<List<MensagemModel>> mensagens = ValueNotifier([]);
  String chatId;
  final subscription = ServidorAppwrite.instance.realtime
      .subscribe(['databases.chat.collections.mensagens.documents']);
  MensagensController(
    this.chatId,
  ) {
    carregar();
    escutar();
  }

  void escutar() {
    subscription.stream.listen((response) {
      if (response.payload["chat_id"] != chatId) {
        return;
      }

      if (response.events
              .indexWhere((element) => element.contains('*.create')) !=
          -1) {
        debugPrint("inserir mensagem ${response.payload["\u0024id"]}");
        inserir(MensagemModel.fromJson(response.payload));
        return;
      }
      if (response.events
              .indexWhere((element) => element.contains('*.update')) !=
          -1) {
        debugPrint("atualizar chat ${response.payload["\u0024id"]}");
        atualizar(MensagemModel.fromJson(response.payload));
      }

      if (response.events
              .indexWhere((element) => element.contains('*.delete')) !=
          -1) {
        debugPrint("excluir chat ${response.payload["\u0024id"]}");
        excluir(response.payload["\u0024id"]);
      }
    });
  }

  Future<void> carregar() async {
    var response = await ServidorAppwrite.instance.database.listDocuments(
        databaseId: 'chat',
        collectionId: 'mensagens',
        queries: [Query.equal('chat_id', chatId)]);
    for (var item in response.documents) {
      atualizar(MensagemModel.fromJson(item.data));
    }
  }

  void atualizar(MensagemModel mensagem) {
    int index =
        mensagens.value.indexWhere((element) => element.id == mensagem.id);
    if (index != -1) {
      mensagens.value[index] = mensagem;
      mensagens.value = [...mensagens.value];
      return;
    }
    inserir(mensagem);
  }

  void excluir(String id) {
    mensagens.value.removeWhere((element) => element.id == id);
    mensagens.value = [...mensagens.value];
  }

  void inserir(MensagemModel mensagem) {
    mensagens.value.add(mensagem);

    mensagens.value = [...mensagens.value];
  }

  Future<void> novo(String titulo) async {
    String? userId = await FlutterSecureStorage().read(key: "userId");
    var mensagem = MensagemModel(
      dataDeEnvio: DateTime.now(),
      autor: "$userId",
      sms: titulo,
      read: [],
      chatId: chatId,
      id: '',
      collection: 'mensagens',
    );

    await ServidorAppwrite.instance.database.createDocument(
        databaseId: 'chat',
        collectionId: mensagem.collection,
        documentId: 'unique()',
        permissions: [
          Permission.read(Role.users()),
          Permission.write('$userId')
        ],
        data: mensagem.toJson());
  }

  void dispose() {
    subscription.close();
    mensagens.dispose();
  }
}
