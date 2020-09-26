# Generated by Django 3.1.1 on 2020-09-20 10:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('stock', '0012_turfroll_sold'),
    ]

    operations = [
        migrations.AlterField(
            model_name='turfroll',
            name='status',
            field=models.CharField(choices=[('SEALED', 'Sealed'), ('OPENED', 'Opened'), ('DEPLETED', 'Depleted'), ('RETURNED', 'Returned')], default='SEALED', max_length=63),
        ),
    ]