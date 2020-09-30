from crispy_forms.helper import FormHelper
from crispy_forms.layout import Button, Submit
from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django.core.exceptions import ValidationError
from django import forms

from invoice.models import Invoice, Payment


# class PaymentCreateForm(forms.ModelForm):
#
#     class Meta:
#         model = Payment
#         fields = ["amount", "method", "invoice"]
#
#     def __init__(self, pk, *args, **kwargs):
#     #     invoice = Invoice.objects.filter(id=pk)
#     #     self.base_fields["invoice"].queryset = invoice
#     #     self.base_fields["amount"].max_value = invoice.first().amount_due
#     #     self.base_fields["amount"].initial = invoice.first().amount_due
#         super().__init__(*args, **kwargs)
#
#     def clean_amount(self):
#         paid_amount = self.cleaned_data['amount']
#         if paid_amount > self.invoice.amount_due:
#             raise ValidationError("The amount paid was exceeded required amount.")
#         return paid_amount


class PaymentCreateForm(forms.ModelForm):

    class Meta:
        model = Payment
        fields = ["invoice", "method", "amount"]

    def __init__(self, *args, **kwargs):
        if "pk" in kwargs:
            pk = kwargs.pop("pk")
            invoice = Invoice.objects.filter(id=pk)
            self.base_fields["invoice"].queryset = invoice
            # ToDo: the followings are not showing in the create page
            self.base_fields["amount"].max_value = invoice.first().amount_due
            self.base_fields["amount"].initial = invoice.first().amount_due
            self.base_fields["amount"].min_value = 0.0
        self.base_fields["invoice"].empty_label = None
        self.base_fields["invoice"].disabled = True
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(PaymentCreateForm, self).__init__(*args, **kwargs)

    def clean_amount(self):
        cleaned_data = self.clean()
        amount = cleaned_data.get('amount')
        max_amount = self.base_fields["amount"].max_value
        if amount and amount > max_amount:
            # self.add_error('amount', "The paid amount is exceeded due amount.")
            raise ValidationError(
                _('Amount exceeded due amount: R%(value)s'),
                code='invalid',
                params={'value': f"{max_amount}"},
            )
        if not amount or (amount <= 0):
            # self.add_error('amount', "The paid amount is exceeded due amount.")
            raise ValidationError(
                _('Invalid amount: %(value)s'),
                code='invalid',
                params={'value': f"{amount}"},
            )
        return amount
