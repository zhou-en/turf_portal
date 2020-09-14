import logging
from django.core.validators import MinValueValidator
from django.utils import timezone
from django.db.models import Avg, Count, Sum
from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel

from stock.models import Product, TurfRoll

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
        return f"Buyer: {self.name}"

    @property
    def buyer_products(self):
        """
        Returns all buyer products assgined to this buyer.
        """
        return self.buyerproduct_set.all()


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
# class Invoice(TimeStampedModel, models.Model):
#     """
#     Invoice for each order.
#     """
#
#     class Status(models.TextChoices):
#         DRAFT = "DRAFT", _("Draft")
#         # when invoice is sent to buyer
#         SENT = 'SENT', _('Sent')
#         # when invoice is sent to buyer
#         PAYMENT_OUTSTANDING = 'PAYMENT_OUTSTANDING', _('Payment_Outstanding')
#         # when payment is completed
#         CLOSED = 'CLOSED', _('Closed')
#
#     status = models.CharField(
#         max_length=255,
#         choices=Status.choices,
#         default=Status.DRAFT,
#     )
#     buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
#     number = models.CharField(max_length=255)
#     notes = models.TextField(max_length=1023, null=True, blank=True)
#
#     def __str__(self):
#         return f"{self.number}"
#
#     def save(self, *args, **kwargs):
#         self.number = self.order.number
#         super(Invoice, self).save(*args, **kwargs)
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
        DELIVERED = "DELIVERED", _("DELIVERED")
        # when payment is complete
        CLOSED = 'CLOSED', _('Closed')

    status = models.CharField(
        max_length=255,
        choices=Status.choices,
        default=Status.DRAFT,
    )
    buyer = models.ForeignKey(Buyer, on_delete=models.DO_NOTHING)
    number = models.CharField(max_length=255, blank=True, null=True)

    # invoice = models.ForeignKey(Invoice, on_delete=models.DO_NOTHING, blank=True, null=True)

    def __str__(self):
        return f"{self.number}"

    def save(self, *args, **kwargs):
        # Only create order number during create
        if not self.pk:
            self.number = f"{self.buyer.name.upper()}-{timezone.now().strftime('%Y%m%d%H%m')}"
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
        """
        self.status = Order.Status.SUBMITTED
        self.save()
        # ToDo: Create invoice here:

    def deliver(self):
        """
        Set order to delivered status.
        """
        self.status = Order.Status.DELIVERED
        self.save()

    @property
    def is_delivered(self):
        """
        Return true if order is delivered.
        """
        return self.status in [
            Order.Status.DELIVERED,
            Order.Status.CLOSED
        ]

    def create_invoice(self):
        """
        create invoice after order is submitted.
        """
        for ol in self.orderline_set.all():
            roll = ol.roll
            if roll.available == 0:
                roll.status = TurfRoll.Status.DEPLETED
                logger.debug("Roll %s is depleted.", roll.id)
                roll.save()

    def close(self):
        """
        Order can only be closed once invoice is paid.
        """
        self.status = Order.Status.CLOSED
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

    def reserve_roll(self):
        """
        Each orderline should reserve its own roll when order is submitted.
        """
        self.roll.reserved += self.quantity
        self.roll.save()

    def cut_roll(self):
        """
        Each orderline should claim the reserved quantity from its roll.
        """
        self.roll.reserved -= self.quantity
        self.roll.available -= self.quantity
        self.roll.save()
