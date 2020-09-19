import logging
from django.core.validators import MinValueValidator
from django.utils import timezone
from django.db.models import Avg, Count, Sum
from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel

from stock.models import Product, TurfRoll
from sales.utils import order_status_color

logger = logging.getLogger(__name__)


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
        return f"{self.name}"

    @property
    def buyer_products(self):
        """
        Returns all buyer products assgined to this buyer.
        """
        return self.buyerproduct_set.all()

    @property
    def history_total(self):
        """
        Return total of all orders have been placed by the buyer.
        """
        total = 0
        for order in self.order_set.all():
            total += order.total_amount
        return total


class BuyerProduct(TimeStampedModel, models.Model):
    """
    BuyerProduct is used to store the products assigned to different buyer and prices.
    """
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING, blank=True, null=True)
    product = models.ForeignKey(Product, on_delete=models.DO_NOTHING, blank=True, null=True)
    price = models.FloatField(default=50.0, validators=[MinValueValidator(50.0)], )

    class Meta:
        unique_together = ("buyer", "product")

    def __str__(self):
        return f"Buyer: {self.buyer.name} - {self.product}: R{self.price}"

    @property
    def available_rolls(self):
        return TurfRoll.objects.filter(spec=self.product.spec)

#
#
# class Payment(TimeStampedModel, models.Model):
#     """
#     Payment made towards each orde.
#     """
#     buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
#     invoice = models.ForeignKey(Invoice, on_delete=models.DO_NOTHING)
#     amount = models.FloatField(default=0.0)
#
#     def __str__(self):
#         return f"Payment: R{self.amount}"


class Order(TimeStampedModel, models.Model):
    """
    Orders for each sale.
    """

    class Status(models.TextChoices):
        DRAFT = "DRAFT", _("Draft")
        # when order is created
        SUBMITTED = 'SUBMITTED', _('Submitted')
        # when invoice is sent to buyer
        INVOICED = 'INVOICED', _('Invoiced')
        DELIVERED = "DELIVERED", _("Delivered")
        # when payment is complete
        CLOSED = 'CLOSED', _('Closed')

    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.DRAFT,
    )
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
    number = models.CharField(max_length=255, blank=True, null=True)
    closed_date = models.DateField(null=True, blank=True)

    # invoice = models.ForeignKey(Invoice, on_delete=models.DO_NOTHING, blank=True, null=True)

    def __str__(self):
        return f"{self.number}"

    def save(self, *args, **kwargs):
        # Only create order number during create
        if not self.pk:
            from utils import remove_none_alphanumeric
            name_str = remove_none_alphanumeric(self.buyer.name.upper())
            time_str = timezone.now().strftime('%Y%m%d%H%m')
            self.number = f"{name_str}-{time_str}"
        super().save(*args, **kwargs)

    @property
    def total_amount(self):
        """
        Returns total amount of the entire order, i.e. sum of all orderline prices.
        """
        result = self.orderline_set.aggregate(Sum('price'))
        if result.get("price__sum"):
            return float(result.get("price__sum"))
        return 0.0

    @property
    def orderlines(self):
        """
        Returns all ordered items for the order.
        """
        return self.orderline_set.all()

    # def reserve_rolls(self):
    #     """
    #     Reserved quantity on TurfRolls based on orderlines.
    #     """
    #     for ol in self.orderline_set.all():
    #         ol.reserve_roll()
    #
    # def cut_rolls(self):
    #     """
    #     Claim reserved roll from for each orderline.
    #     """
    #     for ol in self.orderline_set.all():
    #         ol.cut_roll()

    def submit(self):
        """
        Submit order, i.e. order status will transit from Daft to Submitted.
        Create invoice for this order.
        """
        self.status = Order.Status.SUBMITTED
        self.save()
        from invoice.models import Invoice
        invoice, created = Invoice.objects.get_or_create(
            order_id=self.id,
            buyer_id=self.buyer_id
        )
        logger.info("Invoice was created for order: %s", self.number)
        if created:
            invoice.status = Invoice.Status.DRAFT
        invoice.number = self.number
        invoice.save()

    def deliver(self):
        """
        Set order to delivered status.
        """
        from invoice.models import Invoice
        self.status = Order.Status.DELIVERED
        logger.info("Order %s status was updated to DELIVERED.", self.number)
        self.save()
        invoice = self.invoice_set.first()
        if invoice.status != Invoice.Status.PAYMENT_OUTSTANDING:
            logger.info("Update invoice %s status to PAYMENT_OUTSTANDING.", self.number)
            invoice.status = Invoice.Status.PAYMENT_OUTSTANDING
            invoice.save()

    def editable(self):
        """
        Set order to delivered status.
        """
        return self.status in [
            Order.Status.DRAFT,
            Order.Status.SUBMITTED
        ]

    def send_invoice(self):
        """
        Send invoice to buyer.
        Set order to invoiced status, invoice to payment outstanding.
        """
        from invoice.models import Invoice
        self.status = Order.Status.INVOICED
        logger.info("Update order %s status to INVOICED.", self.number)
        self.save()
        invoice = self.invoice_set.first()
        logger.info("Update invoice %s status to PAYMENT_OUTSTANDING.", self.number)
        invoice.status = Invoice.Status.PAYMENT_OUTSTANDING
        invoice.save()

    @property
    def is_delivered(self):
        """
        Return true if order is delivered.
        """
        return self.status in [
            Order.Status.DELIVERED,
            Order.Status.CLOSED
        ]

    def close(self):
        """
        Order can only be closed once invoice is paid.
        """
        self.status = Order.Status.CLOSED
        self.closed_date = timezone.now()
        self.save()

    def create_orderlines(self, requested_roll_infos):
        """
        Create orderlines base on the given list of requested roll info, i.e.
        {quantity, buyer_product_id, roll_id}
        """
        for item in requested_roll_infos:
            roll = TurfRoll.objects.get(id=item.get("roll_id"))
            OrderLine.objects.create(
                order_id=self.id,
                buyer_product_id=item.get("buyer_product_id"),
                roll=roll,
                quantity=float(item.get("quantity", 0))
            )
            if roll.status == TurfRoll.Status.SEALED:
                logger.info("Open a new roll: %s", roll.id)
                roll.status = TurfRoll.Status.OPENED
                roll.save()

    @property
    def status_color(self):
        return order_status_color(self.status)

    @property
    def invoice(self):
        return self.invoice_set.first()


class OrderLine(TimeStampedModel, models.Model):
    """
    Ordered item for each order.
    """

    order = models.ForeignKey(Order, on_delete=models.DO_NOTHING)
    buyer_product = models.ForeignKey(BuyerProduct, on_delete=models.DO_NOTHING)
    roll = models.ForeignKey(TurfRoll, on_delete=models.DO_NOTHING)
    quantity = models.FloatField(default=0.0)
    price = models.FloatField(default=0.0, blank=True, null=True)  # quantity * buyer_product.price

    def __str__(self):
        return f"Order: {self.buyer_product}: {self.quantity} for {self.price}"

    def save(self, *args, **kwargs):
        self.price = self.quantity * self.buyer_product.price
        super().save(*args, **kwargs)

