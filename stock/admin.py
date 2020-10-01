from django.contrib import admin

from stock.models import (
    Product, Category, Color, Width, Height, RollSpec, Warehouse, TurfRoll
)


# Register your models here.
@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    readonly_fields = ["code"]
    list_display = [
        "code",
        "has_stock"
    ]


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    pass


@admin.register(Color)
class ColorAdmin(admin.ModelAdmin):
    pass


@admin.register(Width)
class WidthAdmin(admin.ModelAdmin):
    # def get_model_perms(self, request):
    #     """
    #     Return empty perms dict thus hiding the model from admin index.
    #     """
    #     return {}
    pass


@admin.register(Height)
class HeightAdmin(admin.ModelAdmin):
    pass


@admin.register(TurfRoll)
class TurfRollAdmin(admin.ModelAdmin):
    ordering = ("-created",)
    list_display = [
        "id",
        "spec",
        "original_size",
        "total",
        "sold",
        "status",
        "location",
        "modified",
        "created"
    ]


@admin.register(RollSpec)
class RollSpecAdmin(admin.ModelAdmin):
    ordering = ["color", "height", "width"]
    list_display = [
        "category",
        "color",
        "height",
        "width",
        "length"
    ]


@admin.register(Warehouse)
class WarehouseAdmin(admin.ModelAdmin):
    ordering = ["name", "number"]
    list_display = [
        "name",
        "number",
        "address",
    ]

