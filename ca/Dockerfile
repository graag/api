FROM python:3.7

COPY ./requirements.pip /
RUN pip install -r /requirements.pip && \
    rm /requirements.pip

RUN mkdir -p /opt/ca && \
    mkdir /opt/proxy
COPY ./src /opt/ca
WORKDIR /opt/ca

ENV EASYRSA_PKI=/opt/ca/pki

ENTRYPOINT ["/bin/bash"]
