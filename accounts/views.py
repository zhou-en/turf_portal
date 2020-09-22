from django.urls import reverse_lazy
from datetime import timedelta
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import authentication, permissions
from django.contrib.auth.models import User

from sales.models import Order, Buyer, OrderLine
from stock.models import RollSpec, Product

# User = get_user_model()


@login_required
def home(request):
    count = User.objects.count()
    # Option 2
    recent_orders = Order.objects.exclude(
        status__exact=Order.Status.CLOSED
    ).filter(created__gt=timezone.now()-timedelta(7)).order_by("modified")
    return render(request, "home.html", {
        "count": count,
        "recent_orders": recent_orders
    })


@login_required
def secret_page(request):
    return render(request, 'secret_page.html')


# Option 1
@login_required
def get_data(request):
    data = {
        "customers": 100
    }
    return JsonResponse(data)


# Option 3
class DataView(APIView):
    """
    """
    authentication_classes = []
    permission_classes = []

    def get(self, request, format=None):
        data_set = {}
        for p in Product.objects.all():
            data_set.update(
                {p.code: p.stock_count}
            )
        labels = sorted(data_set.keys())
        default_items = [data_set[k] for k in labels]
        data = {
            "stock_data": {
                "labels": labels,
                "default": default_items,
            }
        }

        sales_data = {}
        today = timezone.now().date()
        for s in Order.objects.filter(
                status__exact=Order.Status.CLOSED
        ).order_by("closed_date"):
            sales_data.update(
                {s.closed_date.strftime("%Y-%m-%d %H:%m:%s"): s.total_amount}
            )
        sales_labels = sales_data.keys()
        sales_total = []
        for i, k in enumerate(sales_labels):
            if i == 0:
                sales_total.append(sales_data[k])
            else:
                previous_total = sales_total[i-1]
                sales_total.append(previous_total + sales_data[k])

        data.update(
            {
                "sales_data": {
                    "labels": sales_labels,
                    "default": sales_total
                }
            }
        )

        # total turnover per product
        product_data = {}
        for p in Product.objects.all():
            product_data.update(
                {p.code: 0.0}
            )
        for ol in OrderLine.objects.all():
            if ol.order.status == Order.Status.CLOSED:
                pcode = ol.buyer_product.product.code
                ptotal = ol.price
                if pcode in product_data:
                    product_data[pcode] += ptotal
                else:
                    product_data.update(
                        {pcode: float(ptotal)}
                    )
        product_labels = sorted(product_data.keys())
        product_total = [product_data[k] for k in product_labels]
        data.update(
            {
                "product_data": {
                    "labels": product_labels,
                    "default": product_total
                }
            }
        )

        # total turnonver per buyer
        buyer_data = {}
        for b in Buyer.objects.all():
            buyer_data.update(
                {b.name: b.history_total}
            )
        buyer_labels = sorted(buyer_data.keys())
        buyer_total = [buyer_data[k] for k in buyer_labels]
        data.update(
            {
                "buyer_data": {
                    "labels": buyer_labels,
                    "default": buyer_total
                }
            }
        )

        return Response(data)
