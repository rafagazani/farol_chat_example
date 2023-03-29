import 'package:farol_chat/chat_modulo/controller/participantes_controller.dart';
import 'package:farol_chat/chat_modulo/model/participante_model.dart';
import 'package:flutter/material.dart';

class DrawerParticipantes extends StatefulWidget {
  final String chatId;
  const DrawerParticipantes(this.chatId, {Key? key}) : super(key: key);

  @override
  State<DrawerParticipantes> createState() => _DrawerParticipantesState();
}

class _DrawerParticipantesState extends State<DrawerParticipantes> {
  late ParticipantesController participantesController;
  final novoEmail = TextEditingController(text: '');
  @override
  void initState() {
    participantesController = ParticipantesController(widget.chatId);
    super.initState();
  }

  @override
  void dispose() {
    participantesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: novoEmail,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        participantesController.novo(novoEmail.text);
                        novoEmail.clear();
                      },
                      child: Text("ADICIONAR")),
                ],
              ),
            ),
          ),
          Flexible(
            child: ValueListenableBuilder<List<ParticipanteModel>>(
              valueListenable: participantesController,
              builder: (BuildContext context, lista, child) {
                return ListView.builder(
                    primary: false,
                    itemCount: lista.length,
                    itemBuilder: (bcontext, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(lista[index].email),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            participantesController.excluir(participante: lista[index]);
                          },
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
