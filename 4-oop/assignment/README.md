## Assignment 3.  SignalDetection: The Overloading

In this assignment, you will continue developing the `SignalDetection` class that you developed in the previous assignment. This time, your goal is to refactor the existing code to eliminate any code smells you see, especially repetition of code. You will also add two new methods to the class that overload the `+` and `*` operators for the `SignalDetection` class, and write a new unit test to ensure that the class is internally consistent.

### Instructions

1. Decide with your partner whose smelly previous assignment needs more work. If you're unsure, feel free to ask me.

2. Refactor the existing code to eliminate any code smells you see, especially repetition of code. Don't try to fix a lot of things at once! Fix them one at a time and commit each update to GitHub with an informative commit message. Don't forget to keep running the unit tests.

3. Write at least one new unit test to try to corrupt your object (e.g., by changing every property after the object was constructed and testing if anything is now internally inconsistent).

4. Make any changes needed to prevent corrupt states and pass your new test. It's possible your class will pass the test without changes.

5. Overload the `+` and `*` operators for the `SignalDetection` class:
    - The `+` operator should simply add up each type of trial from two objects.
    - The `*` operator should multiply all types of trials with a scalar.

6. Add a new method called `plot_roc(objects)` to the class that generates a plot of the Receiver Operating Characteristic (ROC) curve for an array of `SignalDetection` objects.

    > **Receiver Operating Characteristic (ROC) curve**: The ROC curve is a graphical representation of the performance of a binary classifier system as the discrimination threshold is varied. It plots the hit rate (on the horizontal axis) against the false alarm rate (on the vertical axis) at various threshold settings. The area under the ROC curve is often used as a metric to evaluate the performance of a classifier.  A single `SignalDetection` object only has one threshold setting, so each element of the array is one point in the ROC curve.  (0,0) and (1,1) are on the curve by definition.

7. Add a new method called `plot_sdt()` to the class that generates a standard Signal Detection Theory (SDT) plot.

    > **Signal Detection Theory (SDT) plot**: The SDT plot is a graphical representation of the performance of a binary classification system in which the signal and noise distributions overlap. It shows the response distribution of the signal and noise trials in different colors, the location of the criterion as a vertical line, and the distance between noise and signal as a horizontal line.

### Submission Guidelines

Submit your completed assignment on GitHub as before. Your submission should include:

- The refactored code for the `SignalDetection` class _with informative commit messages._
- The new unit test you wrote to ensure that the class is internally consistent.
- The overloaded `+` and `*` operators for the class.
- The `plot_roc()` method you added to the class.
- The `plot_sdt()` method you added to the class.

You can use any file structure you like, but make sure that I can figure it out.  To be foolproof, your repository could include one `assignment2_main` file (`.py` or `.m`) that creates the object and runs the test suite.

### Grading

Your homework assignment will be graded based on the following criteria:

- How well you refactored the existing code to eliminate code smells and repetition of code.
- The quality of the new unit test you wrote to ensure that the class is internally consistent.
- How well you overloaded the `+` and `*` operators for the class.
- The quality of the `plot_roc()` method you added to the class.
- The quality of the `plot_sdt()` method you added to the class.
