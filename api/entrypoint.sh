if [ ! -f ./.migrated ]; then
    # migrating db first run
    python3 manage.py makemigrations rest
    python3 manage.py migrate

    #create superuser
    python3 manage.py shell --command \
"from django.contrib.auth.models import User;
User.objects.create_superuser('admin',
'$ADMIN_EMAIL', '$ADMIN_PASSWORD')"
    touch .migrated
else
    echo "api already initialized, applying migrations"
    python3 manage.py migrate
fi
echo "running gunicorn server"
gunicorn -c /opt/pet_api/gunicorn_settings.py pet_api.wsgi
