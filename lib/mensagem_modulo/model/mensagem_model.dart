import 'package:appwrite/appwrite.dart';
import 'package:farol_chat/autenticacao_modulo/controller/sessao_controller.dart';

class MensagemModel {
  String id;
  String chatId;
  String sms;
  String autor;
  DateTime dataDeEnvio;
  List<Permission> read;
  String collection;

  MensagemModel({
    required this.sms,
    required this.chatId,
    required this.autor,
    required this.dataDeEnvio,
    required this.read,
    required this.id,
    required this.collection,
  });

  factory MensagemModel.fromJson(Map<String, dynamic> json) => MensagemModel(
        sms: json['sms'] ?? '',
        autor: json['autor'] ?? '',
        dataDeEnvio: DateTime.fromMillisecondsSinceEpoch(json['data'] ?? 0),
        chatId: json['chat_id'] ?? '',
        read: List<Permission>.from(json["\u0024permissions"].map((x) => x)),
        id: json["\u0024id"],
        collection: json["\u0024collection"],
      );

  Map<String, dynamic> toJson() => {
        "data": dataDeEnvio.millisecondsSinceEpoch,
        "sms": sms,
        "chat_id": chatId,
        "autor": autor,
      };

  bool get souOAutor =>
      read.indexWhere((element) =>
          element.toString() ==
          'delete(user:${SessaoController.instance.sessao.value["userId"]})') !=
      -1;
}
