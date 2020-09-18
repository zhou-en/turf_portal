import re



def remove_none_alphanumeric(string):
    """
    remove non-alphanumeric characters
    """
    pattern = re.compile("[\W_]+",  re.UNICODE)
    return pattern.sub("", string)


def order_status_color(status):
    from sales.models import Order
    if status == Order.Status.DRAFT or status == Order.Status.SUBMITTED:
        return "success"
    if status == Order.Status.INVOICED:
        return "primary"
    if status == Order.Status.DELIVERED:
        return "warning"
    if status == Order.Status.CLOSED:
        return "secondary"


def invoice_status_color(status):
    from invoice.models import Invoice
    if status == Invoice.Status.DRAFT:
        return "success"
    if status == Invoice.Status.PAYMENT_OUTSTANDING:
        return "danger"
    if status == Invoice.Status.CLOSED:
        return "secondary"
