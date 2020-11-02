Proxy
=====

Budowanie obrazu
----------------

Obraz api powstał na podstawie oficjalnego obrazu [Nginx][nginx-url] dostępnego na platformie [DockerHub][nginx-image] do którego dodano plik konfiguracyjny serwera. Serwer przekierowuje zapytania wysyłane na port 8000 do kontenera api oraz dodaje nagłówek `CLIENT-CERT` służący do identyfikacji `Entity` wysyłającego zapytanie.

Certyfikaty
-----------

Uruchomienie kontenera z serwerem proxy wymaga utworzenia `volume` zawierającego pliki wymagane do komunikacji z użyciem protokołu https. Są to:

* proxy.crt - certyfikat serwera proxy podpisany przez ca.
* proxy.key - klucz prywatny serwera proxy.
* ca.crt - certyfikat CA używany do autoryzacji certyfikatów klientów.
* dh.pem - parametry Diffie-Hellman.
* crl.pem - lista unieważnionych certyfikatów.

Do utworzenia certyfikatów wykorzystywany jest skrypt [EasyRSA][easyrsa-repo] oraz kontener ca. Certyfikaty powinny zostać utworzone przed uruchomieniem kontenera z obrazem proxy w katalogu `/certs`. 


[nginx-url]: <https://nginx.org/>
[nginx-image]: <https://hub.docker.com/_/nginx/>
[easyrsa-repo]: <https://github.com/OpenVPN/easy-rsa>
