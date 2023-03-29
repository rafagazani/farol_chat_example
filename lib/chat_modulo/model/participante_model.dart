import 'package:appwrite/appwrite.dart';
import 'package:farol_chat/servidor_appwrite/model/documento_model.dart';

class ParticipanteModel extends DocumentoModel {
  String email;
  String chatId;

  ParticipanteModel({
    required this.email,
    required this.chatId,
    required super.read,
    required super.id,
    required super.collection,
  });

  factory ParticipanteModel.fromJson(Map<String, dynamic> json) =>
      ParticipanteModel(
        email: json["user_email"] ?? 0,
        chatId: json["chat_id"] ?? "",
        read: List<Permission>.from(json["\u0024permissions"].map((x) => x)),
        id: json["\u0024id"],
        collection: json["\u0024collection"],
      );
}
