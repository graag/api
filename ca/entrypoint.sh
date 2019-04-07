if [ ! -f ./ca-data/.initialized ]; then
    easyrsa init-pki
    easyrsa build-ca
    touch ./ca-data/.initialized
    echo "ca initialized"
else
    echo "ca already initialized"
fi
easyrsa "$@" # pass all args to easyrsa
