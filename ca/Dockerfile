FROM python:3.7

WORKDIR /opt
COPY ./requirements.pip .

RUN git clone --branch v3.0.6 https://github.com/OpenVPN/easy-rsa.git && \
    mkdir /opt/proxy && \
    mkdir /opt/client && \
    mkdir /opt/pki && \
    python3 -m pip install -r requirements.pip

ENV EASYRSA_PKI=/opt/ca-data/pki
ENV PATH=$PATH:/opt/easy-rsa/easyrsa3

COPY ./crt_to_json.py .
COPY ./entrypoint.sh .

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
