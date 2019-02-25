CA
===

Budowanie obrazu
----------------
Obraz api powstał na podstawie oficjalnego obrazu [Pythona][python-url] dostępnego na platformie [DockerHub][python-image]. Do obrazu bazowego dodany został skrypt [EasyRSA][easyrsa-url]. Kontener ten ma za zadanie stworzenie spójnego środowiska do tworzenia certyfikatów z możliwości wykorzystanie narzędzi Docker'a.

Przykłady
---------
Zalecane mapowanie katalogów obrazu:

|Katalog|Opis|
|---|---|
|/opt/ca-data| Katalog w którym znajdują się pliki utworzonego CA. |
|/opt/proxy| Katalog wykorzystywany w przykładach do utworzenia `volume` używanego przez `proxy`.|
|/opt/client| Katalog wykorzystywany do udostępniania utworzonych certyfikatów klientów w systemie plików hosta. |

Przykładowo, aby uruchomić kontener `ca` z podpiętym volume'em `proxy-data` (wykorzystywanym przez `proxy`) oraz katalogami `/opt/ca-data/` i `/opt/client/` zmapowanymi na system plików hosta:

```bash
docker run --rm -it \
    -v proxy-data:/opt/proxy \
    -v /host/filesystem/path/client:/opt/client \
    -v /host/filesystem/path/ca-data:/opt/ca-data \
    pet/ca
```

Używając [EasyRSA][easyrsa-url] bezpośrednio należy pamiętać, że dane certyfikatów nie są walidowane/synchronizowane z api (przykłady zakładają uruchomienie kontenera jak powyżej):

1. Utworzenie CA
    * Inicjalizacja PKI
        ```bash
        ./easyrsa init-pki
        ./easyrsa build-ca
        ```
        Utworzone zostaną pliki:
        - /opt/ca-data/pki/ca.crt
        - /opt/ca-data/pki/private/ca.key (klucz prywatny ca)


    * Generowanie CRL i parametrów DH
        ```bash
        ./easyrsa gen-crl
        ./easyrsa gen-dh
        ```
        Utworzone zostaną pliki:
        - /opt/ca-data/pki/dh.pem
        - /opt/ca-data/pki/crl.pem

2. Generowanie certyfikatu Proxy
    ```bash
    ./easyrsa gen-req proxy nopass
    ./easyrsa sign-req server proxy
    ```
    Utworzone zostaną pliki:
    - /opt/ca-data/pki/reqs/proxy.req
    - /opt/ca-data/pki/private/proxy.key
    - /opt/ca-data/pki/issued/proxy.crt

    Wykonanie powyższych instrukcji umożliwia przygotowanie volume z certyfikatami dla `proxy`:
    ```bash
    cp /opt/ca-data/pki/private/proxy.key ./proxy
    cp /opt/ca-data/pki/issued/proxy.crt ./proxy
    cp /opt/ca-data/pki/dh.pem ./proxy
    cp /opt/ca-data/pki/crl.pem ./proxy
    cp /opt/ca-data/pki/ca.crt ./proxy
    ```

3. Generowanie certyfikatu kliena
    ```bash
    ./easyrsa gen-req entity nopass
    ./easyrsa sign-req client entity
    ```
    Utworzone zostaną pliki:
    - /opt/ca-data/pki/reqs/client.req
    - /opt/ca-data/pki/private/client.key
    - /opt/ca-data/pki/issued/client.crt

    Pliki umożliwiające wykonanie zapytania do api można przekopiować do systemu plików hosta poprzez skorzystanie ze współdzielonego katalogu `client`:
    ```bash
    cp /opt/ca-data/pki/private/client.key ./client
    cp /opt/ca-data/pki/issued/client.crt ./client
    cp /opt/ca-data/pki/ca.crt ./client
    ```

Używając skryptu:
TODO

[python-url]: <https://www.python.org/>
[python-image]: <https://hub.docker.com/_/python>
[easyrsa-url]: <https://github.com/OpenVPN/easy-rsa>
