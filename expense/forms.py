from crispy_forms.helper import FormHelper
from crispy_forms.layout import Button, Submit
from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django.core.exceptions import ValidationError
from django import forms

from expense.models import Expense


class DateInput(forms.DateInput):
    input_type = 'date'
    format_key = "%Y-%m-%d"


class ExpenseCreateForm(forms.ModelForm):

    class Meta:
        model = Expense
        fields = ['date', 'description', 'method', 'amount']
        widgets = {
            'date': DateInput(format="%Y-%m-%d"),
        }

    def __init__(self, *args, **kwargs):
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(ExpenseCreateForm, self).__init__(*args, **kwargs)


class ExpenseUpdateForm(forms.ModelForm):

    class Meta:
        model = Expense
        fields = "__all__"
        widgets = {
            'date': DateInput(format="%Y-%m-%d"),
        }

    field_order = ["date", "description", "method", "amount"]

    def __init__(self, *args, **kwargs):
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(ExpenseUpdateForm, self).__init__(*args, **kwargs)
        self.fields["amount"].decimal_places = 2
