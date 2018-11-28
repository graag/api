./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-req proxy nopass
./easyrsa sign-req server proxy
./easyrsa gen-crl
./easyrsa gen-dh

