from django.urls import path

from invoice.views import (
    InvoiceListView,
    InvoiceDetailView,
    PaymentCreateView,
    PaymentUpdateView,
    PaymentListView,
    confirm_payment,
    ExportPDFView
)

urlpatterns = [
    path("invoices/", InvoiceListView.as_view(), name="invoices"),
    path("payments/", PaymentListView.as_view(), name="payments"),
    path("invoice/<int:pk>/detail", InvoiceDetailView.as_view(), name="invoice"),
    path("confirm_payment/<int:pk>", confirm_payment, name="confirm-payment"),
    path("payment_create/<int:pk>/", PaymentCreateView.as_view(), name="payment-create"),
    path("payment_update/<int:pk>/", PaymentUpdateView.as_view(), name="payment-update"),
    path("invoice/<int:pk>/export", ExportPDFView.as_view(), name="invoice-export"),
]
