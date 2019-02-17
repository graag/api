FROM mariadb

ARG dbname=pet_db
ARG dbuser=pet_user
ARG dbpswd=5tgb6yhn

ENV MYSQL_DATABASE=${dbname}
ENV MYSQL_USER=${dbuser}
ENV MYSQL_PASSWORD=${dbpswd}

COPY ./db_api_data.sql /db_api_data.sql
COPY ./init_script.sh /docker-entrypoint-initdb.d/init_script.sh

