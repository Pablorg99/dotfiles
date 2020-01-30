import unittest
from src.kata import Class


class TestClass(unittest.TestCase):
    def test_method(self):
        return_value = Class().method()

        self.assertEqual("green test", return_value)


if __name__ == '__main__':
    unittest.main()
