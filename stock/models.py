from django.conf import settings
from django.db import models
from django.db.models import Avg, Count, Sum
from django.utils.translation import gettext_lazy as _
from django_extensions.db.models import TimeStampedModel


# Create your models here.
class Category(TimeStampedModel, models.Model):
    """
    Category is used to classify different types of products/stock available in the warehouse.
    """

    name = models.CharField(max_length=255)

    class Meta:
        verbose_name_plural = "Categories"

    def __str__(self):
        return f"{self.name}"


class Height(TimeStampedModel, models.Model):
    """
    Grass height in millimeters.
    """

    value = models.FloatField(default=settings.DEFAULT_ROLL_HEIGHT)

    def __str__(self):
        return f"{self.value}"


class Width(TimeStampedModel, models.Model):
    """
    Grass roll width in meters.
    """

    value = models.FloatField(default=settings.DEFAULT_ROLL_WIDTH)

    def __str__(self):
        return f"{self.value}"


class Color(TimeStampedModel, models.Model):
    """
    Grass colors.
    """

    name = models.CharField(max_length=63)

    def __str__(self):
        return f"{self.name}"


class Warehouse(TimeStampedModel, models.Model):
    """
    This is to store where all stock are located.
    """

    number = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=255)
    address = models.CharField(max_length=255, null=True, blank=True)

    class Meta:
        unique_together = ("name", "number")

    def __str__(self):
        if self.number:
            return f"{self.name}: {self.number}"
        return f"{self.name}"

    @property
    def roll_count(self):
        """
        Returns number of rolls stored in the warehouse.
        """
        return len(
            list(
                TurfRoll.objects.filter(location_id=self.id).exclude(
                    status=TurfRoll.Status.DEPLETED
                )
            )
        )


class RollSpec(TimeStampedModel, models.Model):
    """"""

    category = models.ForeignKey(Category, on_delete=models.DO_NOTHING)
    color = models.ForeignKey(Color, on_delete=models.DO_NOTHING)
    height = models.ForeignKey(Height, on_delete=models.DO_NOTHING)
    width = models.ForeignKey(Width, on_delete=models.DO_NOTHING)
    length = models.FloatField(default=settings.DEFAULT_ROLL_LENGTH)

    class Meta:
        unique_together = ("category", "color", "height", "width", "length")
        verbose_name_plural = "Roll Specs"

    def __str__(self):
        return self.code

    @property
    def is_turf(self):
        """
        Return True if the roll spec is for TurfRoll.
        """
        return self.category.name.lower() == "grass"

    @property
    def sale_by(self):
        """
        Return unit of the roll
        """
        if self.is_turf:
            return "m²"
        elif "tape" in self.category.name.lower():
            return "m"
        else:
            return "each"

    @property
    def code(self):
        """
        Return the spec code.
        """
        if self.is_turf:
            height = "%.0f" % self.height.value
            width = "%.0f" % self.width.value
            return f"{height}{self.color.name.upper()[0]}-{width}"
        elif "tape" in self.category.name.lower():
            return "JT-%.0f" % self.length
        elif "flag" in self.category.name.lower():
            return f"{self.category} - {self.color}"
        else:
            return self.category.name


class Product(TimeStampedModel, models.Model):
    """
    Products available.
    """

    spec = models.ForeignKey(
        RollSpec, on_delete=models.DO_NOTHING, blank=True, null=True
    )
    code = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.code}"

    @property
    def name(self):
        if self.spec:
            if self.spec.is_turf:
                return "Artificial Grass"
            else:
                return self.spec.category
        return "Discount"

    @property
    def description(self):
        if self.spec:
            if self.spec.is_turf:
                return (
                    f"Color: {self.spec.color.name}; "
                    f"Height: {self.spec.height.value}mm; "
                    f"Width: {self.spec.width.value}m"
                )
            elif "tape" in self.spec.category.name.lower():
                return f"Width: {self.spec.width.value}m; Length: {self.spec.length}m"
            else:
                return ""
        else:
            return "Discount that was applied to this order."

    def save(self, *args, **kwargs):
        self.code = self.spec.code
        super(Product, self).save(*args, **kwargs)

    @property
    def has_stock(self):
        return bool(
            TurfRoll.objects.filter(spec=self.spec).exclude(
                status__exact=TurfRoll.Status.DEPLETED
            )
        )

    @property
    def roll_count(self):
        """
        Returns number of available rolls.
        """
        return len(
            list(
                TurfRoll.objects.filter(spec=self.spec).exclude(
                    status=TurfRoll.Status.DEPLETED
                )
            )
        )

    @property
    def stock_available(self):
        """
        Return the available square meters for a roll.
        """
        return sum(
            roll.available
            for roll in TurfRoll.objects.exclude(
                status__exact=TurfRoll.Status.DEPLETED
            ).filter(spec=self.spec)
        )


