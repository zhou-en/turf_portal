import re


def remove_none_alphanumeric(string):
    """
    remove non-alphanumeric characters
    """
    pattern = re.compile("[\W_]+",  re.UNICODE)
    return pattern.sub("", string)


def order_status_color(status):
    from sales.models import Order
    if status in [Order.Status.DRAFT, status == Order.Status.SUBMITTED]:
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
    if status == Invoice.Status.PAYMENT_OUTSTANDING:
        return "danger"
    if status == Invoice.Status.CLOSED:
        return "outline-secondary"


def buyer_status_color(status):
    from sales.models import Buyer
    if status == Buyer.Status.ACTIVE:
        return "success"
    if status == Buyer.Status.INACTIVE:
        return "secondary"
