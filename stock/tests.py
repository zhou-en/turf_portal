from django.test import TestCase

from stock.models import Batch


# Create your tests here.
class TestBatch(TestCase):
    """
    Some basic tests on Batch properties.
    """
    fixtures = ["test_fixtures/fixtures.json"]

    def setUp(self) -> None:
        pass

    def tearDown(self) -> None:
        pass

    def test_total_sale(self):
        """
        """
        batch = Batch.objects.first()
        print(batch.total_sale)
        self.assertEqual(batch.total_sale, 76350.0)
