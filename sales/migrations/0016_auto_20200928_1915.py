# Generated by Django 3.1.1 on 2020-09-28 19:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0015_auto_20200920_1049'),
    ]

    operations = [
        migrations.AlterField(
            model_name='orderline',
            name='buyer_product',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='sales.buyerproduct'),
        ),
    ]
