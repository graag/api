FROM nginx

RUN mkdir /certs

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./static /static
EXPOSE 8000
