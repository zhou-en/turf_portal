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

from sales.models import Buyer
from sales.forms import BuyerCreateForm, BuyerUpdateForm


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


@method_decorator(login_required, name='dispatch')
class BuyerDetailView(DetailView):
    model = Buyer
    template_name = 'sales/buyer.html'
    context_object_name = "buyer"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["buyer_products"] = self.object.buyerproduct_set.all()
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
            # Remove buyer products here
            return super(BuyerDeleteView, self).post(request, *args, **kwargs)
