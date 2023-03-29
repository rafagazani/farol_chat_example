import time

import env_servidor
import servidor


def criar():
    colecao = 'chats'

    try:
        servidor.databases.get_collection(env_servidor.db, colecao)
    except:
        servidor.databases.create_collection(env_servidor.db, colecao, colecao, document_security=True)
        print(f'\U0001F195 Coleção de {colecao} criado')

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'criacao')
    except:
        servidor.databases.create_integer_attribute(env_servidor.db, colecao, key='criacao', required=False, default=0)

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'ultimo_sms')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='ultimo_sms', size=255, required=False, default='')

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'titulo')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='titulo', size=60, required=False, default='')

    time.sleep(4)

    # try:
    #     servidor.databases.get_index(database_id=env_servidor.db, collection_id=colecao, key='titulo')
    # except:
    #     pass
    #     servidor.databases.create_index(database_id=env_servidor.db, collection_id=colecao, key='titulo', type='fulltext',
    #                                     attributes=['titulo'], orders=['ASC'])
    #     print(f"\U0001F195 indexes de {colecao} criado")
    #
    # finally:
    #     pass
