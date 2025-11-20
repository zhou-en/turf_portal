"""
WSGI config for turf_portal project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
from whitenoise import WhiteNoise

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'turf_portal.settings')

application = get_wsgi_application()
# Explicitly wrap with WhiteNoise to serve static files
# pointing to the 'staticfiles' directory at project root
application = WhiteNoise(application, root=os.path.join(os.path.dirname(os.path.dirname(__file__)), 'staticfiles'), prefix='static/')
app = application
