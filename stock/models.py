from django.utils.translation import gettext_lazy as _
from django.db import models
from django_extensions.db.models import TimeStampedModel


# Create your models here.
class Category(TimeStampedModel, models.Model):
    """
    Category is used to classify different types of products/stocks available in the warehouse.
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
    value = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.value}"


class Width(TimeStampedModel, models.Model):
    """
    Grass roll width in meters.
    """
    value = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.value}"


class Color(TimeStampedModel, models.Model):
    """
    Grass colors.
    """
    name = models.CharField(max_length=63)

    def __str__(self):
        return f"{self.name}"


class Product(TimeStampedModel, models.Model):
    """
    Products available.
    """
    class Meta:
        unique_together = ("category", "color", "width", "height")
        # ordering = ("last_name", "first_name")

    category = models.ForeignKey(Category, on_delete=models.DO_NOTHING)
    height = models.ForeignKey(Height, on_delete=models.DO_NOTHING, blank=True, null=True, verbose_name="Height (mm)")
    width = models.ForeignKey(Width, on_delete=models.DO_NOTHING, blank=True, null=True, verbose_name="Width (m)")
    color = models.ForeignKey(Color, on_delete=models.DO_NOTHING, blank=True, null=True)
    code = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.category} - {self.color} - {self.width} m: {self.height} mm"

    def save(self, *args, **kwargs):
        self.code = f"{self.color.name.upper()[0]}{self.height.value}"
        super(Product, self).save(*args, **kwargs)
