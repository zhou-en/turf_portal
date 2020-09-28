import logging
import json
from django.conf import settings
from django.contrib import messages
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.utils.translation import gettext_lazy as _
from django.urls import reverse_lazy
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView

from stock.models import Product
from sales.models import Buyer, BuyerProduct, Order, OrderLine, TurfRoll
from sales.forms import (
    BuyerCreateForm,
    BuyerUpdateForm,
    BuyerProductCreateForm,
    BuyerProductUpdateForm,
    BuyerOrderCreateForm,
    OrderCreateForm,
    OrderAddItemForm,
    OrderItemUpdateForm,
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
        context["buyer_orders"] = self.object.order_set.all()
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
        existing_bp_codes = [bp.product.id for bp in buyer.buyerproduct_set.all()]
        for product in Product.objects.exclude(id__in=existing_bp_codes).exclude(has_stock=False):
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
class BuyerProductUpdateView(UpdateView):
    model = BuyerProduct
    template_name = 'sales/buyer_product_update.html'
    context_object_name = "buyer_product"
    form_class = BuyerProductUpdateForm

    def get_success_url(self):
        buyer_product_pk = self.kwargs.get("pk")
        buyer_product = BuyerProduct.objects.get(id=buyer_product_pk)
        return reverse_lazy('buyer', kwargs={'pk': buyer_product.buyer_id})

    def post(self, request, *args, **kwargs):
        buyer_product_pk = kwargs.get("pk")
        buyer_product = BuyerProduct.objects.get(id=buyer_product_pk)
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyer", kwargs={"pk": buyer_product.buyer_id}))
        else:
            return super(BuyerProductUpdateView, self).post(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer"] = self.object.buyer
        return context


@method_decorator(login_required, name='dispatch')
class BuyerProductDeleteView(DeleteView):
    model = BuyerProduct
    context_object_name = "buyer_product"
    template_name = 'sales/buyer_product_delete.html'

    def get_success_url(self):
        return reverse_lazy('buyer', kwargs={'pk': self.object.buyer_id})

    def post(self, request, *args, **kwargs):
        buyer_product = BuyerProduct.objects.get(id=self.kwargs.get("pk"))
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyer", kwargs={'pk': buyer_product.buyer_id}))
        else:
            if buyer_product.buyer.has_open_orders:
                messages.error(
                    request,
                    f'Failed to remove {buyer_product.product.code} from buyer '
                    f'{buyer_product.buyer.name} who has open orders!'
                )
                return HttpResponseRedirect(reverse_lazy("buyer", kwargs={'pk': buyer_product.buyer_id}))
            else:
                for orderline in OrderLine.objects.filter(buyer_product=buyer_product):
                    orderline.buyer_product = None
                    orderline.save()
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
        context["invoice"] = self.object.invoice_set.first()
        return context


@method_decorator(login_required, name='dispatch')
class FilteredOrderListView(ListView):
    model = OrderLine
    template_name = "sales/filtered_orders.html"
    context_object_name = 'orders'
    # queryset = Order.objects.all().order_by("buyer")
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(FilteredOrderListView, self).get_context_data(**kwargs)
        roll_id = self.kwargs.get("pk")
        roll = TurfRoll.objects.get(id=roll_id)
        context["roll"] = roll
        if "reserved_orders" in self.request.path:
            context["orderlines"] = OrderLine.objects.filter(
                roll=roll,
                order__status__in=[
                    Order.Status.SUBMITTED,
                    Order.Status.INVOICED,
                    Order.Status.DELIVERED,
                ]
            )
            context["filter"] = {"name": "Reserved", "result": roll.reserved}
        if "closed_orders" in self.request.path:
            context["orderlines"] = OrderLine.objects.filter(
                roll=roll,
                order__status__in=[
                    Order.Status.CLOSED,
                ]
            )
            context["filter"] = {"name": "Sold", "result": roll.sold}
        return context


@method_decorator(login_required, name='dispatch')
class OrderListView(ListView):
    model = Order
    template_name = "sales/orders.html"
    context_object_name = 'orders'
    queryset = Order.objects.all().order_by("buyer")
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(OrderListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name="dispatch")
class BuyerOrderCreateView(CreateView):
    model = Order
    context_object_name = "order"
    template_name = 'sales/buyer_order_create.html'
    form_class = BuyerOrderCreateForm

    def dispatch(self, request, *args, **kwargs):
        # Create an order with the given buyer id
        order = Order.objects.create(
            buyer_id=kwargs.get("pk")
        )
        return HttpResponseRedirect(reverse_lazy("order", kwargs={"pk": order.id}))


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
        new_order = Order.objects.order_by('-id').first()
        return reverse_lazy('order', kwargs={'pk': new_order.id})

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer_products"] = BuyerProduct.objects.all()
        context["buyers"] = Buyer.objects.all()
        if "create" in self.request.path:
            context["create"] = True
        return context


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
        ordered_products = [ol.buyer_product.product.code for ol in order.orderline_set.all()]
        context.update(
            {
                "buyer_products": buyer_products,
                "order": order,
                "buyer": buyer,
                "ordered_product": ordered_products
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
        return HttpResponseRedirect(reverse_lazy("orders"))

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
def send_invoice_email(request, pk):
    from django.core.mail import send_mail
    order = Order.objects.get(id=pk)
    subject = f"Invoice for {order.buyer.name}: {order.invoice.number}"
    context = {
        "order": order,
        "orderlines": order.orderline_set.all(),
        "invoice": order.invoice,
        "buyer": order.buyer,
        "send_email": True
    }
    html_message = render_to_string('sales/invoice_email.html', context)
    plain_message = strip_tags(html_message)
    from_email = settings.EMAIL_HOST_USER
    to = order.buyer.email
    try:
        send_mail(subject, plain_message, f"Turfd <{from_email}>", [to], html_message=html_message)
    except Exception as err:
        raise err
    else:
        messages.success(request, f'Successfully sent the invoice to {order.buyer.name}!')
    return HttpResponseRedirect(reverse_lazy("invoice", kwargs={"pk": order.invoice.id}))


@login_required
def deliver(request, pk):
    order = Order.objects.get(id=pk)
    order.deliver()
    return HttpResponseRedirect(reverse_lazy("orders"))


@method_decorator(login_required, name='dispatch')
class InvoiceOrderView(DetailView):
    model = Order
    template_name = 'sales/send_invoice.html'
    context_object_name = "order"

    def get(self, request, *args, **kwargs):
        context = {}
        order = Order.objects.get(id=kwargs.get("pk"))
        if order.status == Order.Status.SUBMITTED:
            order.invoice_order()
        context["order"] = order
        context["orderlines"] = order.orderline_set.all()
        return render(request, template_name="sales/send_invoice.html", context=context)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        order = Order.objects.get(id=kwargs.get("pk"))
        # Pre-populate invoice choices and then disable it in forms.py
        # form = PaymentCreateForm(pk=self.object.id)
        # form.base_fields["invoice"].queryset = Invoice.objects.filter(id=self.object.id)
        context["order"] = order
        # context["payments"] = self.object.payment_set.all()
        return context

