from django import forms
from django.forms.widgets import SelectDateWidget, Select
from django.utils.safestring import mark_safe

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
        fields = ["status", "spec", "location", "quantity"]

    status = forms.ChoiceField(
        choices=((c.label, c.value) for c in TurfRoll.Status),
        widget=forms.Select(attrs={"onChange": 'disableSizeField()'}),
        required=False
    )

    quantity = forms.IntegerField(
        help_text="Number of rolls to be loaded.",
        label="Quantity"
    )

    size = forms.IntegerField(
        help_text="Size of loose roll in square meters.",
        label="Loose Size"
    )

    def __init__(self, *args, **kwargs):
        self.base_fields["spec"].empty_label = None
        self.base_fields["location"].empty_label = None
        self.base_fields["size"].required = False
        # self.base_fields["size"].disabled = True
        super().__init__(*args, **kwargs)


class SplitRollForm(forms.ModelForm):

    class Meta:
        model = TurfRoll
        fields = ["available", "size"]

    size = forms.IntegerField(
        help_text=mark_safe("Size in (m<sup>2</sup>)"),
        label="Split Size"
    )

    available = forms.IntegerField(
        help_text=mark_safe("Size in (m<sup>2</sup>)"),
        label="Available Size"
    )

    def __init__(self, *args, **kwargs):
        self.base_fields["available"].disabled = True
        # self.base_fields["location"].empty_label = None
        super().__init__(*args, **kwargs)
