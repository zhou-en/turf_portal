from django.contrib import admin

from sales.models import Buyer, BuyerProduct, Order, OrderLine
from sales.forms import BuyerProductAdminForm


@admin.register(BuyerProduct)
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


@admin.register(Buyer)
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


@admin.register(OrderLine)
class OrderLineAdmin(admin.ModelAdmin):
    readonly_fields = ["total"]
    list_display = [
        "id",
        "order",
        "product",
        "roll",
        "quantity",
        "price",
        "total"
    ]
    search_fields = [
        "id",
        "order__buyer__name",
        "order__number",
        "order__status",
        "roll__id",
        "product__code"
    ]



@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "number",
        "buyer",
        "status",
        "closed_date",
        "created",
    ]

    search_fields = [
        "id",
        "buyer__name",
        "number",
        "status"
    ]

