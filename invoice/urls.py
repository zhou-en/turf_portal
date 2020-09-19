from django.urls import path
from django.contrib.auth import views

from invoice.views import (
    InvoiceListView,
    InvoiceDetailView,
    PaymentCreateView
)

urlpatterns = [
    path("invoices/", InvoiceListView.as_view(), name="invoices"),
    path("invoice/<int:pk>/detail", InvoiceDetailView.as_view(), name="invoice"),
    # path("payment/<int:pk>/add/", PaymentCreateView.as_view(), name="payment-add"),
    path("payment_create/<int:pk>/", PaymentCreateView.as_view(), name="payment-create"),
]
