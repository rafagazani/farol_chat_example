import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';

class ServidorAppwrite {
  ServidorAppwrite._();

  static ServidorAppwrite? _instance;
  Client client = Client();
  Account account = Account(Client());
  Databases database = Databases(Client());
  Storage storage = Storage(Client());
  Realtime realtime = Realtime(Client());
  Functions functions = Functions(Client());
  Teams teams = Teams(Client());

  static ServidorAppwrite get instance {
    return _instance ??= ServidorAppwrite._();
  }

  static String servidor = 'https://cloud.appwrite.io/v1';
  static String projeto = 'chat';
  void main() {
    client
        .setEndpoint(servidor) // Your API Endpoint
        .setProject(projeto)
        .setSelfSigned(status: true);

    if (kDebugMode) {
      print(servidor);
      print(projeto);
    }
    account = Account(client);
    database = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
    functions = Functions(client);
    teams = Teams(client);
  }

  void init() {
    client
        .setEndpoint(servidor) // Your API Endpoint
        .setProject(projeto);

    if (kDebugMode) {
      print(servidor);
      print(projeto);
    }
    account = Account(client);
    database = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
    functions = Functions(client);
    teams = Teams(client);
  }
}
