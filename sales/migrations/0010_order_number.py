# Generated by Django 3.1.1 on 2020-09-12 21:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0009_auto_20200912_0914'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='number',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
