# How To Use unittest to Write a Test Case for a Function in Python

By [David Muller](https://www.digitalocean.com/community/users/davidmuller)

### Introduction

The Python standard library includes the `unittest` module to help you write and run tests for your Python code.

Tests written using the `unittest` module can help you find bugs in your programs, and prevent regressions from occurring as you change your code over time. Teams adhering to [test-driven development](https://en.wikipedia.org/wiki/Test-driven_development) may find `unittest` useful to ensure all authored code has a corresponding set of tests.

In this tutorial, you will use Python’s `unittest` module to write a test for a function.

Prerequisites
-------------

To get the most out of this tutorial, you’ll need:

*   An understanding of functions in Python. You can review the [How To Define Functions in Python 3](https://www.digitalocean.com/community/tutorials/how-to-define-functions-in-python-3) tutorial, which is part of the [How To Code in Python 3](https://www.digitalocean.com/community/tutorial_series/how-to-code-in-python-3) series.

Defining a `TestCase` Subclass
------------------------------

One of the most important classes provided by the `unittest` module is named `TestCase`. `TestCase` provides the general scaffolding for testing our functions. Let’s consider an example:

**test\_add\_fish\_to\_aquarium.py**

```python
import unittest

def add_fish_to_aquarium(fish_list):
    if len(fish_list) > 10:
        raise ValueError("A maximum of 10 fish can be added to the aquarium")
    return {"tank_a": fish_list}
```

```python
class TestAddFishToAquarium(unittest.TestCase):
    def test_add_fish_to_aquarium_success(self):
        actual = add_fish_to_aquarium(fish_list=["shark", "tuna"])
        expected = {"tank_a": ["shark", "tuna"]}
        self.assertEqual(actual, expected)
```


First we import `unittest` to make the module available to our code. We then define the function we want to test—here it is `add_fish_to_aquarium`.

In this case our `add_fish_to_aquarium` function accepts a list of fish named `fish_list`, and raises an error if `fish_list` has more than 10 elements. The function then returns a dictionary mapping the name of a fish tank `"tank_a"` to the given `fish_list`.

A class named `TestAddFishToAquarium` is defined as a subclass of `unittest.TestCase`. A method named `test_add_fish_to_aquarium_success` is defined on `TestAddFishToAquarium`. `test_add_fish_to_aquarium_success` calls the `add_fish_to_aquarium` function with a specific input and verifies that the actual returned value matches the value we’d expect to be returned.

Now that we’ve defined a `TestCase` subclass with a test, let’s review how we can execute that test.

Executing a `TestCase`
----------------------

In the previous section, we created a `TestCase` subclass named `TestAddFishToAquarium`. From the same directory as the `test_add_fish_to_aquarium.py` file, let’s run that test with the following command:

```bash
python -m unittest test_add_fish_to_aquarium.py    
```

We invoked the Python library module named `unittest` with `python -m unittest`. Then, we provided the path to our file containing our `TestAddFishToAquarium` `TestCase` as an argument.

After we run this command, we receive output like the following:

    Output.
    ----------------------------------------------------------------------
    Ran 1 test in 0.000s
    
    OK


The `unittest` module ran our test and told us that our test ran `OK`. The single `.` on the first line of the output represents our passed test.

**Note:** `TestCase` recognizes test methods as any method that begins with `test`. For example, `def test_add_fish_to_aquarium_success(self)` is recognized as a test and will be run as such. `def example_test(self)`, conversely, would not be recognized as a test because it does not begin with `test`. Only methods beginning with `test` will be run and reported when you run `python -m unittest ...`.

Now let’s try a test with a failure.

We modify the following highlighted line in our test method to introduce a failure:

**test\_add\_fish\_to\_aquarium.py**

```python
import unittest

def add_fish_to_aquarium(fish_list):
    if len(fish_list) > 10:
        raise ValueError("A maximum of 10 fish can be added to the aquarium")
    return {"tank_a": fish_list}
```

```python
class TestAddFishToAquarium(unittest.TestCase):
    def test_add_fish_to_aquarium_success(self):
        actual = add_fish_to_aquarium(fish_list=["shark", "tuna"])
        expected = {"tank_a": ["rabbit"]}     # <--- This should raise an error
        self.assertEqual(actual, expected)
```


The modified test will fail because `add_fish_to_aquarium` won’t return `"rabbit"` in its list of fish belonging to `"tank_a"`. Let’s run the test.

Again, from the same directory as `test_add_fish_to_aquarium.py` we run:

```bash
python -m unittest test_add_fish_to_aquarium.py
```

When we run this command, we receive output like the following:

    OutputF
    ======================================================================
    FAIL: test_add_fish_to_aquarium_success (test_add_fish_to_aquarium.TestAddFishToAquarium)
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "test_add_fish_to_aquarium.py", line 13, in test_add_fish_to_aquarium_success
        self.assertEqual(actual, expected)
    AssertionError: {'tank_a': ['shark', 'tuna']} != {'tank_a': ['rabbit']}
    - {'tank_a': ['shark', 'tuna']}
    + {'tank_a': ['rabbit']}
    
    ----------------------------------------------------------------------
    Ran 1 test in 0.001s
    
    FAILED (failures=1)


The failure output indicates that our test failed. The actual output of `{'tank_a': ['shark', 'tuna']}` did not match the (incorrect) expectation we added to `test_add_fish_to_aquarium.py` of: `{'tank_a': ['rabbit']}`. Notice also that instead of a `.`, the first line of the output now has an `F`. Whereas `.` characters are outputted when tests pass, `F` is the output when `unittest` runs a test that fails.

Now that we’ve written and run a test, let’s try writing another test for a different behavior of the `add_fish_to_aquarium` function.

Testing a Function that Raises an Exception
-------------------------------------------

`unittest` can also help us verify that the `add_fish_to_aquarium` function raises a `ValueError` Exception if given too many fish as input. Let’s expand on our earlier example, and add a new test method named `test_add_fish_to_aquarium_exception`:

**test\_add\_fish\_to\_aquarium.py**

```python
import unittest

def add_fish_to_aquarium(fish_list):
    if len(fish_list) > 10:
        raise ValueError("A maximum of 10 fish can be added to the aquarium")
    return {"tank_a": fish_list}
```

```python
class TestAddFishToAquarium(unittest.TestCase):
    def test_add_fish_to_aquarium_success(self):
        actual = add_fish_to_aquarium(fish_list=["shark", "tuna"])
        expected = {"tank_a": ["shark", "tuna"]}
        self.assertEqual(actual, expected)

    def test_add_fish_to_aquarium_exception(self):
        too_many_fish = ["shark"] * 25
        with self.assertRaises(ValueError) as exception_context:
            add_fish_to_aquarium(fish_list=too_many_fish)
        self.assertEqual(
            str(exception_context.exception),
            "A maximum of 10 fish can be added to the aquarium"
        )
```


The new test method `test_add_fish_to_aquarium_exception` also invokes the `add_fish_to_aquarium` function, but it does so with a 25 element long list containing the string `"shark"` repeated 25 times.

`test_add_fish_to_aquarium_exception` uses the `with self.assertRaises(...)` [context manager](https://docs.python.org/3/reference/datamodel.html#context-managers) provided by `TestCase` to check that `add_fish_to_aquarium` rejects the inputted list as too long. The first argument to `self.assertRaises` is the Exception class that we expect to be raised—in this case, `ValueError`. The `self.assertRaises` context manager is bound to a variable named `exception_context`. The `exception` attribute on `exception_context` contains the underlying `ValueError` that `add_fish_to_aquarium` raised. When we call `str()` on that `ValueError` to retrieve its message, it returns the correct exception message we expected.

From the same directory as `test_add_fish_to_aquarium.py`, let’s run our test:

```bash
python -m unittest test_add_fish_to_aquarium.py
```

When we run this command, we receive output like the following:

    Output..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s
    
    OK


Notably, our test would have failed if `add_fish_to_aquarium` either didn’t raise an Exception, or raised a different Exception (for example `TypeError` instead of `ValueError`).

**Note:** `unittest.TestCase` exposes a number of other methods beyond `assertEqual` and `assertRaises` that you can use. The full list of assertion methods can be found [in the documentation](https://docs.python.org/3/library/unittest.html), but a selection are included here:

| Method                 | Assertion          |
| ---------------------- | ------------------ |
| `assertEqual(a, b)`    | `a == b`           | 
| `assertNotEqual(a, b)` | `a != b`           | 
| `assertTrue(a)`        | `bool(a) is True`  | 
| `assertFalse(a)`       | `bool(a) is False` | 
| `assertIsNone(a)`      | `a is None`        | 
| `assertIsNotNone(a)`   | `a is not None`    |  
| `assertIn(a, b)`       | `a in b`           | 
| `assertNotIn(a, b)`    | `a not in b`       | 

Now that we’ve written some basic tests, let’s see how we can use other tools provided by `TestCase` to harness whatever code we are testing.

Using the `setUp` Method to Create Resources
--------------------------------------------

`TestCase` also supports a `setUp` method to help you create resources on a per-test basis. `setUp` methods can be helpful when you have a common set of preparation code that you want to run before each and every one of your tests. `setUp` lets you put all this preparation code in a single place, instead of repeating it over and over for each individual test.

Let’s take a look at an example:

**test\_fish\_tank.py**

```python
import unittest

class FishTank:
    def __init__(self):
        self.has_water = False

    def fill_with_water(self):
        self.has_water = True

class TestFishTank(unittest.TestCase):
    def setUp(self):
        self.fish_tank = FishTank()

    def test_fish_tank_empty_by_default(self):
        self.assertFalse(self.fish_tank.has_water)

    def test_fish_tank_can_be_filled(self):
        self.fish_tank.fill_with_water()
        self.assertTrue(self.fish_tank.has_water)
```

`test_fish_tank.py` defines a class named `FishTank`. `FishTank.has_water` is initially set to `False`, but can be set to `True` by calling `FishTank.fill_with_water()`. The `TestCase` subclass `TestFishTank` defines a method named `setUp` that instantiates a new `FishTank` instance and assigns that instance to `self.fish_tank`.

Since `setUp` is run before every individual test method, a new `FishTank` instance is instantiated for both `test_fish_tank_empty_by_default` and `test_fish_tank_can_be_filled`. `test_fish_tank_empty_by_default` verifies that `has_water` starts off as `False`. `test_fish_tank_can_be_filled` verifies that `has_water` is set to `True` after calling `fill_with_water()`.

From the same directory as `test_fish_tank.py`, we can run:

```bash
python -m unittest test_fish_tank.py
```


If we run the previous command, we will receive the following output:

    Output..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s
    
    OK


The final output shows that the two tests both pass.

`setUp` allows us to write preparation code that is run for all of our tests in a `TestCase` subclass.

**Note:** If you have multiple test files with `TestCase` subclasses that you’d like to run, consider using `python -m unittest discover` to run more than one test file. Run `python -m unittest discover --help` for more information.

Using the `tearDown` Method to Clean Up Resources
-------------------------------------------------

`TestCase` supports a counterpart to the `setUp` method named `tearDown`. `tearDown` is useful if, for example, we need to clean up connections to a database, or modifications made to a filesystem after each test completes. We’ll review an example that uses `tearDown` with filesystems:

test\_advanced\_fish\_tank.py

```python
import os
import unittest

class AdvancedFishTank:
    def __init__(self):
        self.fish_tank_file_name = "fish_tank.txt"
        default_contents = "shark, tuna"
        with open(self.fish_tank_file_name, "w") as f:
            f.write(default_contents)

    def empty_tank(self):
        os.remove(self.fish_tank_file_name)
    
    class TestAdvancedFishTank(unittest.TestCase):
        def setUp(self):
            self.fish_tank = AdvancedFishTank()
    
        def tearDown(self):
            self.fish_tank.empty_tank()
    
        def test_fish_tank_writes_file(self):
            with open(self.fish_tank.fish_tank_file_name) as f:
                contents = f.read()
            self.assertEqual(contents, "shark, tuna")
```

`test_advanced_fish_tank.py` defines a class named `AdvancedFishTank`. `AdvancedFishTank` creates a file named `fish_tank.txt` and writes the string `"shark, tuna"` to it. `AdvancedFishTank` also exposes an `empty_tank` method that removes the `fish_tank.txt` file. The `TestAdvancedFishTank` `TestCase` subclass defines both a `setUp` and `tearDown` method.

The `setUp` method creates an `AdvancedFishTank` instance and assigns it to `self.fish_tank`. The `tearDown` method calls the `empty_tank` method on `self.fish_tank`: this ensures that the `fish_tank.txt` file is removed after each test method runs. This way, each test starts with a clean slate. The `test_fish_tank_writes_file` method verifies that the default contents of `"shark, tuna"` are written to the `fish_tank.txt` file.

From the same directory as `test_advanced_fish_tank.py` let’s run:

```bash
python -m unittest test_advanced_fish_tank.py
```

We will receive the following output:

    Output.
    ----------------------------------------------------------------------
    Ran 1 test in 0.000s
    
    OK


`tearDown` allows you to write cleanup code that is run for all of your tests in a `TestCase` subclass.

Conclusion
----------

In this tutorial, you have written `TestCase` classes with different assertions, used the `setUp` and `tearDown` methods, and run your tests from the command line.

The `unittest` module exposes additional classes and utilities that you did not cover in this tutorial. Now that you have a baseline, you can use [the `unittest` module’s documentation](https://docs.python.org/3/library/unittest.html) to learn more about other available classes and utilities. You may also be interested in [How To Add Unit Testing to Your Django Project](https://www.digitalocean.com/community/tutorials/how-to-add-unit-testing-to-your-django-project).

<sub>via [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-unittest-to-write-a-test-case-for-a-function-in-python)</sub>