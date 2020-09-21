from django.utils.translation import gettext_lazy as _
from django.db import models
from django.db.models import Avg, Count, Sum
from django.conf import settings
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
    value = models.IntegerField(default=settings.DEFAULT_ROLL_HEIGHT)

    def __str__(self):
        return f"{self.value}"


class Width(TimeStampedModel, models.Model):
    """
    Grass roll width in meters.
    """
    value = models.IntegerField(default=settings.DEFAULT_ROLL_WIDTH)

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
    """
    """
    category = models.ForeignKey(Category, on_delete=models.DO_NOTHING)
    color = models.ForeignKey(Color, on_delete=models.DO_NOTHING)
    height = models.ForeignKey(Height, on_delete=models.DO_NOTHING)
    width = models.ForeignKey(Width, on_delete=models.DO_NOTHING)
    length = models.IntegerField(default=settings.DEFAULT_ROLL_LENGTH)

    class Meta:
        unique_together = (
            "category", "color", "height", "width", "length"
        )
        verbose_name_plural = "Roll Specs"

    def __str__(self):
        return f"{self.category} - {self.color} - {self.height}mm - {self.width}m - {self.length}m"

    @property
    def code(self):
        """
        Return the spec code.
        """
        return f"{self.color.name.upper()[0]}{self.height.value}-{self.width.value}m"


class Product(TimeStampedModel, models.Model):
    """
    Products available.
    """
    spec = models.ForeignKey(RollSpec, on_delete=models.DO_NOTHING, blank=True, null=True)
    code = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.code}"

    @property
    def name(self):
        if self.spec.category == "Grass":
            return "Artificial Grass"
        return self.spec.category

    @property
    def description(self):
        return f"Color: {self.spec.color.name}; Height: {self.spec.height.value}mm; Width: {self.spec.width.value}m"

    def save(self, *args, **kwargs):
        self.code = f"{self.spec.color.name.upper()[0]}{self.spec.height.value}-{self.spec.width}m"
        super(Product, self).save(*args, **kwargs)

    @property
    def roll_count(self):
        """
        Returns number of available rolls.
        """
        return len(list(TurfRoll.objects.filter(spec=self.spec).exclude(status=TurfRoll.Status.DEPLETED)))

    @property
    def stock_count(self):
        """
        Return the available square meters for a roll.
        """
        square_meters = 0
        for roll in TurfRoll.objects.exclude(
                status__exact=TurfRoll.Status.DEPLETED
        ).filter(spec=self.spec):
            square_meters += roll.available
        return square_meters


class TurfRoll(TimeStampedModel, models.Model):
    """
    Rolls stored in the warehouse.
    """
    class Meta:
        verbose_name_plural = "Turf Rolls"

    class Status(models.TextChoices):
        SEALED = 'SEALED', _('Sealed')
        OPENED = 'OPENED', _('Opened')
        DEPLETED = 'DEPLETED', _('Depleted')
        RETURNED = 'RETURNED', _('Returned')

    status = models.CharField(
        max_length=63,
        choices=Status.choices,
        default=Status.SEALED,
    )
    spec = models.ForeignKey(RollSpec, on_delete=models.DO_NOTHING)
    total = models.IntegerField(default=0)
    sold = models.IntegerField(default=0)
    location = models.ForeignKey(Warehouse, on_delete=models.DO_NOTHING, blank=True, null=True)

    def __str__(self):
        return f"{self.id}: {self.spec.code} - {self.status}   - available:{self.available}"

    def save(self, *args, **kwargs):
        if not self.pk:
            self.total = self.spec.width.value * self.spec.length
        else:
            if self.total == 0:
                self.status = self.Status.DEPLETED
        super().save(*args, **kwargs)

    @property
    def status_color(self):
        if self.status == TurfRoll.Status.DEPLETED:
            return "secondary"
        if self.status == TurfRoll.Status.OPENED:
            return "success"
        if self.status == TurfRoll.Status.SEALED:
            return "info"
        if self.status == TurfRoll.Status.RETURNED:
            return "warning"

    @property
    def reserved(self):
        """
        This is amount reserved on this roll from orders in [DRAFT, SUBMITTED].
        """
        from sales.models import Order
        result = self.orderline_set.filter(
            order__status__in=[Order.Status.SUBMITTED, Order.Status.INVOICED]
        ).aggregate(Sum("quantity"))
        if result.get("quantity__sum"):
            return float(result.get("quantity__sum"))
        return 0

    @property
    def delivered(self):
        """
        This is the total amount on this roll that has orderlines with Delivered
        status.
        """
        from sales.models import Order
        result = self.orderline_set.filter(
            order__status__in=[Order.Status.DELIVERED, Order.Status.CLOSED]
        ).aggregate(Sum("quantity"))
        if result.get("quantity__sum"):
            return float(result.get("quantity__sum"))
        return 0

    @property
    def available(self):
        """
        Total minus delivered and reserved.
        status.
        """
        return float(self.spec.length * self.spec.width.value - self.reserved - self.sold)

