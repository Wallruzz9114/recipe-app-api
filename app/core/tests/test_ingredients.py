from django.test import TestCase
from ..models import Ingredient
from.test_users import sample_user


class IngredientTests(TestCase):
    def test_ingredient_str(self):
        """Test the ingredient string representation"""
        ingredient = Ingredient.objects.create(
            user=sample_user(),
            name='Cucumber'
        )

        self.assertEqual(str(ingredient), ingredient.name)
