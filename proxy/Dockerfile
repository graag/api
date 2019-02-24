FROM nginx

RUN mkdir /certs

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /www/data/index.html
EXPOSE 8000
