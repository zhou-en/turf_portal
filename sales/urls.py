from django.urls import path
from django.contrib.auth import views

from sales.views import (
    BuyerListView,
    BuyerDetailView,
    BuyerUpdateView,
    BuyerDeleteView,
    BuyerCreateView,
    BuyerProductCreateView,
    BuyerProductDeleteView,
    OrderListView,
    OrderDetailView,
    OrderCreateView,
    OrderAddItemView,
    OrderItemDeleteView,
    OrderItemUpdateView,
    submit_order,
    send_invoice,
    deliver
)

urlpatterns = [
    path("buyers/", BuyerListView.as_view(), name="buyers"),
    path("buyer_create/", BuyerCreateView.as_view(), name="buyer-create"),
    path("buyer/<int:pk>/detail", BuyerDetailView.as_view(), name="buyer"),
    path("buyer/<int:pk>/update", BuyerUpdateView.as_view(), name="buyer-update"),
    path("buyer/<int:pk>/delete", BuyerDeleteView.as_view(), name="buyer-delete"),
    path("buyer/<int:pk>/product_create/", BuyerProductCreateView.as_view(), name="buyer-product-create"),
    path("buyer/<int:pk>/product_delete/", BuyerProductDeleteView.as_view(), name="buyer-product-delete"),
    path("order/<int:pk>/detail", OrderDetailView.as_view(), name="order"),
    path("orders/", OrderListView.as_view(), name="orders"),
    path("order_create/", OrderCreateView.as_view(), name="order-create"),
    path("order/<int:pk>/add_item/", OrderAddItemView.as_view(), name="order-add-item"),
    path("order_item/<int:pk>/delete/", OrderItemDeleteView.as_view(), name="order-item-delete"),
    path("order_item/<int:pk>/update/", OrderItemUpdateView.as_view(), name="order-item-update"),
    path("order/<int:pk>/submit/", submit_order, name="order-submit"),
    path("order/<int:pk>/invoice/", send_invoice, name="order-send-invoice"),
    path("order/<int:pk>/deliver/", deliver, name="order-deliver"),
]
