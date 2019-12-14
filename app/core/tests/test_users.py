from django.test import TestCase
from django.contrib.auth import get_user_model


class UserTests(TestCase):
    def test_create_user(self):
        '''Test - successfully creates a user with an email address'''
        email = 'test@user.com'
        password = 'testpass123'
        user = get_user_model().objects.create_user(
            email=email, password=password
        )
        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_user_emaild(self):
        '''Test - successfully checks if the new user's email is valid'''
        email = 'test@USER.COM'
        user = get_user_model().objects.create_user(
            email=email, password='test123'
        )
        self.assertEqual(user.email, email.lower())

    def test_create_invalid_user(self):
        '''Test - successfully fails when user has invalid email'''
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, password='test123')

    def test_create_superuser(self):
        '''Test - successfully creates a new superuser'''
        user = get_user_model().objects.create_superuser(
            email='test@user.com', password='test123')
        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
