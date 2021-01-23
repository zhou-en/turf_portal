from django.contrib import admin

from expense.models import Expense


@admin.register(Expense)
class ExpenseAdmin(admin.ModelAdmin):

    def friendly_date(self, obj):
        return obj.date.strftime("%Y-%m-%d %H:%M:%S")
    friendly_date.admin_order_field = 'date'
    friendly_date.short_description = 'Friendly DateTime'

    list_display = [
        "friendly_date",
        "description",
        "method",
        "amount",
    ]
