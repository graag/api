#!/bin/bash
echo "Importing $1 file"
if [ ! -f $1 ]; then
    echo ".crt file not found"
    exit 1
fi

python3 crt_to_json.py $1 | \
docker exec -i api python3 manage.py shell --command \
"import json, sys; from rest.models import Entity;
from rest.serializers import AuthorizationSerializer;
data = json.loads(input());
data['entity']=Entity.objects.getEntity(data['common_name']).id;
data['subject']=data['common_name'];
ser = AuthorizationSerializer(data=data)
if not ser.is_valid():
    print(ser.errors);
    sys.exit(1);
ser.save();"
