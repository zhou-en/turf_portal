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

from sales.models import Order
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
        labels = data_set.keys()
        default_items = [data_set[k] for k in labels]
        data = {
            "stock_data": {
                "labels": labels,
                "default": default_items,
            }
        }

        sales_data = {}
        for s in Order.objects.filter(
                status__exact=Order.Status.CLOSED
        ).order_by("closed_date"):
            sales_data.update(
                {s.closed_date.strftime("%Y-%m-%d"): s.total_amount}
            )
        sales_labels = sales_data.keys()
        sales_total = [sales_data[k] for k in sales_labels]
        data.update(
            {
                "sales_data": {
                    "labels": sales_labels,
                    "default": sales_total
                }
            }
        )
        return Response(data)
