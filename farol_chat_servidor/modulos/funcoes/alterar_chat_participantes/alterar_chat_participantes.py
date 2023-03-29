import json
import os

from appwrite.client import Client
from appwrite.services.databases import Databases

# appwrite functions createDeployment --functionId=alterar_chat_participantes --activate=true --entrypoint="alterar_chat_participantes.py" --code="."
from appwrite.services.users import Users


def init_clint():
    client = Client()
    client.set_endpoint(os.getenv("host"))
    client.set_project(os.getenv("projeto"))
    client.set_key(os.getenv("key"))
    return client


def main(request, response):
    client = init_clint()
    database = Databases(client)
    users = Users(client)

    evento = request.env['APPWRITE_FUNCTION_EVENT']
    data = json.loads(request.env['APPWRITE_FUNCTION_EVENT_DATA'] or "{}")
    chat_document = database.get_document('chats', data['chat_id'])

    retorno = users.list(search=data['user_email'], limit=1)
    if retorno["total"] == 0:
        usuario = users.create(user_id='unique()', email=data['user_email'], password='trocarsenha')
    else:
        usuario = retorno['users'][0]

    if ".create" in evento:
        chat_document['$read'].append("user:{}".format(usuario["$id"]))

    if ".delete" in evento:
        chat_document['$read'].remove("user:{}".format(usuario["$id"]))

    database.update_document('chats', data['chat_id'],
                             {"criacao":chat_document['criacao']},
                             read=chat_document['$read']
                             )

    return response.json({"id usuario": usuario["$id"]})
