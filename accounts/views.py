from django.urls import reverse_lazy
from datetime import timedelta
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.views.generic import TemplateView, UpdateView, DeleteView, \
    DetailView, ListView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin

from sales.models import Order


@login_required
def home(request):
    count = User.objects.count()
    recent_orders = Order.objects.filter(created__gt=timezone.now()-timedelta(7))
    return render(request, "home.html", {
        "count": count,
        "recent_orders": recent_orders
    })


@login_required
def secret_page(request):
    return render(request, 'secret_page.html')


class SecretPage(LoginRequiredMixin, TemplateView):
    template_name = 'secret_page.html'
