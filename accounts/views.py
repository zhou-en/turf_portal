from datetime import datetime, timedelta

from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import redirect, render
from django.urls import reverse_lazy
from django.utils import timezone
from rest_framework import authentication, permissions
from rest_framework.response import Response
from rest_framework.views import APIView

from sales.models import Buyer, Order, OrderLine
from stock.models import Product, RollSpec, TurfRoll

# User = get_user_model()


@login_required
def home(request):
    count = User.objects.count()
    # Option 2
    recent_orders = (
        Order.objects.exclude(status__exact=Order.Status.CLOSED)
        .filter(created__gt=timezone.now() - timedelta(7))
        .order_by("modified")
    )
    return render(
        request, "home.html", {"count": count, "recent_orders": recent_orders}
    )


@login_required
def secret_page(request):
    return render(request, "secret_page.html")


# Option 1
@login_required
def get_data(request):
    data = {"customers": 100}
    return JsonResponse(data)


# Option 3
class DataView(APIView):
    """"""

    authentication_classes = []
    permission_classes = []

    def generate_monthly_sales_data(self, start_date, end_date):
        monthly_sale = {}
        for s in (
            Order.objects.filter(status__exact=Order.Status.CLOSED)
            .filter(closed_date__range=[start_date, end_date])
            .order_by("closed_date")
        ):
            closed_date = s.closed_date.strftime("%Y-%m-%d")
            order_total = s.total_wt_discount
            closed_month = "-".join(closed_date.split("-")[:2])
            if closed_month in monthly_sale:
                monthly_sale[closed_month] += order_total
            else:
                monthly_sale.update({closed_month: order_total})

        sales_labels = monthly_sale.keys()
        sales_total = [monthly_sale[k] for i, k in enumerate(sales_labels)]
        return {"labels": sales_labels, "default": sales_total}

    def get(self, request, format=None):
        start_date = request.GET.get("start_date")
        end_date = request.GET.get("end_date")
        data = {}
        # Add one day to end_date so that it inclusive both start and end dates
        if end_date:
            end_date = (
                datetime.strptime(end_date, "%Y-%m-%d") + timedelta(days=1)
            ).strftime("%Y-%m-%d")

        if start_date == "2001-12-21":
            monthly_data = self.generate_monthly_sales_data(
                start_date, end_date
            )
            data.update({"monthly_data": monthly_data})

        stock_available_data = {}
        for roll in TurfRoll.objects.all():
            if roll.spec.code in stock_available_data:
                stock_available_data[roll.spec.code] += roll.available
            else:
                stock_available_data[roll.spec.code] = roll.available

        labels = sorted(stock_available_data.keys())
        default_items = [stock_available_data[k] for k in labels]
        data.update(
            {
                "stock_data": {
                    "labels": labels,
                    "default": default_items,
                }
            }
        )

        # Stock Sold from start_date to end_date
        stock_sold_data = {}
        for ol in OrderLine.objects.filter(
            order__closed_date__range=[start_date, end_date]
        ):
            if ol.product:
                if ol.product.code in stock_sold_data:
                    stock_sold_data[ol.product.code] += ol.quantity
                else:
                    stock_sold_data[ol.product.code] = ol.quantity
        labels = sorted(stock_sold_data.keys())
        default_items = [stock_sold_data[k] for k in labels]
        data.update(
            {
                "stock_sold_data": {
                    "labels": labels,
                    "default": default_items,
                }
            }
        )
        sales_data = {}
        for s in (
            Order.objects.filter(status__exact=Order.Status.CLOSED)
            .filter(closed_date__range=[start_date, end_date])
            .order_by("closed_date")
        ):
            closed_date = s.closed_date.strftime("%Y-%m-%d")
            order_total = s.total_wt_discount
            if closed_date in sales_data:
                sales_data[closed_date] += order_total
            else:
                sales_data.update({closed_date: order_total})

        sales_labels = sales_data.keys()
        sales_total = [sales_data[k] for i, k in enumerate(sales_labels)]
        data.update(
            {"sales_data": {"labels": sales_labels, "default": sales_total}}
        )

        # total turnonver per buyer
        buyer_data = {}
        for b in Buyer.objects.all():
            if b.history_total != 0:
                buyer_data.update({b.name: b.history_total})
        buyer_data = dict(
            sorted(buyer_data.items(), key=lambda item: item[1], reverse=True)
        )
        buyer_labels = buyer_data.keys()
        if len(buyer_labels) > 10:
            buyer_labels = sorted(list(buyer_data.keys())[:10])
        buyer_total = [buyer_data[k] for k in buyer_labels]
        data.update(
            {"buyer_data": {"labels": buyer_labels, "default": buyer_total}}
        )

        return Response(data)
