FROM python:3.7

WORKDIR /opt
RUN git clone --branch v3.0.6 https://github.com/OpenVPN/easy-rsa.git && \
    mkdir /opt/proxy && \
    mkdir /opt/client && \
    mkdir /opt/pki

ENV EASYRSA_PKI=/opt/ca-data/pki
ENV PATH=$PATH:/opt/easy-rsa/easyrsa3

COPY ./entrypoint.sh .
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
