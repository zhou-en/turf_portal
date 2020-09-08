from django import forms
from django.forms.widgets import SelectDateWidget, Select

from sales.models import Buyer, BuyerProduct


class BuyerCreateForm(forms.ModelForm):

    class Meta:
        model = Buyer
        fields = "__all__"

    field_order = ["buyer_type", "name", "mobile", "email", "address", "contact_person"]


class BuyerUpdateForm(forms.ModelForm):

    class Meta:
        model = Buyer
        fields = "__all__"

    field_order = ["buyer_type", "name", "mobile", "email", "address", "contact_person"]


class BuyerProductAdminForm(forms.ModelForm):

    # When this field is enabled, it's required
    name = forms.CharField(help_text="Product name.")
    # batch = forms.ModelChoiceField(
    #     Batch.objects.all(),
    #     help_text="Give the product a batch number."
    # )
    # packaging_warehouse = forms.CharField(help_text="Where the product is being packaged.")

    class Meta:
        model = BuyerProduct
        exclude = []
