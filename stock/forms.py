from crispy_forms.helper import FormHelper
from crispy_forms.layout import Button, Submit
from django import forms
from django.utils.safestring import mark_safe

from stock.models import Product, TurfRoll


class ProductCreateForm(forms.ModelForm):

    class Meta:
        model = Product
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        self.base_fields["spec"].required = True
        self.base_fields["code"].disabled = True
        self.base_fields["code"].help_text = "Code will be generated after save."
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super().__init__(*args, **kwargs)


class ProductUpdateForm(forms.ModelForm):

    class Meta:
        model = Product
        fields = "__all__"

    field_order = ["product", "price"]


class LoadStocksForm(forms.ModelForm):

    class Meta:
        model = TurfRoll
        fields = ["status", "spec", "batch", "location", "quantity"]

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
        self.base_fields["batch"].empty_label = None
        self.base_fields["location"].empty_label = None
        self.base_fields["size"].required = False
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
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


class RollUpdateForm(forms.ModelForm):

    class Meta:
        model = TurfRoll
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        instance = kwargs.get("instance", None)
        self.base_fields["spec"].disabled = True
        self.base_fields["total"].disabled = True
        self.base_fields["sold"].disabled = True
        self.base_fields["total"].label = mark_safe("Running Total (m<sup>2</sup>)")
        self.base_fields["original_size"].label = mark_safe("Original Size (m<sup>2</sup>)")
        self.base_fields["sold"].label = mark_safe("Sold (m<sup>2</sup>)")
        if not instance.spec.is_turf:
            self.base_fields["total"].label = mark_safe("Total (m)")
            self.base_fields["original_size"].label = mark_safe("Original Size (m)")
            self.base_fields["sold"].label = mark_safe("Sold (m)")

        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Save'))
        super().__init__(*args, **kwargs)
