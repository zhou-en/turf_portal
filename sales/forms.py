from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django import forms

from sales.models import Buyer, BuyerProduct, Order, OrderLine
from stock.models import TurfRoll


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


class OrderCreateForm(forms.ModelForm):

    class Meta:
        model = Order
        fields = ["buyer"]

    def __init__(self, *args, **kwargs):
        super(OrderCreateForm, self).__init__(*args, **kwargs)


class OrderAddItemForm(forms.ModelForm):

    class Meta:
        model = Order
        exclude = []

    selected_items = forms.CharField(
        widget=forms.HiddenInput(),
        required=False,
    )


class OrderItemUpdateForm(forms.ModelForm):

    class Meta:
        model = OrderLine
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        self.base_fields["order"].disabled = True
        self.base_fields["price"].disabled = True
        self.base_fields["price"].label = "Price (R)"
        self.base_fields["quantity"].label = mark_safe("Quantity (m<sup>2</sup>)")
        self.base_fields["buyer_product"].disabled = True
        spec = kwargs["instance"].buyer_product.product.spec
        roll_queryset = TurfRoll.objects.filter(spec=spec)
        self.base_fields["roll"].queryset = roll_queryset
        super().__init__(*args, **kwargs)
