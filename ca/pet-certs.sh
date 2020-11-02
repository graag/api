#!/bin/bash

function usage() {
    echo "test"
}

ROOT="/source/pki"
CA_CERT="$ROOT/ca.crt"
CERT="$ROOT/issued"
KEY="$ROOT/private"
CRL="$ROOT/crl.pem"
DH="$ROOT/dh.pem"

function run {
    docker-compose run --rm ca "$@"
}

function copy {
    # $1 copy destination
    # $2... file locations
    destination=$1
    if [ ! -d "$destination" ]; then
        echo "$destination does not exist."
        exit 1
    fi
    echo "Copying files to $destination"

    shift
    container_id=$(docker run -d -v ca-data:/source python:3.7)
    echo "Started container: $container_id"
    for source_file in "$@"
    do
        echo "Copying $source_file"
        docker cp $container_id:$source_file $destination
    done
    docker rm -f $container_id
}

function gen { # type common_name filename
    type=$1
    common_name=$2
    filename=$3

    echo "Generating $type certificate: $common_name"
    run --req-cn=${common_name} --batch gen-req $filename nopass
    echo "Signing $type certificate: $filename"
    run --req-cn=${common_name} sign-req $type $filename

}

function gen-client { # common_name directory
    common_name=$1
    directory=$2
    echo "Client common_name: $common_name"
    echo "Output directory: $directory"

    filename="$common_name"_$(date +%Y%m%d_%H%M%S)
    echo "Request file: $filename"

    gen client $common_name $filename
    run export-p12 $filename
    if [ ! -z $directory ]; then
        echo "Path specified, copying files to $directory"
        copy-client $directory $filename
    fi
}

function copy-client {
    directory=$1
    filename=$2
    copy $directory "$KEY/$filename.key" "$CERT/$filename.crt" "$CA_CERT" "$KEY/$filename.p12"
    echo "Generating json for $filename"
    gen-json $filename > "$directory/$filename.json"
}

function gen-proxy {
    common_name=$1
    directory=$2
    echo "Proxy common_name: $common_name"
    echo "Output directory: $directory"

    filename="$common_name"_$(date +%Y%m%d_%H%M%S)
    echo "Request file: $filename"

    gen server $common_name $filename

    if [ ! -z $directory ]; then
        echo "Path specified, copying files to $directory"
        copy-proxy $directory $filename
    fi
}

function copy-proxy {
    directory=$1
    filename=$2
    copy $directory "$KEY/$filename.key" "$CERT/$filename.crt" "$CRL" "$DH" "$CA_CERT"
    ln "$directory/$filename.key" "$directory/proxy.key"
    ln "$directory/$filename.crt" "$directory/proxy.crt"
}

function gen-json {
    request=$1
    docker-compose run --rm --entrypoint "python3" ca ./crt_to_json.py "/opt/ca-data/pki/issued/$request.crt"
}

function refresh-crl {
    run gen-crl
}

function revoke {
    request=$1
    run revoke $request
    refresh-crl
}

function get-crl {
    destination=$1
    refresh-crl
    copy $destination "$CRL"
}

option=$1
shift

case "$option" in
    gen-client) gen-client $@;;
    gen-proxy) gen-proxy $@;;
    revoke) revoke $@;;
    get-crl) get-crl $@;;
    copy-ca-cert) copy $1 $CA_CERT;;
    gen-json) gen-json $@;;
    status) run "help";;
    init) run "help";;
    copy) copy $@;;
    pass) shift; echo "$@";;
    help) usage;;
esac
