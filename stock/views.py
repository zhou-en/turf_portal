from django.urls import reverse_lazy
from django.db.models import Q
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from stock.models import Product, TurfRoll, Warehouse
from stock.forms import ProductCreateForm, ProductUpdateForm


# Create your views here.
@method_decorator(login_required, name='dispatch')
class ProductListView(ListView):
    model = Product
    template_name = "stock/products.html"
    context_object_name = 'products'
    queryset = Product.objects.all()
    paginate_by = 10

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
    paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(WarehouseListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class StockListView(ListView):
    model = TurfRoll
    template_name = "stock/stocks.html"
    context_object_name = 'turf_rolls'
    queryset = TurfRoll.objects.exclude(status=TurfRoll.Status.DEPLETED)
    paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


