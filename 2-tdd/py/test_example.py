import unittest

class TestStringMethods(unittest.TestCase):
    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')
    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())
    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        with self.assertRaises(TypeError):
            s.split(2)

# Run the tests
if __name__ == '__main__':
    unittest.main()

# If using jupyter...
if __name__ == '__main__':
    unittest.main(argv=['first-arg-is-ignored'], exit=False)
