# Generated by Django 3.1.1 on 2020-09-09 16:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('stock', '0006_warehouse_address'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='rollspec',
            options={'verbose_name_plural': 'Roll Specs'},
        ),
        migrations.AlterModelOptions(
            name='turfroll',
            options={'verbose_name_plural': 'Turf Rolls'},
        ),
    ]
