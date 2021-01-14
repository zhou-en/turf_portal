# Generated by Django 3.1.1 on 2020-09-15 23:57

from django.db import migrations, models
from sales.models import Order


def update_order_number(apps, schema_editor):
    """
    All order number should be in the format of: BUYER_NAME-INV-DATE
    """
    for order in Order.objects.all():
        if "-ORD-" not in order.number:
            buyer_name = order.number.split("-")[0]
            date_str = order.number.split("-")[-1]
            new_number = f"{buyer_name}-ORD-{date_str}"
            order.number = new_number
            order.save()

class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0018_auto_20201005_1842'),
    ]

    operations = [
        migrations.RunPython(update_order_number),
    ]
