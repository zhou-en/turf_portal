from django.contrib import admin

from stock.models import Product, Category, Color, Width, Height


# Register your models here.
@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    readonly_fields = ["code"]
    list_display = [
        "category",
        "color",
        "height",
        "width",
        "code",
    ]
    list_filter = (
        "category",
        "color",
        "height",
        "width",
        "code",
    )
    search_fields = (
        "category",
        "color",
        "height",
        "width",
        "code",
    )


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
