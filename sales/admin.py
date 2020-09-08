from django.contrib import admin

from sales.models import Buyer


# Register your models here.
class BuyerAdmin(admin.ModelAdmin):
    list_display = [
        "name",
        "buyer_type",
        "contact_person",
        "mobile",
        "email",
        "address"
    ]
    list_filter = (
        "name",
        "buyer_type",
        "contact_person",
        "mobile",
        "email",
        "address"
    )
    search_fields = (
        "name",
        "buyer_type",
        "contact_person",
        "mobile",
        "email",
        "address"
    )


admin.site.register(Buyer, BuyerAdmin)
