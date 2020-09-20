from django.contrib import admin

from stock.models import (
    Product, Category, Color, Width, Height, RollSpec, Warehouse, TurfRoll
)


# Register your models here.
@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    readonly_fields = ["code"]
    list_display = [
        # "get_category",
        # "get_color",
        # "get_height",
        # "get_width",
        "code",
    ]
    # list_filter = (
    #     "spec__category",
    #     "spec__color",
    #     "spec__height",
    #     "spec__width",
    #     "code",
    # )
    # search_fields = (
    #     "spec__category",
    #     "spec__color",
    #     "spec__height",
    #     "spec__width",
    #     "code",
    # )

    # def get_category(self, obj):
    #     return obj.spec.category
    #
    # def get_color(self, obj):
    #     return obj.spec.color
    #
    # def get_height(self, obj):
    #     return obj.spec.height
    #
    # def get_width(self, obj):
    #     return obj.spec.width

    # get_category.short_description = 'Category'
    # get_category.admin_order_field = 'spec__category'
    # get_color.short_description = 'Color'
    # get_color.admin_order_field = 'spec__color'
    # get_height.short_description = 'Height'
    # get_height.admin_order_field = 'spec__height'
    # get_width.short_description = 'Width'
    # get_width.admin_order_field = 'spec__width'


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


@admin.register(Color)
class ColorAdmin(admin.ModelAdmin):
    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


@admin.register(Width)
class WidthAdmin(admin.ModelAdmin):
    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


@admin.register(Height)
class HeightAdmin(admin.ModelAdmin):
    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


@admin.register(TurfRoll)
class TurfRollAdmin(admin.ModelAdmin):
    ordering = ("-created",)
    list_display = [
        "id",
        "spec",
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

    def get_model_perms(self, request):
        """
        Return empty perms dict thus hiding the model from admin index.
        """
        return {}


@admin.register(Warehouse)
class WarehouseAdmin(admin.ModelAdmin):
    ordering = ["name", "number"]
    list_display = [
        "name",
        "number",
        "address",
    ]

