import env_servidor
import servidor


def criar_alterar_chat_participantes():
    try:
        servidor.functions.get('alterar_chat_participantes')

    except:
        servidor.functions.create('alterar_chat_participantes', 'alterar_chat_participantes',
                                  ['users'], 'python-3.9',
                                  events=[
                                      'databases.chat.collections.chat_participantes.documents.*.create',
                                      'databases.chat.collections.chat_participantes.documents.*.update',
                                      'databases.chat.collections.chat_participantes.documents.*.delete',
                                  ],
                                  enabled=True
                                  )

        print('Função alterar_chat_participantes criada')

    try:
        servidor.functions.get_variable('alterar_chat_participantes', 'host', )
        servidor.functions.update_variable('alterar_chat_participantes', 'host', env_servidor.servidor)
    except:
        servidor.functions.create_variable('alterar_chat_participantes', 'host', env_servidor.servidor)

    try:
        servidor.functions.get_variable('alterar_chat_participantes', 'projeto', )
        servidor.functions.update_variable('alterar_chat_participantes', 'projeto', env_servidor.projeto)
    except:
        servidor.functions.create_variable('alterar_chat_participantes', 'projeto', env_servidor.projeto)

    try:
        servidor.functions.get_variable('alterar_chat_participantes', 'key', )
        servidor.functions.update_variable('alterar_chat_participantes', 'key', env_servidor.function_key)
    except:
        servidor.functions.create_variable('alterar_chat_participantes', 'key', env_servidor.function_key)
