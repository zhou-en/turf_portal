from django.urls import path

from stock.views import (
    ProductListView, ProductDetailView, ProductUpdateView, ProductDeleteView, ProductCreateView,
    WarehouseDetailView, WarehouseListView, StockListView, LoadStocksView, SplitRollView
)

urlpatterns = [
    path("stocks/", StockListView.as_view(), name="stocks"),
    path("roll/<int:pk>/split", SplitRollView.as_view(), name="roll-split"),
    path("loadd_stocks/", LoadStocksView.as_view(), name="load-stocks"),
    path("products/", ProductListView.as_view(), name="products"),
    path("product_create/", ProductCreateView.as_view(), name="product-create"),
    path("product/<int:pk>/detail", ProductDetailView.as_view(), name="product"),
    path("product/<int:pk>/update", ProductUpdateView.as_view(), name="product-update"),
    path("product/<int:pk>/delete", ProductDeleteView.as_view(), name="product-delete"),
    path("warehouses/", WarehouseListView.as_view(), name="warehouses"),
    path("warehouse/<int:pk>/detail", WarehouseDetailView.as_view(), name="warehouse"),
]
