# Generated by Django 3.1.1 on 2020-10-03 22:38

from django.db import migrations, models
import django.db.models.deletion
import django_extensions.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('stock', '0017_remove_product_has_stock'),
    ]

    operations = [
        migrations.CreateModel(
            name='Batch',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('number', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'verbose_name_plural': 'Batches',
            },
        ),
        migrations.AddField(
            model_name='turfroll',
            name='batch',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='stock.batch'),
        ),
    ]
