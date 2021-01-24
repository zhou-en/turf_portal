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
from stock.models import RollSpec, Product, TurfRoll

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
        stock_available_data = {}
        for roll in TurfRoll.objects.exclude(spec__category__name="Join Tape"):
            if roll.spec.code in stock_available_data:
                stock_available_data[roll.spec.code] += roll.available
            else:
                stock_available_data[roll.spec.code] = roll.available

        labels = sorted(stock_available_data.keys())
        default_items = [stock_available_data[k] for k in labels]
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
            closed_date = s.closed_date.strftime("%Y-%m-%d")
            order_total = s.total_wt_discount
            if closed_date in sales_data:
                sales_data[closed_date] += order_total
            else:
                sales_data.update({closed_date: order_total})

        sales_labels = sales_data.keys()
        if len(labels) > 30:
            sales_labels = sales_data.keys()[:30]
        sales_total = [sales_data[k] for i, k in enumerate(sales_labels)]
        data.update(
            {
                "sales_data": {
                    "labels": sales_labels,
                    "default": sales_total
                }
            }
        )

        # total stock sold
        stock_sold_data = {}
        for s in Order.objects.filter(
            status__exact=Order.Status.CLOSED
        ).order_by("closed_date"):
            closed_month = s.closed_date.strftime("%Y-%m")
            order_total = s.total_wt_discount
            if closed_month in stock_sold_data:
                stock_sold_data[closed_month] += order_total
            else:
                stock_sold_data.update({closed_month: order_total})

        stock_sold_labels = sorted(stock_sold_data.keys())
        if len(stock_sold_labels) > 12:
            sorted(stock_sold_data.keys()[:12])
        stock_sold_total = [stock_sold_data[k] for k in stock_sold_labels]
        data.update(
            {
                "stock_sold_data": {
                    "labels": stock_sold_labels,
                    "default": stock_sold_total
                }
            }
        )

        # total turnonver per buyer
        buyer_data = {}
        for b in Buyer.objects.all():
            buyer_data.update(
                {b.name: b.history_total}
            )
        buyer_data =dict(sorted(buyer_data.items(), key=lambda item: item[1],reverse=True))
        buyer_labels = buyer_data.keys()
        if len(buyer_labels) > 10:
            buyer_labels = sorted(buyer_data.keys()[:10])
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
