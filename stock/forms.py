from django import forms
from django.forms.widgets import SelectDateWidget, Select

from sales.models import Product, TurfRoll


class ProductCreateForm(forms.ModelForm):

    class Meta:
        model = Product
        fields = "__all__"

    field_order = ["product", "price"]


class ProductUpdateForm(forms.ModelForm):

    class Meta:
        model = Product
        fields = "__all__"

    field_order = ["product", "price"]


class LoadStocksForm(forms.ModelForm):

    class Meta:
        model = TurfRoll
        fields = "__all__"

    quantity = forms.IntegerField(
        help_text="Number of rolls loaded.",
        label="Quantity"
    )

    def __init__(self, *args, **kwargs):
        self.base_fields["total"].disabled = True
        self.base_fields["sold"].disabled = True
        self.base_fields["spec"].empty_label = None
        self.base_fields["location"].empty_label = None
        super().__init__(*args, **kwargs)
