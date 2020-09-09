from decimal import Decimal

from django.core.validators import MinValueValidator
from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel


from stock.models import Product


# Create your models here.
class Buyer(TimeStampedModel, models.Model):
    """
    Buyer is an abstract entity, it could be a shop or a contractor.
    """

    class Type(models.TextChoices):
        CONTRACTOR = 'CONTRACTOR', _('Contractor')
        SHOP = 'SHOP', _('Shop')

    buyer_type = models.CharField(
        max_length=255,
        choices=Type.choices,
        default=Type.CONTRACTOR,
        blank=True,
        null=True
    )
    name = models.CharField(max_length=255)
    address = models.CharField(max_length=255, blank=True, null=True)
    contact_person = models.CharField(max_length=255)
    mobile = models.CharField(max_length=255, blank=True, null=True)
    email = models.EmailField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"Buyer: {self.name}"


class BuyerProduct(TimeStampedModel, models.Model):
    """
    BuyerProduct is used to store the products assigned to different buyer and prices.
    """
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING, blank=True, null=True)
    product = models.ForeignKey(Product, on_delete=models.DO_NOTHING, blank=True, null=True)
    price = models.DecimalField(_(u'Price (R/m)'), decimal_places=2, max_digits=12, validators=[MinValueValidator(Decimal('1.01'))])

    class Meta:
        unique_together = ("buyer", "product")

    def __str__(self):
        return f"Buyer: {self.buyer.name} - {self.product}: R{self.price}"
