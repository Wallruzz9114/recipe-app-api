from django.test import TestCase
from ..models import Recipe
from.test_users import sample_user


class RecipeTests(TestCase):
    def test_recipe_str(self):
        '''Test the recipe string representation'''
        recipe = Recipe.objects.create(
            user=sample_user(),
            title='Steak and mushroom sauce',
            time_minutes=5,
            price=5.00
        )

        self.assertEqual(str(recipe), recipe.title)
