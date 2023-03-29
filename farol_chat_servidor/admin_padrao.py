import time

import env_servidor
import servidor


def criar_admin_padrao():
    try:
        servidor.teams.get('admin')
        servidor.users.create('primeiro-user', 'email@email.com', password='rafarafa', name='Rafael')

        time.sleep(1)
        servidor.teams.create_membership('admin', 'email@email.com', ['owner'], name='Rafael', url=env_servidor.cliente)

    except:
        servidor.teams.create('admin', 'admin')
        servidor.users.create('primeiro-user', 'email@email.com', password='rafarafa', name='Rafael')

        time.sleep(1)
        servidor.teams.create_membership('admin', 'email@email.com', ['owner'], name='Rafael', url=env_servidor.cliente)

    finally:
        pass
