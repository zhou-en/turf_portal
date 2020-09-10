from django.urls import path
from django.contrib.auth import views as auth_views

from sales.views import (
    BuyerListView,
    BuyerDetailView,
    BuyerUpdateView,
    BuyerDeleteView,
    BuyerCreateView,
    BuyerProductCreateView,
    BuyerProductDeleteView
)

urlpatterns = [
    path("buyers/", BuyerListView.as_view(), name="buyers"),
    path("buyer_create/", BuyerCreateView.as_view(), name="buyer-create"),
    path("buyer/<int:pk>/detail", BuyerDetailView.as_view(), name="buyer"),
    path("buyer/<int:pk>/update", BuyerUpdateView.as_view(), name="buyer-update"),
    path("buyer/<int:pk>/delete", BuyerDeleteView.as_view(), name="buyer-delete"),
    path("buyer/<int:pk>/product_create/", BuyerProductCreateView.as_view(), name="buyer-product-create"),
    path("buyer/<int:pk>/product_delete/", BuyerProductDeleteView.as_view(), name="buyer-product-delete"),
]
