FROM python:3.7

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ARG DEBUG=False
ARG HOSTS=api
ARG SECRET

ENV API_DEBUG=${DEBUG}
ENV API_HOSTS=${HOSTS}
ENV API_SECRET=${SECRET}

ENV DB_DEBUG=False
ENV DB_NAME=pet_db
ENV DB_USER=pet_user
ENV DB_PASS=5tgb6yhn
ENV DB_HOST=pet_db
ENV DB_PORT=3306

# RUN mkdir /config && mkdir /opt/pet
COPY ./requirements.pip /
RUN pip install -r /requirements.pip && \
    rm /requirements.pip

RUN mkdir /opt/pet_api
COPY ./src /opt/pet_api

WORKDIR /opt/pet_api
EXPOSE 8000

ENTRYPOINT ["gunicorn"]
CMD ["-c/opt/pet_api/gunicorn_settings.py", "pet_api.wsgi"]
