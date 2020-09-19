import logging
from django.core.validators import MinValueValidator
from django.utils import timezone
from django.db.models import Avg, Count, Sum
from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel

from stock.models import Product, TurfRoll
from sales.models import Order, Buyer
from sales.utils import invoice_status_color

logger = logging.getLogger(__name__)


class Invoice(TimeStampedModel, models.Model):
    """
    Invoice for each order.
    """

    class Status(models.TextChoices):
        DRAFT = "DRAFT", _("Draft")
        # when invoice is sent to buyer
        PAYMENT_OUTSTANDING = 'PAYMENT OUTSTANDING', _('Payment Outstanding')
        # when payment is completed
        CLOSED = 'CLOSED', _('Closed')

    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.DRAFT,
    )
    order = models.ForeignKey(Order, on_delete=models.DO_NOTHING)
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
    number = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return f"{self.number}"

    def save(self, *args, **kwargs):
        # Only set number when creates
        if not self.number:
            self.number = self.order.number
        super(Invoice, self).save(*args, **kwargs)

    def send(self):
        """
        Send invoice to buyer, update order to invoiced status.
        """
        self.status = Invoice.Status.PAYMENT_OUTSTANDING
        self.save()
        self.order.status = Order.Status.INVOICED
        self.order.save()


class Invoice(TimeStampedModel, models.Model):
    """
    Invoice for each order.
    """

    class Status(models.TextChoices):
        DRAFT = "DRAFT", _("Draft")
        # when invoice is sent to buyer
        PAYMENT_OUTSTANDING = 'PAYMENT OUTSTANDING', _('Payment Outstanding')
        # when payment is completed
        CLOSED = 'CLOSED', _('Closed')

    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.DRAFT,
    )
    order = models.ForeignKey(Order, on_delete=models.DO_NOTHING)
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
    number = models.CharField(max_length=255, null=True, blank=True)
    closed_date = models.DateField(blank=True, null=True)

    def __str__(self):
        return f"{self.number}"

    @property
    def total_payment(self):
        result = self.payment_set.all().aggregate(Sum("amount"))
        if result.get("amount__sum"):
            return float(result.get("amount__sum"))
        return 0.0

    @property
    def payment_complete(self):
        if self.order.total_amount == self.total_payment:
            return True
        return False

    @property
    def amount_due(self):
        """
        total amount - total payment
        """
        return self.order.total_amount - self.total_payment

    @property
    def has_payment(self):
        if self.payment_set.exists():
            return True
        return False

    @property
    def status_color(self):
        return invoice_status_color(self.status)

    def close(self):
        self.closed_date = timezone.now()
        self.status = Invoice.Status.CLOSED
        self.save()
        self.order.close()


class Payment(TimeStampedModel, models.Model):
    """
    Payment made to an invoice.
    """
    class Method(models.TextChoices):
        EFT = "EFT", _("EFT")
        # when invoice is sent to buyer
        CASH = 'CASH', _('Cash')
        # when payment is completed
        OTHER = 'OTHER', _('Other')

    method = models.CharField(
        max_length=255,
        choices=Method.choices,
        default=Method.EFT,
    )
    invoice = models.ForeignKey(Invoice, on_delete=models.DO_NOTHING)
    amount = models.FloatField(default=0.0)

    def __str__(self):
        return f"{self.amount}"

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        if self.invoice.payment_complete:
            self.invoice.close()
