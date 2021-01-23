# Generated by Django 3.1.1 on 2021-01-20 21:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('invoice', '0011_update_invoice_number'),
    ]

    operations = [
        migrations.AlterField(
            model_name='payment',
            name='method',
            field=models.CharField(choices=[('CARD', 'Card'), ('CASH', 'Cash'), ('EFT', 'EFT'), ('OTHER', 'Other')], default='EFT', max_length=255),
        ),
    ]
