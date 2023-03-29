import 'package:appwrite/appwrite.dart';

class DocumentoModel {
  List<Permission> read = [];
  String id = '';
  String collection = '';
  DocumentoModel({
    required this.id,
    required this.collection,
    required this.read,
  });
}
