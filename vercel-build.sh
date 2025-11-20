#!/bin/bash
# Vercel build script

echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

echo "Build complete!"
