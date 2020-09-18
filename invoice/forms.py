from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django import forms

from invoice.models import Invoice, Payment


class PaymentCreateForm(forms.ModelForm):

    class Meta:
        model = Payment
        fields = ["amount", "method", "invoice"]

    # invoice = forms.ChoiceField(
    #     label=_("Invoice"),
    #     choices=[(None, _("Select Invoice"))],
    #     widget=forms.Select,
    #     required=False
    # )

    def __init__(self, pk, *args, **kwargs):
    #     # self.base_fields["invoice"].disabled = True
    #     # invoice_id = kwargs["instance"].invoice.id
        self.base_fields["invoice"].queryset = Invoice.objects.filter(id=pk)
        super().__init__(*args, **kwargs)
