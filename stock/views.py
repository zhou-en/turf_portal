import logging
from django.urls import reverse_lazy
from django.db.models import Q
from django.utils.translation import gettext_lazy as _
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import (
    UpdateView,
    DeleteView,
    DetailView,
    ListView,
    CreateView,
)
from rest_framework.response import Response
from rest_framework.views import APIView

from stock.models import Product, TurfRoll, Warehouse, RollSpec
from stock.forms import (
    ProductCreateForm,
    ProductUpdateForm,
    LoadStocksForm,
    SplitRollForm,
    RollUpdateForm,
)

logger = logging.getLogger(__name__)


# Create your views here.
@method_decorator(login_required, name="dispatch")
class ProductListView(ListView):
    model = Product
    template_name = "stock/products.html"
    context_object_name = "products"
    queryset = Product.objects.all()

    def get_context_data(self, **kwargs):
        context = super(ProductListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name="dispatch")
class ProductCreateView(CreateView):
    model = Product
    template_name = "stock/product_create.html"
    success_url = reverse_lazy("products")
    form_class = ProductCreateForm

    def get_form(self, form_class=None):
        form = super().get_form()
        existing_product_specs = [product.spec.id for product in Product.objects.all()]
        spec_choices = [(None, _("Select a spec for product"))]
        for spec in RollSpec.objects.all().exclude(id__in=existing_product_specs):
            spec_choices.extend([(spec.id, _(spec.code))])
        form.fields["spec"].choices = spec_choices
        return form

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("products"))
        else:
            spec_id = self.request.POST.get("spec")
            Product.objects.create(
                spec_id=spec_id,
            )
            return HttpResponseRedirect(reverse_lazy("products"))


@method_decorator(login_required, name="dispatch")
class ProductDetailView(DetailView):
    model = Product
    template_name = "stock/product.html"
    context_object_name = "product"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["available_rolls"] = TurfRoll.objects.filter(
            spec=self.object.spec
        ).order_by("status")

        return context


@method_decorator(login_required, name="dispatch")
class ProductUpdateView(UpdateView):
    model = Product
    template_name = "stock/product_update.html"
    context_object_name = "product"
    form_class = ProductUpdateForm

    def get_success_url(self):
        return reverse_lazy("product", kwargs={"pk": self.object.id})

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("buyers"))
        else:
            return super(ProductUpdateView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name="dispatch")
class ProductDeleteView(DeleteView):
    model = Product
    template_name = "stock/product_delete.html"
    success_url = reverse_lazy("products")

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("products"))
        else:
            return super(ProductDeleteView, self).post(request, *args, **kwargs)


@method_decorator(login_required, name="dispatch")
class WarehouseDetailView(DetailView):
    model = Warehouse
    template_name = "stock/warehouse.html"
    context_object_name = "warehouse"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["stored_rolls"] = TurfRoll.objects.filter(
            location_id=self.object.id
        ).filter(~Q(status=TurfRoll.Status.DEPLETED))

        return context


@method_decorator(login_required, name="dispatch")
class WarehouseListView(ListView):
    model = Warehouse
    template_name = "stock/warehouses.html"
    context_object_name = "warehouses"
    queryset = Warehouse.objects.all()
    # paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super(WarehouseListView, self).get_context_data(**kwargs)
        return context


@method_decorator(login_required, name="dispatch")
class StockDataView(APIView):
    """"""

    authentication_classes = []
    permission_classes = []

    def get(self, request, format=None):
        labels = ["Available", "Sold", "Reserved", "Blank"]
        data = {}
        for roll in TurfRoll.objects.exclude(status__exact=TurfRoll.Status.DEPLETED):
            code = roll.spec.code
            default_data = [roll.available, roll.sold, roll.reserved]
            if roll.status == TurfRoll.Status.LOOSE:
                default_data.append(roll.blank)
            else:
                default_data.append(0)
            data.update(
                {
                    roll.id: {
                        "code": code,
                        "labels": labels,
                        "default": default_data,
                    }
                }
            )
        return Response(data)


