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
from accounts.views import DataView, home
from stock.views import StockDataView


urlpatterns = [
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

