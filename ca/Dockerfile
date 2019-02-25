FROM python:3.7

ENV EASYRSA_PKI=/opt/ca-data/pki
RUN mkdir /opt/proxy && \
    mkdir /opt/client && \
    mkdir /opt/pki

WORKDIR /opt

COPY ./easyrsa-src .
COPY ./ca-entrypoint.py .
ENTRYPOINT ["/bin/bash"]