@method_decorator(login_required, name="dispatch")
class StockListView(ListView):
    model = TurfRoll
    template_name = "stock/stocks.html"
    context_object_name = "turf_rolls"
    queryset = TurfRoll.objects.all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["turf_rolls"] = {}
        context["all_rolls"] = TurfRoll.objects.all().order_by("spec__product__code")
        specs = RollSpec.objects.all()
        status_order = [
            TurfRoll.Status.LOOSE,
            TurfRoll.Status.OPENED,
            TurfRoll.Status.SEALED,
            # TurfRoll.Status.DEPLETED,
        ]

        for spec in specs:
            if spec.turfroll_set.exists():
                rolls = []
                for s in status_order:
                    if spec.turfroll_set.filter(status=s):
                        rolls.extend(spec.turfroll_set.filter(status=s))
                if rolls:
                    context["turf_rolls"].update({spec: rolls})
        return context


@method_decorator(login_required, name="dispatch")
class LoadStocksView(CreateView):
    model = TurfRoll
    template_name = "stock/load_stocks.html"
    success_url = reverse_lazy("stocks")
    context_object_name = "turf_roll"
    form_class = LoadStocksForm

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("stocks"))
        else:
            logger.debug("Start loading stock ...")
            quantity = int(request.POST.get("quantity"))
            status = request.POST.get("status").upper()
            batch_id = request.POST.get("batch")
            spec = RollSpec.objects.get(id=request.POST.get("spec"))
            location = Warehouse.objects.get(id=request.POST.get("location"))
            if status != TurfRoll.Status.LOOSE:
                for n in range(int(quantity)):
                    logger.info("Loading %s: %d", spec, n)

                    if spec.is_turf:
                        TurfRoll.objects.create(
                            spec=spec,
                            batch_id=batch_id,
                            location=location,
                            total=spec.length * spec.width.value,
                            original_size=spec.length * spec.width.value,
                        )
                    else:
                        TurfRoll.objects.create(
                            spec=spec,
                            batch_id=batch_id,
                            location=location,
                            total=spec.length,
                            original_size=spec.length,
                        )
                logger.info(
                    "%s %s rolls have been loaded to %s", quantity, spec, location
                )
            else:
                loose_size = int(request.POST.get("size"))
                for n in range(int(quantity)):
                    logger.info("Loading loose %s: %d", spec, n)
                    TurfRoll.objects.create(
                        spec=spec,
                        location=location,
                        total=loose_size,
                        original_size=loose_size,
                        status=TurfRoll.Status.LOOSE,
                    )
                logger.info(
                    "%s %s loose rolls have been loaded to %s", quantity, spec, location
                )
        return HttpResponseRedirect(reverse_lazy("stocks"))


@method_decorator(login_required, name="dispatch")
class SplitRollView(CreateView):
    model = TurfRoll
    template_name = "stock/split_stock.html"
    success_url = reverse_lazy("stocks")
    form_class = SplitRollForm

    def get_context_data(self, **kwargs):
        roll = TurfRoll.objects.get(id=self.kwargs.get("pk"))
        context = super().get_context_data(**kwargs)
        context["roll"] = roll
        return context

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("stocks"))
        else:
            roll_pk = self.kwargs.get("pk")
            split_size = float(self.request.POST.get("size"))
            roll = TurfRoll.objects.get(id=roll_pk)
            new_roll = TurfRoll.objects.create(
                spec=roll.spec,
                batch=roll.batch,
                location=roll.location,
                total=split_size,
                original_size=split_size,
                status=TurfRoll.Status.LOOSE,
            )
            if roll.status == TurfRoll.Status.SEALED:
                roll.status = TurfRoll.Status.LOOSE
            roll.total = roll.total - split_size
            roll.original_size = roll.original_size - split_size
            roll.save()
        return HttpResponseRedirect(reverse_lazy("stocks"))


@method_decorator(login_required, name="dispatch")
class RollUpdateView(UpdateView):
    model = TurfRoll
    template_name = "stock/roll_update.html"
    context_object_name = "roll"
    form_class = RollUpdateForm

    def get_success_url(self):
        return reverse_lazy("stocks")

    def post(self, request, *args, **kwargs):
        if "cancel" in request.POST:
            return HttpResponseRedirect(reverse_lazy("stocks"))
        else:
            return super(RollUpdateView, self).post(request, *args, **kwargs)
