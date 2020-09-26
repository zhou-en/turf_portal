from django.urls import path
from django.contrib.auth import views

from sales.views import (
    BuyerListView,
    BuyerDetailView,
    BuyerUpdateView,
    BuyerDeleteView,
    BuyerCreateView,
    BuyerProductCreateView,
    BuyerProductUpdateView,
    BuyerProductDeleteView,
    BuyerOrderCreateView,
    FilteredOrderListView,
    OrderListView,
    OrderDetailView,
    OrderCreateView,
    OrderAddItemView,
    OrderItemDeleteView,
    OrderItemUpdateView,
    submit_order,
    send_invoice_email,
    deliver,
    InvoiceOrderView
)

urlpatterns = [
    path("buyers/", BuyerListView.as_view(), name="buyers"),
    path("buyer_create/", BuyerCreateView.as_view(), name="buyer-create"),
    path("buyer/<int:pk>/detail", BuyerDetailView.as_view(), name="buyer"),
    path("buyer/<int:pk>/update", BuyerUpdateView.as_view(), name="buyer-update"),
    path("buyer/<int:pk>/delete", BuyerDeleteView.as_view(), name="buyer-delete"),
    path("buyer/<int:pk>/product_create/", BuyerProductCreateView.as_view(), name="buyer-product-create"),
    path("buyer_product/<int:pk>/update/", BuyerProductUpdateView.as_view(), name="buyer-product-update"),
    path("buyer_product/<int:pk>/delete/", BuyerProductDeleteView.as_view(), name="buyer-product-delete"),
    path("order/<int:pk>/detail", OrderDetailView.as_view(), name="order"),
    path("orders/", OrderListView.as_view(), name="orders"),
    path("closed_orders/<int:pk>/", FilteredOrderListView.as_view(), name="closed-orders"),
    path("reserved_orders/<int:pk>/", FilteredOrderListView.as_view(), name="reserved-orders"),
    path("order_create/", OrderCreateView.as_view(), name="order-create"),
    path("buyer/<int:pk>/order_create/", BuyerOrderCreateView.as_view(), name="buyer-order-create"),
    path("order/<int:pk>/add_item/", OrderAddItemView.as_view(), name="order-add-item"),
    path("order_item/<int:pk>/delete/", OrderItemDeleteView.as_view(), name="order-item-delete"),
    path("order_item/<int:pk>/update/", OrderItemUpdateView.as_view(), name="order-item-update"),
    path("order/<int:pk>/submit/", submit_order, name="order-submit"),
    path("order/<int:pk>/invoice/", InvoiceOrderView.as_view(), name="invoice-order"),
    path("order/<int:pk>/send_invoice_email/", send_invoice_email, name="send-invoice-email"),
    path("order/<int:pk>/deliver/", deliver, name="order-deliver"),
]
