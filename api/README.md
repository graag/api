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
TODO

Endpointy
---------
TODO

[python-url]: <https://www.python.org/>
[python-image]: <https://hub.docker.com/_/python>
[django-url]: <https://www.djangoproject.com/>
[rest-url]: <https://www.django-rest-framework.org/>
[gunicorn-url]: <https://gunicorn.org/>
