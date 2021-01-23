from django.db import models
from django_extensions.db.models import TimeStampedModel
from django.utils.translation import gettext_lazy as _

from django.utils import timezone


# Create your models here.
class Expense(TimeStampedModel, models.Model):
    """
    Expense record.
    """
    class Method(models.TextChoices):
        CARD = 'CARD', _('Card')
        CASH = 'CASH', _('Cash')
        EFT = "EFT", _("EFT")
        OTHER = 'OTHER', _('Other')

    date = models.DateTimeField(blank=False, null=False)
    description = models.CharField(max_length=511, blank=False, null=False)
    method = models.CharField(
        max_length=255,
        choices=Method.choices,
        default=Method.CARD,
    )
    amount = models.FloatField(default=0.0, verbose_name="Amount (R)",)

    def __str__(self):
        return f"{self.date:%Y-%m-%d} {self.description}: -R{self.amount}"
