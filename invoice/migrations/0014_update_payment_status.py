# Generated by Django 3.1.1 on 2021-01-27 15:19

from django.db import migrations, models
from invoice.models import Invoice, Payment

def update_existing_payments_status(app, schema_editor):
    for inv in Invoice.objects.all():
        if inv.status == Invoice.Status.CLOSED:
            for pmt in inv.payment_set.all():
                print(f"Invoice close, updating {pmt} to CONFIRMED.")
                pmt.status = Payment.Status.CONFIRMED
                pmt.save()
        else:
            for pmt in inv.payment_set.all():
                if pmt.method == Payment.Method.EFT:
                    print(f"Updating {pmt} to PENDING")
                    pmt.status = Payment.Status.PENDING
                    pmt.save()
                else:
                    print(f"Updating {pmt} to CONFIRMED")
                    pmt.status = Payment.Status.CONFIRMED
                    pmt.save()


class Migration(migrations.Migration):

    dependencies = [
        ('invoice', '0013_payment_status'),
    ]

    operations = [
        migrations.RunPython(update_existing_payments_status),
    ]