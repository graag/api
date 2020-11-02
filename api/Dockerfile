FROM python:3.7

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.pip /
RUN pip install -r /requirements.pip

RUN mkdir /opt/pet_api
COPY ./src /opt/pet_api

WORKDIR /opt/pet_api

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
