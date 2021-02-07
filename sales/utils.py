import re
from datetime import datetime


def remove_none_alphanumeric(string):
    """
    remove non-alphanumeric characters
    """
    pattern = re.compile("[\W_]+",  re.UNICODE)
    return pattern.sub("", string)


def order_status_color(status):
    from sales.models import Order
    if status in [Order.Status.DRAFT, Order.Status.SUBMITTED]:
        return "success"
    if status == Order.Status.INVOICED:
        return "info"
    if status == Order.Status.DELIVERED:
        return "warning"
    if status == Order.Status.CLOSED:
        return "outline-secondary"


def invoice_status_color(status):
    from invoice.models import Invoice
    if status == Invoice.Status.DRAFT:
        return "success"
    if status == Invoice.Status.OUTSTANDING:
        return "danger"
    if status == Invoice.Status.PENDING:
        return "warning"
    if status == Invoice.Status.CLOSED:
        return "outline-secondary"


def payment_status_color(status):
    from invoice.models import Payment
    if status == Payment.Status.CONFIRMED:
        return "success"
    if status == Payment.Status.PENDING:
        return "warning"


def buyer_status_color(status):
    from sales.models import Buyer
    if status == Buyer.Status.ACTIVE:
        return "success"
    if status == Buyer.Status.INACTIVE:
        return "secondary"

def build_search_query(search_params):
    search_query = {}
    for k, v in search_params.items():
        search_query.update(
            {k: v}
        )
        if "date" in k:
            search_query.pop(k)
            date_str = [int(i) for i in v.split("-")]
            search_query.update(
                {f"{k}__date": datetime(date_str[0], date_str[1], date_str[2])}
            )
    return search_query
