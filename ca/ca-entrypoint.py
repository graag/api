import sys
import json
from urllib.request import urlopen
from subprocess import run

def _run_easy(*args):
    run(['./ca/easyrsa', *args])

def ca_init(*args):
    _run_easy('init-pki')
    _run_easy('build-ca')
    _run_easy('gen-crl')
    _run_easy('gen-dh')


def generate_proxy(*args):
    _run_easy('gen-req', 'proxy', 'nopass')
    _run_easy('sign-req', 'server', 'proxy')


def exit(*args):
    sys.exit(0)


def list_entities(*args):
    response = urlopen('http://pet-api:8000/ca/entities')
    json_data = json.loads(response.read())
    id_name_map = map(lambda data: f'{data["id"]}: {data["common_name"]}', json_data)
    for entity in id_name_map:
        print(entity)


def list_auths(entity_name, *args):
    print(f'listing for {entity_name}')

COMMANDS = {
    'init': ca_init,
    'gen-proxy': generate_proxy,
    'exit': exit,
    'entities': list_entities,
    'auths': list_auths,

}


if __name__ == '__main__':
    print('Hello!')
    while True:
        command, *args = input().split(' ')
        if (command not in COMMANDS):
            print('Invalid command.')
            print(COMMANDS.keys())
            continue
        try:
            COMMANDS[command](*args)
        except Exception as e:
            print(f'ERROR executing command {command} with args {args}')
            print(e)

