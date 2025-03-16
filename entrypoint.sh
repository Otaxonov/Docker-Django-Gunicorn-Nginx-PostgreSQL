#!/bin/bash

echo "Running migrations..."
python manage.py makemigrations
python manage.py migrate

python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@example.com', 'admin')"

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting server..."
exec gunicorn --bind 0.0.0.0:8000 DFA.wsgi:application