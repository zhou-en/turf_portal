set -e

echo "Installing dependencies..."
python3.9 -m pip install -r requirements.txt

echo "Running migrations..."
python3.9 manage.py makemigrations
python3.9 manage.py migrate

echo "Collecting static files..."
python3.9 manage.py collectstatic --noinput --clear

# python3.9 manage.py createsuperuser --noinput
