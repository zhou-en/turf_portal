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

from invoice.models import Invoice, Payment
from invoice.forms import (
    PaymentCreateForm,
)

logger = logging.getLogger(__name__)


# Create your views here.
class InvoiceListView(ListView):
    model = Invoice
    template_name = "invoice/invoices.html"
    context_object_name = 'invoices'
    queryset = Invoice.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(InvoiceListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name='dispatch')
class InvoiceDetailView(DetailView):
    model = Invoice
    template_name = 'invoice/invoice.html'
    context_object_name = "invoice"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Prepopulate invoice choices and then disable it in forms.py
        form = PaymentCreateForm(pk=self.object.id)
        # form.base_fields["invoice"].queryset = Invoice.objects.filter(id=self.object.id)
        context["form"] = form
        context["payments"] = self.object.payment_set.all()
        return context


@method_decorator(login_required, name='dispatch')
class PaymentCreateView(CreateView):
    model = Payment
    template_name = 'invoice/payment_create.html'
    # template_name = 'invoice/invoice.html'
    form_class = PaymentCreateForm
    # success_url = reverse_lazy('invoices')

    # def get_form(self):
    #     form = super().get_form()
    #     invoice_id = self.kwargs.get("pk")
    #     return form
    #
    # def post(self, request, *args, **kwargs):
    #     amount = float(request.POST.get("amount", 0) or 0)
    #     invoice_id = request.POST.get("invoice")
    #     Payment.objects.create(
    #         amount=amount,
    #         invoice_id=invoice_id
    #     )
        # return HttpResponseRedirect(reverse_lazy("invoice", kwargs={"pk": kwargs.get("pk")}))

    def get_success_url(self):
        pk = self.kwargs.pop("pk")
        return reverse_lazy('invoice', kwargs={'pk': pk})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("invoice", kwargs={"pk": self.kwargs.get("pk")}))
        else:
            pk = kwargs.pop("pk")
            return super(PaymentCreateView, self).post(request, *args, **kwargs)

