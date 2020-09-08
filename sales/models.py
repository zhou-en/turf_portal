from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel


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
