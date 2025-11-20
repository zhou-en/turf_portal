"""turf_portal URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse
import os
from accounts.views import DataView, home
from stock.views import StockDataView

def debug_files(request):
    output = []
    output.append(f"Current CWD: {os.getcwd()}")

    output.append("\nChecking for 'staticfiles' directory:")
    if os.path.exists("staticfiles"):
        output.append("FOUND 'staticfiles'")
        for root, dirs, files in os.walk("staticfiles"):
            for file in files:
                output.append(os.path.join(root, file))
    else:
        output.append("NOT FOUND 'staticfiles'")

    output.append("\nChecking for 'turf_portal/staticfiles_build' directory:")
    if os.path.exists("turf_portal/staticfiles_build"):
        output.append("FOUND 'turf_portal/staticfiles_build'")
        for root, dirs, files in os.walk("turf_portal/staticfiles_build"):
            for file in files:
                output.append(os.path.join(root, file))
    else:
        output.append("NOT FOUND 'turf_portal/staticfiles_build'")

    # Also check relative to current CWD if we are inside turf_portal
    output.append("\nChecking for 'staticfiles_build' (relative):")
    if os.path.exists("staticfiles_build"):
        output.append("FOUND 'staticfiles_build'")
        for root, dirs, files in os.walk("staticfiles_build"):
            for file in files:
                output.append(os.path.join(root, file))
    else:
        output.append("NOT FOUND 'staticfiles_build'")

    output.append("\nChecking for 'static' directory:")
    if os.path.exists("static"):
        output.append("FOUND 'static'")
        for root, dirs, files in os.walk("static"):
            for file in files:
                output.append(os.path.join(root, file))
    else:
        output.append("NOT FOUND 'static'")

    return HttpResponse("<pre>" + "\n".join(output) + "</pre>")

urlpatterns = [
    path('debug-files/', debug_files),
    path('', home, name='home'),
    path('admin/', admin.site.urls),
    path('sales/', include('sales.urls')),
    path('invoice/', include('invoice.urls')),
    path('expense/', include('expense.urls')),
    path('stock/', include('stock.urls')),
    path('accounts/', include('django.contrib.auth.urls')),
    path('api/chart/data/', DataView.as_view()),
    path('api/stock/data/', StockDataView.as_view()),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

admin.site.site_header = 'Turf Portal Admin Panel'
admin.site.site_title = 'Turf Portal Admin'

