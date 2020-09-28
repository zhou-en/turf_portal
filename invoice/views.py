import logging
import pydf
from django.urls import reverse_lazy
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import View, DetailView, ListView, CreateView
from django.template.loader import get_template

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
        context["form"] = form
        context["payments"] = self.object.payment_set.all()
        return context


@method_decorator(login_required, name='dispatch')
class PaymentCreateView(CreateView):
    model = Payment
    template_name = 'invoice/payment_create.html'
    form_class = PaymentCreateForm

    def get_success_url(self):
        pk = self.kwargs.pop("pk")
        return reverse_lazy('invoice', kwargs={'pk': pk})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("invoice", kwargs={"pk": self.kwargs.get("pk")}))
        else:
            pk = kwargs.pop("pk")
            return super(PaymentCreateView, self).post(request, *args, **kwargs)


class ExportPDFView(View):

    def get(self, request, *args, **kwargs):

        pk = self.kwargs.get("pk")
        invoice = Invoice.objects.get(id=pk)

        context = {
            "order": invoice.order,
            "orderlines": invoice.order.orderline_set.all(),
            "invoice": invoice,
            "buyer": invoice.buyer,
            "send_email": False
        }
        filename = "%s.pdf" % invoice.number
        template = get_template("sales/invoice_email.html")
        html = template.render(context)  # Renders the template with the context data.
        pdf = pydf.generate_pdf(
            html,
            page_size="A4",
            margin_left="15mm",
            margin_right="15mm",
            margin_top="20mm",
            margin_bottom="20mm",
            orientation="Landscape",
        )
        return HttpResponse(pdf, content_type='application/pdf')
