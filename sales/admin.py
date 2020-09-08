from django.contrib import admin

from sales.models import Buyer, BuyerProduct
from sales.forms import BuyerProductAdminForm


class BuyerProductAdmin(admin.ModelAdmin):
    list_display = [
        "buyer",
        "product",
        "price",
    ]

    list_filter = [
        "buyer",
        "product",
        "price",
    ]

    search_fields = [
        "buyer",
        "product",
        "price",
    ]

    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


admin.site.register(BuyerProduct, BuyerProductAdmin)


class BuyerProductInline(admin.TabularInline):
    model = BuyerProduct
    # form = ComponentAdminForm
    # formset = ComponentInlineFormset
    extra = 1
    fields = [
        "buyer",
        "product",
        "price",
    ]


# Register your models here.
class BuyerAdmin(admin.ModelAdmin):
    inlines = [
        BuyerProductInline
    ]
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
