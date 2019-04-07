if [ ! -f ./ca-data/.initialized ]; then
    for command in init-pki build-ca gen-crl gen-dh
    do
        easyrsa $command
    done
    touch ./ca-data/.initialized
    echo "ca initialized"
else
    echo "ca already initialized"
fi
easyrsa "$@" # pass all args to easyrsa
