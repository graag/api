PetAPI
======

Struktura
---------
Aplikacja korzysta z 3 kontenerów, które powinny działać we wspólnej sieci dockerowej. Są to:

* `db` - baza danych MariaDB.
* `api` - aplikacja stworzona przy pomocy framework'u Django.
* `proxy` - serwer Nginx umożliwiający połączenie z api.

Każdy z powyżej wymienionych elementów znajduje się w odzielnym katalogu wraz z bardziej szczegółowym opisem działania i konfiguracji.

Docker-Compose
--------------

Najprostszym sposobem uruchomienia całej aplikacji jest skorzystanie z narzędzia [DockerCompose][docker-compose-url]. Zarządza ono kontenerami i ich zasobami zgodnie z zawartością pliku `docker-compose.yaml`.

**Do poprawnego działania kontenera z serwerem Nginx wymagane jest utworzenie volume z certyfikatami. Więcej w README w katalogu ca.**

Uruchomienie i zatrzymanie aplikacji ogranicza się do dwóch komend:

    docker-compose up
    docker-compose down

Budowanie kontenerów, tworzenie sieci dockerowej, publikowanie portów itp. odbywa się automatycznie.

[docker-compose-url]:<https://docs.docker.com/compose/>