import 'package:appwrite/appwrite.dart';
import 'package:farol_chat/chat_modulo/model/participante_model.dart';
import 'package:flutter/cupertino.dart';

import '../../servidor_appwrite/servidor_appwrite.dart';

class ParticipantesController extends ValueNotifier<List<ParticipanteModel>> {
  final String chatId;
  final subscription = ServidorAppwrite.instance.realtime
      .subscribe(['databases.chat.collections.chat_participantes.documents']);
  ParticipantesController(this.chatId) : super([]) {
    escutar();
    carregar();
  }

  void escutar() {
    subscription.stream.listen((response) {
      if (response.payload["chat_id"] != chatId) {
        return;
      }

      if (response.events
              .indexWhere((element) => element.contains('*.create')) !=
          -1) {
        debugPrint("inserir participante ${response.payload["user_email"]}");
        inserir(response.payload);
        return;
      }

      if (response.events
              .indexWhere((element) => element.contains('*.delete')) !=
          -1) {
        debugPrint("excluir participante ${response.payload["\u0024id"]}");
        excluir(id: response.payload["\u0024id"]);
      }
    });
  }

  Future<void> carregar() async {
    var response = await ServidorAppwrite.instance.database.listDocuments(
        databaseId: 'chat',
        collectionId: 'chat_participantes',
        queries: [Query.equal('chat_id', chatId)]);
    for (var item in response.documents) {
      inserir(item.data);
    }
  }

  void inserir(Map<String, dynamic> data) {
    ParticipanteModel participanteModel = ParticipanteModel.fromJson(data);
    value.add(participanteModel);
    value = [...value];
  }

  void excluir({ParticipanteModel? participante, String id = ''}) async {
    if (participante != null) {
      await ServidorAppwrite.instance.database.deleteDocument(
          databaseId: 'chat',
          collectionId: participante.collection,
          documentId: participante.id);
    }
    value.removeWhere((item) => item.id == id);
    value = [...value];
  }

  Future<void> novo(String email) async {
    if (email.isEmpty) return;
    if (value.indexWhere((element) =>
            element.email.toLowerCase() == email.toLowerCase().trim()) !=
        -1) return;
    ServidorAppwrite.instance.database.createDocument(
        databaseId: 'chat',
        collectionId: 'chat_participantes',
        documentId: 'unique()',
        data: {"chat_id": chatId, "user_email": email.toLowerCase()});
  }

  void dispose() {
    subscription.close();
    super.dispose();
  }
}
