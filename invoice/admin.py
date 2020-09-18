from django.contrib import admin

from invoice.models import Invoice, Payment


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = [
        "number",
        "status",
        "order",
        "buyer",
        "created",
    ]

    list_filter = [
        "order",
        "buyer",
        "number",
    ]

    search_fields = [
        "buyer",
        "number",
        "order",
    ]


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = [
        "invoice",
        "method",
        "amount",
    ]
