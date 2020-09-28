from django.db.models.signals import pre_delete
from django.dispatch import receiver

from sales.models import BuyerProduct, OrderLine


@receiver(pre_delete, sender=BuyerProduct)
def product_has_stock(sender, instance, **kwargs):
    for orderline in OrderLine.objects.filter(buyer_product=instance):
        orderline.buyer_product = None
        orderline.save()
