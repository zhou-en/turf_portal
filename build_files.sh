sudo apt install wkhtmltopdf
pip install -r requirements.txt

# make migrations
python3.9 manage.py migrate 
python3.9 manage.py collectstatic
python3.9 manage.py createsuperuser --noinput
