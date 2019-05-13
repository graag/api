python3 manage.py migrate

if [ $? -ne 0 ]; then
    echo "Migration failed, is DB up and running?"
    exit 1
fi

echo "Creating superuser."
cat <<EOF | python manage.py shell
from django.contrib.auth.models import User
from django.db.utils import IntegrityError

try:
    User.objects.create_superuser('$ADMIN_USER', '$ADMIN_MAIL', '$ADMIN_PASSWORD')
    print('Superuser created.')
except IntegrityError:
    print('Superuser already present in db.')
EOF

echo "Updating static files."
python3 manage.py collectstatic --no-input

echo "Running gunicorn server."
gunicorn -c /opt/pet_api/gunicorn_settings.py pet_api.wsgi
