# Generated by Django 3.1.1 on 2020-09-12 23:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('stock', '0009_auto_20200912_0817'),
    ]

    operations = [
        migrations.AddField(
            model_name='turfroll',
            name='delivered',
            field=models.IntegerField(default=0),
        ),
    ]
