FROM python:3.7

ENV EASYRSA_PKI=/opt/ca-data/pki
RUN mkdir -p /opt/ca && \
    mkdir /opt/proxy && \
    mkdir /opt/client && \
    mkdir /opt/pki

WORKDIR /opt

COPY ./easyrsa-src ./ca

ENTRYPOINT ["/bin/bash"]
