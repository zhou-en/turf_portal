from crispy_forms.helper import FormHelper
from crispy_forms.layout import Button, Submit
from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django import forms

from sales.models import Buyer, BuyerProduct, Order, OrderLine
from stock.models import TurfRoll, Product


class BuyerCreateForm(forms.ModelForm):

    class Meta:
        model = Buyer
        fields = "__all__"

    field_order = ["buyer_type", "name", "mobile", "email", "address", "contact_person"]

    def __init__(self, *args, **kwargs):
        self.base_fields["status"].disabled = True
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(BuyerCreateForm, self).__init__(*args, **kwargs)


class BuyerUpdateForm(forms.ModelForm):

    class Meta:
        model = Buyer
        fields = "__all__"

    field_order = ["buyer_type", "name", "mobile", "email", "address", "contact_person"]

    def __init__(self, *args, **kwargs):
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(BuyerUpdateForm, self).__init__(*args, **kwargs)


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
        choices=[("Select A Product", _("Select A Product"))],
        widget=forms.Select,
        required=True
    )

    field_order = ["buyer", "product", "price"]

    def __init__(self, *args, **kwargs):
        self.base_fields["buyer"].disabled = True
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Submit'))
        super(BuyerProductCreateForm, self).__init__(*args, **kwargs)


class BuyerProductUpdateForm(forms.ModelForm):
    class Meta:
        model = BuyerProduct
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        instance = kwargs.get("instance")
        self.base_fields["buyer"].disabled = True
        self.base_fields["product"].disabled = True
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Save'))
        super(BuyerProductUpdateForm, self).__init__(*args, **kwargs)


class BuyerOrderCreateForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        if "pk" in kwargs:
            pk = kwargs.pop("pk")
            buyer = Buyer.objects.filter(id=pk)
            self.base_fields["buyer"].queryset = buyer
            self.base_fields["buyer"].empty_label = None
        super(BuyerOrderCreateForm, self).__init__(*args, **kwargs)


class OrderCreateForm(forms.ModelForm):

    class Meta:
        model = Order
        fields = ["buyer"]

    def __init__(self, *args, **kwargs):
        if "pk" in kwargs:
            pk = kwargs.pop("pk")
            buyer = Buyer.objects.filter(id=pk)
            self.base_fields["buyer"].queryset = buyer
        self.base_fields["buyer"].empty_label = None
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
        self.base_fields["product"].disabled = True
        spec = kwargs["instance"].product.spec
        roll_queryset = TurfRoll.objects.filter(spec=spec)
        self.base_fields["roll"].queryset = roll_queryset
        self.base_fields["roll"].empty_label = None
        self.helper = FormHelper()
        self.helper.add_input(Button('cancel', 'Cancel', onclick='window.history.back();'))
        self.helper.add_input(Submit('submit', 'Save'))
        super().__init__(*args, **kwargs)
