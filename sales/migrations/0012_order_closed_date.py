# Generated by Django 3.1.1 on 2020-09-16 00:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0011_auto_20200913_2112'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='closed_date',
            field=models.DateField(blank=True, null=True),
        ),
    ]