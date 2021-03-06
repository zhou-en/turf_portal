import logging
from django.core.validators import MinValueValidator
from django.utils import timezone
from django.db.models import Avg, Count, Sum
from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel

from stock.models import Product, TurfRoll
from sales.models import Order, Buyer
from sales.utils import invoice_status_color, payment_status_color

logger = logging.getLogger(__name__)


class Invoice(TimeStampedModel, models.Model):
    """
    Invoice for each order.
    """

    class Status(models.TextChoices):
        DRAFT = "DRAFT", _("Draft")
        # when invoice is sent to buyer
        OUTSTANDING = 'OUTSTANDING', _('Outstanding')
        PENDING = 'PENDING', _('Pending')
        # when payment is completed
        CLOSED = 'CLOSED', _('Closed')

    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.DRAFT,
    )
    order = models.ForeignKey(Order, on_delete=models.DO_NOTHING)
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
    number = models.CharField(max_length=255, null=True, blank=True, unique=True)
    closed_date = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.id}: {self.number} - {self.status}"

    def save(self, *args, **kwargs):
        # Only set number when creates
        if not self.number:
            from sales.utils import remove_none_alphanumeric
            name_str = remove_none_alphanumeric(self.buyer.name.upper())
            time_str = self.order.number.split("-")[-1]
            self.number = f"{name_str}-INV-{time_str}"
        super().save(*args, **kwargs)

    def send(self):
        """
        Send invoice to buyer, update order to invoiced status.
        """
        self.status = Invoice.Status.OUTSTANDING
        self.save()
        self.order.status = Order.Status.INVOICED
        self.order.save()

    @property
    def total_payment(self):
        result = self.payment_set.all().aggregate(Sum("amount"))
        if result.get("amount__sum"):
            return round(float(result.get("amount__sum")), 2)
        return round(0.0, 2)

    @property
    def payment_complete(self):
        return (
            self.order.total_wt_discount == self.total_payment and
            self.payments_confirmed
        )

    @property
    def amount_due(self):
        """
        total amount - total payment
        """
        return round((self.order.total_amount - self.order.discount - self.total_payment), 2)

    @property
    def has_payment(self):
        return  bool(self.payment_set.exists())

    @property
    def status_color(self):
        return invoice_status_color(self.status)

    def close(self):
        if self.status != Invoice.Status.CLOSED:
            self.closed_date = timezone.now()
            self.status = Invoice.Status.CLOSED
            self.save()
            self.order.close()

    @property
    def is_payable(self):
        return self.status not in [
            Invoice.Status.DRAFT,
            Invoice.Status.CLOSED
        ]

    def is_invoiceable(self):
        return self.status in [
            Invoice.Status.OUTSTANDING,
            Invoice.Status.CLOSED
        ]

    @property
    def payments_confirmed(self):
        return Payment.Status.PENDING not in [
            p.status for p in self.payment_set.all()
        ]

    @property
    def has_pending_payments(self):
        return Payment.Status.PENDING in [
            p.status for p in self.payment_set.all()
        ]


class Payment(TimeStampedModel, models.Model):
    """
    Payment made to an invoice.
    """
    class Status(models.TextChoices):
        PENDING = 'PENDING', _('Pending')
        CONFIRMED = 'CONFIRMED', _('Confirmed')

    class Method(models.TextChoices):
        CARD = 'CARD', _('Card')
        CASH = 'CASH', _('Cash')
        EFT = "EFT", _("EFT")
        OTHER = 'OTHER', _('Other')
    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.PENDING,
    )
    method = models.CharField(
        max_length=255,
        choices=Method.choices,
        default=Method.EFT,
    )
    invoice = models.ForeignKey(Invoice, on_delete=models.DO_NOTHING)
    amount = models.FloatField(default=0.0)

    def __str__(self):
        return f"{self.method} - {self.status} - {self.amount}"

    def save(self, *args, **kwargs):
        self.amount = round(self.amount, 2)
        # Set default status base on payment method at creation
        if not self.pk:
            if self.method == Payment.Method.EFT:
                self.status = Payment.Status.PENDING
            else:
                self.status = Payment.Status.CONFIRMED
        super().save(*args, **kwargs)
        if self.invoice.payment_complete:
            self.invoice.close()

    @property
    def status_color(self):
        return payment_status_color(self.status)

    def confirm(self):
        if self.status != Payment.Status.CONFIRMED:
            self.status = Payment.Status.CONFIRMED
            self.save()

