# Generated by Django 3.1.1 on 2020-09-20 10:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0014_auto_20200919_1733'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='closed_date',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
