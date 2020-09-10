from django.utils.translation import gettext_lazy as _
from django.urls import reverse_lazy
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from stock.models import Product
from sales.models import Buyer, BuyerProduct
from sales.forms import BuyerCreateForm, BuyerUpdateForm, BuyerProductCreateForm


# Create your views here.
class BuyerListView(ListView):
    model = Buyer
    template_name = "sales/buyers.html"
    context_object_name = 'buyers'
    queryset = Buyer.objects.all()
    paginate_by = 10

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
