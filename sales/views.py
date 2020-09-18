import logging
import json
from django.utils.translation import gettext_lazy as _
from django.urls import reverse_lazy
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView
from django import views
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from stock.models import Product
from sales.models import Buyer, BuyerProduct, Order, OrderLine, TurfRoll
from sales.forms import (
    BuyerCreateForm,
    BuyerUpdateForm,
    BuyerProductCreateForm,
    OrderCreateForm,
    OrderAddItemForm,
    OrderItemUpdateForm
)

logger = logging.getLogger(__name__)


# Create your views here.
class BuyerListView(ListView):
    model = Buyer
    template_name = "sales/buyers.html"
    context_object_name = 'buyers'
    queryset = Buyer.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(BuyerListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class BuyerCreateView(CreateView):
    model = Buyer
    template_name = 'sales/buyer_create.html'
    success_url = reverse_lazy('buyers')
    form_class = BuyerCreateForm

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            return super(BuyerCreateView, self).post(request, *args, **kwargs)

    def get_success_url(self):
        return reverse_lazy('buyer', kwargs={'pk': self.object.id})


@method_decorator(login_required, name='dispatch')
class BuyerDetailView(DetailView):
    model = Buyer
    template_name = 'sales/buyer.html'
    context_object_name = "buyer"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer_products"] = [
            bp for bp in self.object.buyerproduct_set.all()
        ]
        return context


@method_decorator(login_required, name='dispatch')
class BuyerUpdateView(UpdateView):
    model = Buyer
    template_name = 'sales/buyer_update.html'
    context_object_name = "buyer"
    form_class = BuyerUpdateForm

    def get_success_url(self):
        return reverse_lazy('buyer', kwargs={'pk': self.object.id})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            return super(BuyerUpdateView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name='dispatch')
class BuyerDeleteView(DeleteView):
    model = Buyer
    template_name = 'sales/buyer_delete.html'
    success_url = reverse_lazy('buyers')

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            buyer = Buyer.objects.get(id=self.kwargs.get("pk"))
            for bp in buyer.buyerproduct_set.all():
                bp.delete()
            return super(BuyerDeleteView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name='dispatch')
class BuyerProductCreateView(CreateView):
    model = BuyerProduct
    form_class = BuyerProductCreateForm
    template_name = 'sales/buyer_product_create.html'

    def get_form(self, form_class=None):
        form = super().get_form()
        buyer_id = self.kwargs.get("pk")
        buyer = Buyer.objects.get(id=buyer_id)
        form.fields['buyer'].choices = [(buyer.name, buyer.name)]
        buyer_product_choices = []
        existing_bp_ids = [bp.product.id for bp in buyer.buyerproduct_set.all()]
        for product in Product.objects.exclude(id__in=existing_bp_ids):
            buyer_product_choices.extend(
                [(product.code, _(product.code))]
            )
        form.fields['product'].choices = buyer_product_choices
        return form

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            # Create BuyerProducts
            price = request.POST.get("price")
            try:
                price = float(price)
            except Exception as err:
                raise Exception("Invalid price!")
            product_code = request.POST.get("product")
            BuyerProduct.objects.create(
                price=price,
                product=Product.objects.get(code=product_code),
                buyer=Buyer.objects.get(id=self.kwargs.get("pk"))
            )
            return HttpResponseRedirect(reverse_lazy("buyer", kwargs={"pk": self.kwargs.get("pk")}))

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer_id"] = self.kwargs.get("pk")
        return context

    def form_valid(self, form):
        return super().form_valid(form)


