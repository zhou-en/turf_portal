from django.db.models.signals import post_save
from django.dispatch import receiver

from stock.models import Product, TurfRoll


@receiver(post_save, sender=TurfRoll)
def product_has_stock(sender, instance, created, **kwargs):
    if created:
        product = Product.objects.get(spec=instance.spec)
        product.has_stock = True
        product.save()


@receiver(post_save, sender=TurfRoll)
def product_out_stock(sender, instance, **kwargs):
    if instance.status == TurfRoll.Status.DEPLETED:
        if not TurfRoll.objects.filter(spec=instance.spec):
            product = Product.objects.get(spec=instance.spec)
            product.has_stock = False
            product.save()
