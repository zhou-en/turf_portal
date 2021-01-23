import logging
from datetime import datetime, timedelta

from django.db.models import Sum
from django.shortcuts import render, redirect
from django.urls import reverse_lazy
from django.http import JsonResponse, HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import View, DetailView, ListView, CreateView, UpdateView, DeleteView

from expense.models import Expense
from expense.forms import (
    ExpenseCreateForm,
    ExpenseUpdateForm
)
from invoice.models import Payment

logger = logging.getLogger(__name__)


@login_required
def landing(request):
    # count = User.objects.count()
    # # Option 2
    # recent_orders = Order.objects.exclude(
    #     status__exact=Order.Status.CLOSED
    # ).filter(created__gt=timezone.now()-timedelta(7)).order_by("modified")
    return render(request, "expense/landing.html", {
        # "count": count,
        # "recent_orders": recent_orders
    })


# Create your views here.
@method_decorator(login_required, name='dispatch')
class ExpenseListView(ListView):
    model = Expense
    template_name = "expense/list.html"
    context_object_name = 'expenses'
    queryset = Expense.objects.all()

@method_decorator(login_required, name='dispatch')
class ExpenseDetailView(DetailView):
    model = Expense
    template_name = 'expense/detail.html'
    context_object_name = "expense"


@method_decorator(login_required, name='dispatch')
class ExpenseCreateView(CreateView):
    model = Expense
    template_name = 'expense/create.html'
    form_class = ExpenseCreateForm

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            return super(ExpenseCreateView, self).post(request, *args, **kwargs)

    def get_success_url(self):
        return reverse_lazy("expense", kwargs={"pk": self.object.id})


@method_decorator(login_required, name="dispatch")
class ExpenseUpdateView(UpdateView):
    model = Expense
    template_name = "expense/update.html"
    context_object_name = "expense"
    form_class = ExpenseUpdateForm

    def get_success_url(self):
        return reverse_lazy("expenses")

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("expense-landing"))
        else:
            return super(ExpenseUpdateView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name="dispatch")
class ExpenseDeleteView(DeleteView):
    model = Expense
    context_object_name = "expense"
    template_name = "expense/delete.html"

    def get_success_url(self):
        return reverse_lazy("expenses")


@login_required
def search_expense(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    # Add one day to end_date so that it inclusive both start and end dates
    end_date = (datetime.strptime(end_date, "%Y-%m-%d") + timedelta(days=1)).strftime("%Y-%m-%d")

    queryset = Expense.objects.filter(date__range=[start_date, end_date])
    logger.info(f"Search expense between {start_date} and {end_date}")

    income = Payment.objects.filter(created__range=[start_date, end_date]).aggregate(Sum("amount"))
    logger.info(f"Search paymemnt between {start_date} and {end_date}")
    total_income  = income.get("amount__sum") or 0

    data = {
        "results": [],
        "total_income": total_income
    }
    for expense in queryset:
        data['results'].append(
            {
                "id".upper(): expense.id,
                "date".upper(): expense.date.strftime("%Y-%m-%d"),
                "description".upper(): expense.description,
                "method".upper(): expense.method,
                "amount".upper(): expense.amount
            }
        )

    return JsonResponse(data)