class Batch(TimeStampedModel, models.Model):
    """
    Stock batches
    """

    class Meta:
        verbose_name_plural = "Batches"

    number = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.number}"

    @property
    def total_sale(self):
        """
        Return total sales of all product from this bactch.
        """
        from sales.models import Order, OrderLine

        result = (
            OrderLine.objects.filter(order__status=Order.Status.CLOSED)
            .filter(roll__batch__number=self.number)
            .aggregate(Sum("total"))
        )
        return float(result.get("total__sum"))


class TurfRoll(TimeStampedModel, models.Model):
    """
    Rolls stored in the warehouse.
    """

    class Meta:
        verbose_name_plural = "Turf Rolls"

    class Status(models.TextChoices):
        SEALED = "SEALED", _("Sealed")
        OPENED = "OPENED", _("Opened")
        DEPLETED = "DEPLETED", _("Depleted")
        RETURNED = "RETURNED", _("Returned")
        LOOSE = "LOOSE", _("Loose")

    status = models.CharField(
        max_length=63,
        choices=Status.choices,
        default=Status.SEALED,
    )
    spec = models.ForeignKey(RollSpec, on_delete=models.DO_NOTHING)
    total = models.IntegerField(default=0)
    original_size = models.IntegerField(default=0)
    sold = models.IntegerField(default=0)
    location = models.ForeignKey(
        Warehouse, on_delete=models.DO_NOTHING, blank=True, null=True
    )
    batch = models.ForeignKey(
        Batch, on_delete=models.DO_NOTHING, blank=True, null=True
    )
    note = models.TextField(max_length=511, blank=True, null=True)

    def __str__(self):
        return f"{self.id}: {self.spec.code} - {self.status}   - available:{self.available}"

    def save(self, *args, **kwargs):
        if self.original_size == self.sold:
            self.status = self.Status.DEPLETED
            self.location = None
        if self.total != self.original_size - self.sold:
            self.total = self.original_size - self.sold
        super().save(*args, **kwargs)

    @property
    def status_color(self):
        if self.status == TurfRoll.Status.DEPLETED:
            return "outline-secondary"
        if self.status == TurfRoll.Status.OPENED:
            return "success"
        if self.status == TurfRoll.Status.SEALED:
            return "info"
        if self.status == TurfRoll.Status.RETURNED:
            return "warning"
        if self.status == TurfRoll.Status.LOOSE:
            return "outline-success"

    @property
    def reserved(self):
        """
        This is amount reserved on this roll from orders in [DRAFT, SUBMITTED].
        """
        from sales.models import Order

        result = (
            self.orderline_set.filter(
                order__status__in=[
                    Order.Status.DRAFT,
                    Order.Status.SUBMITTED,
                    Order.Status.INVOICED,
                    Order.Status.DELIVERED,
                ]
            )
            .exclude(product=None, roll=None)
            .aggregate(Sum("quantity"))
        )
        if result.get("quantity__sum"):
            return float(result.get("quantity__sum"))
        return 0

    @property
    def blank(self):
        """
        For visualizing the returned rolls.
        status.
        """
        return float(
            self.spec.width.value * self.spec.length - self.original_size
        )

    @property
    def available(self):
        """
        Total minus delivered and reserved.
        status.
        """
        return float(self.original_size - self.reserved - self.sold)
