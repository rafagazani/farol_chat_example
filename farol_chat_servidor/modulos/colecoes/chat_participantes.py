import time

import env_servidor
import servidor


def criar():
    colecao = 'chat_participantes'

    try:
        servidor.databases.get_collection(env_servidor.db, colecao)
    except:
        servidor.databases.create_collection(env_servidor.db, colecao, colecao, document_security=True)
        print(f'\U0001F195 Coleção de {colecao} criado')

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'user_email')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, size=255, key='user_email', required=True)

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'chat_id')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='chat_id', size=50, required=True,)

    time.sleep(4)

    try:
        servidor.databases.get_index(database_id=env_servidor.db, collection_id=colecao, key='user_email')
    except:
        servidor.databases.create_index(database_id=env_servidor.db, collection_id=colecao, key='user_email', type='key',
                                        attributes=['user_email'], orders=['ASC'])

    try:
        servidor.databases.get_index(database_id=env_servidor.db, collection_id=colecao, key='chat_id')
    except:
        servidor.databases.create_index(database_id=env_servidor.db, collection_id=colecao, key='chat_id',
                                        type='key',
                                        attributes=['chat_id'], orders=['ASC'])
        print(f"\U0001F195 indexes de {colecao} criado")

    finally:
        pass
