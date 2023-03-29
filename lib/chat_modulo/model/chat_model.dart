// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

class ChatModel {
  ChatModel({
    required this.criacao,
    required this.ultimoSms,
    required this.read,
    required this.id,
    required this.collection,
    required this.titulo,
  });

  int criacao;
  String ultimoSms;
  String titulo;
  List<String> read;
  String id;
  String collection;
//  List<Permission> permissions;

  ChatModel.copyWith(ChatModel chat)
      : this(
          criacao: chat.criacao,
          ultimoSms: chat.ultimoSms,
          titulo: chat.titulo,
          read: chat.read,
          id: chat.id,
          collection: chat.collection,
        );

  factory ChatModel.fromRawJson(String str) =>
      ChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        criacao: json["criacao"] ?? 0,
        ultimoSms: json["ultimo_sms"] ?? "",
        titulo: json["titulo"] ?? "",
        read: List<String>.from(json["\u0024permissions"].map((x) => x)),
        id: json["\u0024id"],
        collection: json["\u0024collectionId"],
      );

  Map<String, dynamic> toJson() => {
        "criacao": criacao,
        "ultimo_sms": ultimoSms,
        "titulo": titulo,
      };
}
