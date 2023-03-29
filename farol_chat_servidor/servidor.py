from appwrite.services.account import Account
from appwrite.services.functions import Functions
from appwrite.services.storage import Storage
from appwrite.services.teams import Teams
from appwrite.services.users import Users

import env_servidor
from appwrite.client import Client
from appwrite.services.databases import Databases

client = Client()

(client
 .set_endpoint(env_servidor.servidor)  # Your API Endpoint
 .set_project(env_servidor.projeto)  # Your project ID
 .set_key(env_servidor.chave)  # Your secret API key
 )

databases = Databases(client)
try:
    databases.get(env_servidor.db)

except:
    databases.create(env_servidor.db, env_servidor.db)

storage = Storage(client)
functions = Functions(client)
teams = Teams(client)
account = Account(client)
users = Users(client)

# DEV, PRODUCAO
ambiente = 'DEV'
