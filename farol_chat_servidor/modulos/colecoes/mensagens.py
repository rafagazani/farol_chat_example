import time

import env_servidor
import servidor


def criar():
    colecao = 'mensagens'

    try:
        servidor.databases.get_collection(env_servidor.db, colecao)
    except:
        servidor.databases.create_collection(env_servidor.db, colecao, colecao, document_security=True)
        print(f'\U0001F195 Coleção de {colecao} criado')

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'data')
    except:
        servidor.databases.create_integer_attribute(env_servidor.db, colecao, key='data', required=False, default=0)

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'sms')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='sms', size=255, required=True)

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'autor')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='autor', size=255, required=True)

    try:
        servidor.databases.get_attribute(env_servidor.db, colecao, 'chat_id')
    except:
        servidor.databases.create_string_attribute(env_servidor.db, colecao, key='chat_id', size=50, required=True)
