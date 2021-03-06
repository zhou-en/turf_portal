from django.urls import path

from expense.views import (
    ExpenseListView,
    ExpenseDetailView,
    ExpenseCreateView,
    ExpenseUpdateView,
    ExpenseDeleteView,
    landing,
    search_expense
)

urlpatterns = [
    path("landing/", landing, name="expense-landing"),
    path("landing/expense/<int:pk>", ExpenseDetailView.as_view(),name="landing-expense-detail"),
    path("list/", ExpenseListView.as_view(), name="expenses"),
    path("<int:pk>/detail", ExpenseDetailView.as_view(), name="expense"),
    path("create", ExpenseCreateView.as_view(), name="expense-create"),
    path("<int:pk>/update", ExpenseUpdateView.as_view(), name="expense-update"),
    path("<int:pk>/delete", ExpenseDeleteView.as_view(), name="expense-delete"),
    path("landing/serarch", search_expense, name="search-expense"),
]
