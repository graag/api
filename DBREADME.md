Baza danych
===========

Budowanie obrazu
----------------

Obraz bazy danych powstał na podstawie oficjalnego obrazu [MariaDB][maria-url] dostępnego na platformie [DockerHub][maria-image].

Podczas budowy obrazu wykorzysytwane są trzy zmienne środowiskowe. Każda z nich posiada wartość domyślną, którą można nadpisać podczas budowania (`docker build --build-arg "key=value"`) lub uruchamiania ('docker run -e "key=value"`) obrazu.

|Zmienna|Wartość|Argument|Opis|
|---|---|---|---|
|`MYSQL_DATABASE`|`pet_db`|`dbname`|Nazwa bazy danych, która zostanie zainicjalizowana.|
|`MYSQL_USER`|`pet_user`|`dbuser`|Nazwa użytkownika, właściciela domyślnej bazy danych.|
|`MYSQL_PASSWORD`|`5tgb6yhn`|`dbpswd`|Hasło użytkownika.|

Przykład:

Budowanie obrazu o nazwie `db/test` z nazwą bazy danych inną niż domyślna.

```bash
    docker build \
        --tag db/tests \
        --build-arg "dbname=database" \
        .
```

Uruchomienie kontenera
----------------------

Podczas pierwszego uruchomienia obrazu, zostaje wywołany skrypt `/docker-entrypoint.sh`. Skrypt ten inicjalizuje bazę danych i wywołuje skrypty znajdujące się w folderze `/docker-entrypoint-initdb.d/`. Mechanizm ten wykorzystywany jest do inicjalizacji bazy danych schematem pozyskanym z api. Eliminuje to konieczność migracji bazy danych po stronie api i upraszcza zarządznie przy użyciu `docker-compose`.

Uruchomienie kontenera jest kolejnym etapem, w którym można nadpisać zmienne środowiskowe wymienione wyżej, dodatkowo należy podać hasło dla użytkownika który będzie root'em danej instancji.

Przykład (z wykorzystaniem obrazu z poprzedniej sekcji):

Uruchomienie kontenera o nazwie `db-standalone`, w którym utowrzona zostanie baza danych `database` (wynik zmiany argumentu budowania)  należąca do `user` z domyślnym hasłem. Wszystkie dane zostaną zachowane na `db-volume` aby móc je zachować na dłużej niż czas życia danego kontenera.

```bash
    docker run --rm -it \
        --name db-standalone \
        -e "MYSQL_USER=user" \
        --mount "type=volume,src=db-volume,dst='/var/lib/mysql" \
        db/test
```

Dane
----

Dane bazy danych trzymane są w katalogu `/var/lib/mysql`. Aby zachować dane po zatrzymaniu i usunięciu kontenera należy zmapować ten katalog na `volume` zarządzany przez Docker.

Przykład z poprzedniej sekcji automatycznie utworzy `volume` o nazwie `db-volume` a skrypt inicjalizacyjny zapisze tam dane. Ponowne stworzenie kontenera korzystającego z tego samego `valume` nie uruchomi skryptu incjalizacyjnego i wszystkie dotychczasowe dane zostaną zachowane.

Dostęp do bazy danych
---------------------

Najprostszym sposobem uzyskania dostępu do bazy danych jest wejście od wnętrza kontenera i użycie aplikacji `mysql`.

```bash

    docker exec -it db-standalone bash

    mysql -u user -p
```

Po podaniu hasła, możliwe będzie korzystanie z bazy danych. Aby połączyć sie do bazy danych spoza hosta dockera, należy zmapować domyślny port mysql (3306) na port hosta. Nie jest to wymagane w przypadku domyślnego korzystania z tego obrazu, czyli w przypadku gdy do bazy danych dostępu wymaga jedynie api. Komunikacja pomiędzy api a bazą danych wykorzystuje sieć dockerową która umożliwia komunikację pomiedzy kontenerami na dowolnym porcie.

[maria-url]: <https://mariadb.org/>
[maria-image]: <https://hub.docker.com/_/mariadb>
