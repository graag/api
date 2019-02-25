Rest API
========

Budowanie obrazu
----------------

Obraz api powstał na podstawie oficjalnego obrazu[Pythona][python-url] dostępnego na platformie [DockerHub][python-image]. Do obrazu bazowego dodany został framework [Django][django-url] wraz z [django-rest][rest-url] oraz serwer [Gunicorn][gunicorn-url].

Podczas budowy obrazu wykorzysytwanych jest kilka zmiennych środowiskowych, 3 dotyczą samego api, 5 definiuje połączenie z bazą danych. Zmienne środowiskowe dotyczące api można modyfikować zarówno podczas budowania (docker build) jak i uruchamiania obrazu (docker run). Zmienne dotyczące bazy danych mogą być modyfikowane tylko przy uruchomieniu obrazu.

API
***
|Zmienna|Wartość|Argument|Opis|
|---|---|---|---|
|`API_DEBUG`|`False`|`DEBUG`| Umożliwia uruchomienie api w trybie debug. |
|`API_HOSTS`|`api`|`HOSTS`| Lista CSV definiująca wartość nagłówka Host obsługiwanych requestów. Przykładowo `"API_HOSTS=localhost,0.0.0.0"` obsłużu zapytanie pod adres `http://localhost:8000/api` natomiast odrzuci zapytanie `http://127.0.0.1:8000/api`|
|`API_SECRET`| `-` |`SECRET`| Zmienna używano jako seed do funkcji kryptograficznych frameworku. Nie posiada wartości domyślnej co wymusza samodzielne jej ustawienie. W przeciwnym wypadku, uruchomienie api zakończy się błędem.|

Baza Danych
***********
|Zmienna|Wartość|Opis|
|---|---|---|
|`DB_DEBUG`|`False`| Opcja umożliwiająca tymczasowe użycie bazy danych sqlite. Wymaga migracji po uruchomieniu kontenera. |
|`DB_NAME`|`pet_db`| Nazwa bazy danych z której będzie korzystać api. |
|`DB_USER`|`pet_user`| Nazwa użytkownika używana do połączenia z bazą danych.|
|`DB_PASS`|`5tgb6yhn`| Hasło uśytkownika używane do połączenia z bazą danych.|
|`DB_HOST`|`pet_db`| Host bazy danych, w domyślnej konfiguracji jest to nazwa kontenera bazy danych w dockerowej sieci w której znajduje się kontener api.|
|`DB_PORT`|`3306`| Port bazy danych.|

Przykład:

Budowanie obrazu o nazwie `api/test` akceptującego zapytania pod adres `localhost`.

```bash
    docker build \
        --tag db/tests \
        --build-arg "HOSTS=localhost" \
        .
```

Uruchomienie kontenera
----------------------

Przed uruchomieniem kontenera api należy pamiętać o zminnej `API_SECRET`. Podczas każdej budowy obrazu api generowany i zapisywany do pliky jest nowy hash. Ta wartość wykorzystywana jest w przypadku, gdy kontener zostanie uruchomiony bez ustawienia wartości `API_SECRET`. Nowy hash można wygenerować korzystając z funckcji usdostępnianych przez [Django][django-url].

```bash
    python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())
    ...
    nh&)%(^n8_k8hgrs6%onq5&(ynw9395#s%5#b5k9fofd%8t&8c
```

Przykład uruchomienia kontenera api działającego w sieci docker'owej, akceptującego zapytania do host'a `localhost` (zakładając obraz zbudowany za pomocą komendy z poprzedniej sekcji), oraz korzystającego z bazy danych o nazwie `test_db` udostępnionej przez hosta `db_server`.

```bash
    docker run -it \
        --name api \
        --network pet_net \
        -e "DB_NAME=test_db" \
        -e "DB_HOST=db_server" \
        -e "API_SECRET=nh&)%(^n8_k8hgrs6%onq5&(ynw9395#s%5#b5k9fofd%8t&8c" \
        pet/api
```

Przykład pracy z api w trybie DEBUG
-----------------------------------
Budowa obrazu:

```bash
    docker build \
        --tag test/api \
        .
```

Uruchomienie obrazu:

```bash
docker run -it \
    --name api-debug \
    -p 8000:8000 \
    -e "DB_DEBUG=True" \
    -e "API_DEBUG=True" \
    -e "API_HOSTS=localhost" \
    -e "API_SECRET=secret" \
    test/api
```
Po wykonaniu powyższych komend shell-a, uruchomiona zostanie instancja api, która:
 * korzysta z bazy danych utworzonej wewnątrz systemu plików kontenera (wymagana wstępna migracja)
 * akceptuje zapytania skierowane do host-a `localhost`
 * nasłuchuje na porcie `8000`
 * w przypadku błędnych zapytań zwraca dane ułatwiające dalsze debugowanie

Migracja:

```bash
    docker exec -it api-debug /bin/sh -c \
    "python3 manage.py makemigrations rest && python3 manage.py migrate"
```

Api zakłada, że znajduje się za serwerem proxy zapewniającym wstępną autoryzację i autekntyfikację. Wynik zapytania do api silnie zleży od pola `CN` w certyfikacie SSL. Aby zasymulować działanie serwera proxy i obsługę zapytania należy:

1. Utowrzyć wpis w bazie danych odpowiadający modelowi `Entity`, którego pole `common_name` powinno odpowiadać polu w certyfikacie i znajdować się w nagłówku `CLIENT_CERT` wraz z innymi danymi o certyfikacie.

```bash
    docker exec -it api-debug /bin/sh -c \
    "python3 manage.py shell"

    from rest.models import Entity
    Entity(
        common_name='test_entity',

    ).save()
    exit()
```

2. Stworzyć zapytanie z odpowiednio ustawionym nagłówkiem `CLIENT_CERT`.
```bash
    curl http://localhost:8000/api/entity \
    -H "CLIENT_CERT: CN=test_entity"
    ...
    {
        "id":1,
        "common_name":"test_entity",
        "name":"",
        "address":"",
        "contact":"",
        "comments":null,"timestamp":"2019-02-18T20:34:36.813165Z"
    }
```

W ramach zapytania, zwrócone zostały dane o obiekcie Entity odpowiadającemu `CN` certyfikatu. Zapytanie zawierające błędna (nieistniejącą w bazie danych) wartość `CN` lub nie zawierające nagłówka `CLIENT_CERT` zakończy się niepowodzeniem.

```bash
    curl http://localhost:8000/api/entity
    ...
    {
        "detail":"Authentication credentials were not provided."
    }
```

Panel administratora
--------------------

Korzystanie z panelu administratora wymaga utworzenia konta `superuser` wraz z każdą nową bazą danych (po inicjalizacji/usunięciu `volume`). Wymaga to uruchomienia komendy wewnątrz kontenera `api`. Zakładając, że kontener nazywa się `pet-api`:

```bash
docker exec -it pet-api bash
python3 manage.py createsuperuser
```

Endpointy
---------
TODO

[python-url]: <https://www.python.org/>
[python-image]: <https://hub.docker.com/_/python>
[django-url]: <https://www.djangoproject.com/>
[rest-url]: <https://www.django-rest-framework.org/>
[gunicorn-url]: <https://gunicorn.org/>
