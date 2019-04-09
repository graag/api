import json
import argparse

from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.x509.oid import NameOID

parser = argparse.ArgumentParser(
    description=('Read .crt file, convert data to json format and '
                 'save in specified file.')
)
parser.add_argument('src', type=str, help='Source certificate.')
args = parser.parse_args()

with open(args.src, 'rb') as fd:
    data = fd.read()

cert = x509.load_pem_x509_certificate(data, default_backend())
names = cert.subject.get_attributes_for_oid(NameOID.COMMON_NAME)

import_data = {
    'common_name': names[0].value,
    'fingerprint': cert.fingerprint(hashes.SHA256()).hex(),
    'start_date': cert.not_valid_before.isoformat(),
    'expiry_date': cert.not_valid_after.isoformat()
}

json_data = json.dumps(import_data)
print(json_data)
