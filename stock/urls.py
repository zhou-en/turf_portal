from django.urls import path

from stock.views import (
    ProductListView, ProductDetailView, ProductUpdateView, ProductDeleteView, ProductCreateView,
    WarehouseDetailView, WarehouseListView
)

urlpatterns = [
    path("products/", ProductListView.as_view(), name="products"),
    path("product_create/", ProductCreateView.as_view(), name="product-create"),
    path("product/<int:pk>/detail", ProductDetailView.as_view(), name="product"),
    path("product/<int:pk>/update", ProductUpdateView.as_view(), name="product-update"),
    path("product/<int:pk>/delete", ProductDeleteView.as_view(), name="product-delete"),
    path("warehouses/", WarehouseListView.as_view(), name="warehouses"),
    path("warehouse/<int:pk>/detail", WarehouseDetailView.as_view(), name="warehouse"),
]
