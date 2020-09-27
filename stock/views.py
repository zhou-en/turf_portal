import logging
from django.urls import reverse_lazy
from django.db.models import Q
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView
from rest_framework.response import Response
from rest_framework.views import APIView

from stock.models import Product, TurfRoll, Warehouse, RollSpec
from stock.forms import ProductCreateForm, ProductUpdateForm, LoadStocksForm

logger = logging.getLogger(__name__)


# Create your views here.
@method_decorator(login_required, name='dispatch')
class ProductListView(ListView):
    model = Product
    template_name = "stock/products.html"
    context_object_name = 'products'
    queryset = Product.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(ProductListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class ProductCreateView(CreateView):
    model = Product
    template_name = 'stock/product_create.html'
    success_url = reverse_lazy('product')
    form_class = ProductCreateForm

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("products"))
        else:
            return super(ProductCreateView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name='dispatch')
class ProductDetailView(DetailView):
    model = Product
    template_name = 'stock/product.html'
    context_object_name = "product"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["available_rolls"] = TurfRoll.objects.filter(
            spec__id=self.object.spec_id
        ).filter(~Q(status=TurfRoll.Status.DEPLETED))

        return context


@method_decorator(login_required, name='dispatch')
class ProductUpdateView(UpdateView):
    model = Product
    template_name = 'stock/product_update.html'
    context_object_name = "product"
    form_class = ProductUpdateForm

    def get_success_url(self):
        return reverse_lazy('product', kwargs={'pk': self.object.id})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            return super(ProductUpdateView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name='dispatch')
class ProductDeleteView(DeleteView):
    model = Product
    template_name = 'stock/product_delete.html'
    success_url = reverse_lazy('products')

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("products"))
        else:
            return super(ProductDeleteView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name='dispatch')
class WarehouseDetailView(DetailView):
    model = Warehouse
    template_name = 'stock/warehouse.html'
    context_object_name = "warehouse"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["stored_rolls"] = TurfRoll.objects.filter(
            location_id=self.object.id
        ).filter(~Q(status=TurfRoll.Status.DEPLETED))

        return context


@method_decorator(login_required, name='dispatch')
class WarehouseListView(ListView):
    model = Warehouse
    template_name = "stock/warehouses.html"
    context_object_name = 'warehouses'
    queryset = Warehouse.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(WarehouseListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class StockDataView(APIView):
    """
    """
    authentication_classes = []
    permission_classes = []

    def get(self, request, format=None):
        labels = ["Available", "Sold", "Reserved"]
        data = {}
        for roll in TurfRoll.objects.exclude(status__exact=TurfRoll.Status.DEPLETED):
            code = roll.spec.code
            data.update({
                roll.id: {
                    "code": code,
                    "labels": labels,
                    "default": [roll.available, roll.sold, roll.reserved],
                }
            })
        return Response(data)


@method_decorator(login_required, name='dispatch')
class StockListView(ListView):
    model = TurfRoll
    template_name = "stock/stocks.html"
    context_object_name = 'turf_rolls'
    queryset = TurfRoll.objects.all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["turf_rolls"] = {}
        context["all_rolls"] = TurfRoll.objects.all().order_by("spec__product__code")
        specs = RollSpec.objects.all().order_by("product__code")
        for spec in specs:
            if spec.turfroll_set.exists():
                context["turf_rolls"].update(
                    {spec: [roll for roll in spec.turfroll_set.all()]}
                )
        return context


@method_decorator(login_required, name='dispatch')
class LoadStocksView(CreateView):
    model = TurfRoll
    template_name = "stock/load_stocks.html"
    success_url = reverse_lazy('stocks')
    context_object_name = 'turf_roll'
    form_class = LoadStocksForm

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("stocks"))
        else:
            logger.debug("Start loading stock ...")
            quantity = int(request.POST.get("quantity"))

            spec = RollSpec.objects.get(id=request.POST.get("spec"))
            location = Warehouse.objects.get(id=request.POST.get("location"))
            for n in range(int(quantity)):
                logger.info("Loading %s: %d", spec, n)
                TurfRoll.objects.create(
                    spec=spec,
                    location=location
                )
            logger.info(
                "%s %s rolls have been loaded to %s",
                quantity,
                spec,
                location
            )
        return HttpResponseRedirect(reverse_lazy("stocks"))


