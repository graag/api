FROM mariadb

ENV MYSQL_DATABASE=pet_db
ENV MYSQL_USER=pet_user
ENV MYSQL_PASSWORD=5tgb6yhn

COPY ./db_api_data.sql /db_api_data.sql
COPY ./init_script.sh /docker-entrypoint-initdb.d/init_script.sh

