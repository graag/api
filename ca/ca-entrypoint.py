import sys
from subprocess import run


def ca_init(*args):
    run(['./ca/easyrsa', 'init-pki'])
    run(['./ca/easyrsa', 'build-ca'])


def generate_proxy(*args):
    print('generate proxy')


def exit(*args):
    sys.exit(0)


def list_entities(*args):
    print('entities')

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

