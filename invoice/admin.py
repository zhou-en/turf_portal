from django.contrib import admin

from invoice.models import Invoice, Payment


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = [
        "number",
        "status",
        "order",
        "buyer",
        "closed_date",
        "modified",
        "created",
    ]

    list_filter = [
        "order",
        "buyer",
        "number",
    ]

    search_fields = [
        "buyer__name",
        "number",
        "order__number",
        "status"
    ]


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = [
        "invoice",
        "method",
        "amount",
    ]

    search_fields = [
        "amount",
        "method",
        "invoice__number",
        "status"
    ]