@method_decorator(login_required, name='dispatch')
class BuyerProductDeleteView(DeleteView):
    model = BuyerProduct
    context_object_name = "buyer_product"
    template_name = 'sales/buyer_product_delete.html'

    def get_success_url(self):
        return reverse_lazy('buyer', kwargs={'pk': self.object.buyer_id})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            buyer_product = BuyerProduct.objects.get(id=self.kwargs.get("pk"))
            return HttpResponseRedirect(reverse_lazy("buyer", kwargs={'pk': buyer_product.buyer_id}))
        else:
            return super(BuyerProductDeleteView, self).post(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        context["buyer"] = self.object.buyer
        return context


@method_decorator(login_required, name='dispatch')
class OrderDetailView(DetailView):
    model = Order
    template_name = 'sales/order.html'
    context_object_name = "order"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class OrderListView(ListView):
    model = Order
    template_name = "sales/orders.html"
    context_object_name = 'orders'
    queryset = Order.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(OrderListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class OrderCreateView(CreateView):
    model = Order
    context_object_name = "order"
    template_name = 'sales/order_create.html'
    form_class = OrderCreateForm

    def get_form(self, form_class=None):
        form = super().get_form()
        buyers = Buyer.objects.all()
        return form

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("orders"))
        else:
            return super(OrderCreateView, self).post(request, *args, **kwargs)

    def get_success_url(self):
        # return reverse_lazy('orders')
        new_order = Order.objects.order_by('-id').first()
        return reverse_lazy('order', kwargs={'pk': new_order.id})

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer_products"] = BuyerProduct.objects.all()
        context["buyers"] = Buyer.objects.all()
        if "create" in self.request.path:
            context["create"] = True
        return context

    def form_valid(self, form):
        return super().form_valid(form)

    def form_invalid(self, form):
        return super().form_invalid(form)


@method_decorator(login_required, name='dispatch')
class OrderAddItemView(CreateView):
    model = Order
    template_name = "sales/order_add_item.html"
    # context_object_name = 'buyer_products'
    form_class = OrderAddItemForm
    # paginate_by = 10

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("orders"))
        else:
            # Get roll ids
            requested_roll_info = []
            if request.POST and request.POST.get("selected_items"):
                requested_roll_info = json.loads(
                    request.POST.get("selected_items")
                )
            # Create order lines
            order = Order.objects.get(id=self.kwargs.get("pk"))
            order.create_orderlines(requested_roll_info)
            return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": self.kwargs.get("pk")}))

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        order = Order.objects.get(id=self.kwargs.get("pk"))
        buyer = order.buyer
        buyer_products = BuyerProduct.objects.filter(buyer=buyer)
        context.update(
            {
                "buyer_products": buyer_products,
                "order": order,
                "buyer": buyer
            }
        )
        return context

    def form_valid(self, form):
        return super().form_valid(form)


@method_decorator(login_required, name='dispatch')
class OrderItemDeleteView(DeleteView):
    model = OrderLine
    template_name = 'sales/orderline_delete.html'

    def get_success_url(self):
        # return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": self.order_id}))
        return HttpResponseRedirect(reverse_lazy("orders"))

    def form_valid(self, form):
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        self.order_id = OrderLine.objects.get(id=kwargs.get("pk")).order_id
        OrderLine.objects.get(id=kwargs.get("pk")).delete()
        return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": self.order_id}))

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class OrderItemUpdateView(UpdateView):
    model = OrderLine
    template_name = 'sales/orderline_update.html'
    context_object_name = "orderline"
    form_class = OrderItemUpdateForm

    def get_success_url(self):
        order_id = OrderLine.objects.get(id=self.kwargs.get("pk")).order_id
        return reverse_lazy('order', kwargs={'pk': order_id})

    def post(self, request, *args, **kwargs):
        order_id = OrderLine.objects.get(id=self.kwargs.get("pk")).order_id
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": order_id}))
        else:
            return super(OrderItemUpdateView, self).post(request, *args, **kwargs)


# @method_decorator(login_required, name='dispatch')
# class OrderSubmitView(views.View):
#
#     # def get_success_url(self):
#     #     order_id = OrderLine.objects.get(id=self.kwargs.get("pk")).order_id
#     #     return reverse_lazy('order', kwargs={'pk': order_id})
#
#     def post(self, request, *args, **kwargs):
#         order_id = kwargs.get("pk")
#         order = Order.objects.get(id=order_id)
#         order.submit()
#         # return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": order_id}))
#         return HttpResponseRedirect(reverse_lazy("orders"))


@login_required
def submit_order(request, pk):
    order = Order.objects.get(id=pk)
    order.submit()
    return HttpResponseRedirect(reverse_lazy("orders"))


@login_required
def send_invoice(request, pk):
    order = Order.objects.get(id=pk)
    order.send_invoice()
    return HttpResponseRedirect(reverse_lazy("orders"))


@login_required
def deliver(request, pk):
    order = Order.objects.get(id=pk)
    order.deliver()
    return HttpResponseRedirect(reverse_lazy("orders"))
