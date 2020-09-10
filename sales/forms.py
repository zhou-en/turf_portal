from django.utils.translation import gettext_lazy as _
from django import forms

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


class BuyerProductCreateForm(forms.ModelForm):

    class Meta:
        model = BuyerProduct
        fields = "__all__"

    buyer = forms.ChoiceField(
        label=_("Buyer"),
        choices=[(None, _("Select Buyer"))],
        widget=forms.Select,
        required=True
    )

    product = forms.ChoiceField(
        label=_("Product"),
        choices=[(None, _("Select Product"))],
        widget=forms.Select,
        required=True
    )

    field_order = ["buyer", "product", "price"]
