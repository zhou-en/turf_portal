import logging

import pydf
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, HttpResponseRedirect
from django.template.loader import get_template
from django.urls import reverse_lazy
from django.utils.decorators import method_decorator
from django.views.generic import (
    CreateView,
    DetailView,
    ListView,
    UpdateView,
    View,
)

from invoice.forms import PaymentCreateForm, PaymentUpdateForm
from invoice.models import Invoice, Payment

logger = logging.getLogger(__name__)


# Create your views here.
class InvoiceListView(ListView):
    model = Invoice
    template_name = "invoice/invoices.html"
    context_object_name = "invoices"
    queryset = Invoice.objects.all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        open_payments = {}
        for invoice in Invoice.objects.all().exclude(
            status=Invoice.Status.CLOSED
        ):
            open_payments.update({invoice.id: invoice.payment_set.all()})
        context["open_payments"] = open_payments
        return context


@method_decorator(login_required, name="dispatch")
class InvoiceDetailView(DetailView):
    model = Invoice
    template_name = "invoice/invoice.html"
    context_object_name = "invoice"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Prepopulate invoice choices and then disable it in forms.py
        form = PaymentCreateForm(pk=self.object.id)
        context["form"] = form
        context["payments"] = self.object.payment_set.all().order_by(
            "-modified"
        )
        return context


@method_decorator(login_required, name="dispatch")
class PaymentCreateView(CreateView):
    model = Payment
    template_name = "invoice/payment_create.html"
    form_class = PaymentCreateForm

    def get_form(self, form_class=None):
        form = super().get_form()
        pk = self.kwargs.get("pk")
        invoice = Invoice.objects.filter(id=pk)
        form.base_fields["invoice"].queryset = invoice
        form.initial.update({"invoice": invoice.first().id})
        return form

    def get_success_url(self):
        pk = self.kwargs.pop("pk")
        return reverse_lazy("invoice", kwargs={"pk": pk})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(
                reverse_lazy("invoice", kwargs={"pk": self.kwargs.get("pk")})
            )
        return super(PaymentCreateView, self).post(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        invoice = Invoice.objects.get(id=self.kwargs.get("pk"))
        context.update({"invoice": invoice})
        return context


@method_decorator(login_required, name="dispatch")
class PaymentUpdateView(UpdateView):
    model = Payment
    template_name = "invoice/payment_update.html"
    context_object_name = "payment"
    form_class = PaymentUpdateForm

    def get_success_url(self):
        payment_pk = self.kwargs.get("pk")
        payment = Payment.objects.get(id=payment_pk)
        return reverse_lazy("invoice", kwargs={"pk": payment.invoice_id})

    def post(self, request, *args, **kwargs):
        payment_pk = kwargs.get("pk")
        payment = Payment.objects.get(id=payment_pk)
        if "cancel" in request.POST:
            return HttpResponseRedirect(
                reverse_lazy("invoice", kwargs={"pk": payment.invoice_id})
            )
        else:
            return super(PaymentUpdateView, self).post(
                request, *args, **kwargs
            )


#     def get_context_data(self, **kwargs):
# context = super().get_context_data(**kwargs)
# context["invoice"] = self.object.invoice
# return context
#


@method_decorator(login_required, name="dispatch")
class PaymentListView(ListView):
    model = Payment
    template_name = "invoice/payment_list.html"
    context_object_name = "payments"
    queryset = Payment.objects.all()


@login_required
def confirm_payment(request, pk):
    payment = Payment.objects.get(id=pk)
    payment.confirm()
    return HttpResponseRedirect(
        reverse_lazy("invoice", kwargs={"pk": payment.invoice.id})
    )


@login_required
def confirm_all_payments(request, pk):
    invoice = Invoice.objects.get(id=pk)
    for payment in invoice.payment_set.all():
        payment.confirm()
    return HttpResponseRedirect(reverse_lazy("invoice", kwargs={"pk": pk}))


class ExportPDFView(View):
    def get(self, request, *args, **kwargs):

        pk = self.kwargs.get("pk")
        invoice = Invoice.objects.get(id=pk)

        context = {
            "order": invoice.order,
            "orderlines": invoice.order.orderline_set.all().order_by(
                "product"
            ),
            "invoice": invoice,
            "buyer": invoice.buyer,
            "send_email": False,
            "bank": settings.BANK,
            "branch": settings.BRANCH,
            "branch_code": settings.BRANCH_CODE,
            "swift_code": settings.SWIFT_CODE,
            "account_number": settings.ACCOUNT_NUMBER,
            "account_name": "TURFD",
            "account_type": settings.ACCOUNT_TYPE,
            "email_address": settings.EMAIL_HOST_USER,
            "phone_number": settings.PHONE_NUMBER,
        }
        template = get_template("sales/invoice_email.html")
        html = template.render(
            context
        )  # Renders the template with the context data.
        pdf = pydf.generate_pdf(
            html,
            page_size="A4",
            margin_left="15mm",
            margin_right="15mm",
            margin_top="15mm",
            margin_bottom="15mm",
            orientation="Landscape",
        )
        return HttpResponse(pdf, content_type="application/pdf")
