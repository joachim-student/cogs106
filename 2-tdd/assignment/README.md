# Signal Detection Theory

Signal detection theory is a statistical framework for understanding the performance of human observers (or machines) in detecting signals in noise. It provides a mathematical description of how well the observer can discriminate between signal and noise, and how they balance the trade-off between detecting signals and avoiding false alarms. 

## Background material on SDT

- Introduction to Signal Detection Theory. [[video](https://youtu.be/bekyQYaG9cc)] [[slides](https://osf.io/e7kpq/)]
- Signal Detection Theory modeling of recognition memory. [[video](https://youtu.be/Q3TeIdPvmP4)] [[slides](https://osf.io/byune/)]
- An application of signal detection theory to shape perception. [[video](https://youtu.be/KxLMqBAPpXw)] [[slides](https://osf.io/vn4su/)] 
- Text by David Heeger [[pdf](https://www.cns.nyu.edu/~david/handouts/sdt-advanced.pdf)]

## Formulas

The following formulas are the core of signal detection theory:

### Hit Rate
The hit rate (H) is the proportion of signal trials that are correctly detected by the observer. It is calculated as:

H = hits / (hits + misses)

where `hits` is the number of correctly detected signals, and `misses` is the number of signals that were not detected.

### False Alarm Rate
The false alarm rate (FA) is the proportion of noise trials that are incorrectly detected as signals by the observer. It is calculated as:

FA = false alarms / (false alarms + correct rejections)

where `false alarms` is the number of noise trials that were incorrectly detected as signals, and `correct rejections` is the number of noise trials that were correctly identified as noise.

### d-prime (d')
d-prime (d') is a measure of the observer's sensitivity to the signal, defined as the difference between the standard deviations of the distributions of signal and noise:

d' = Z(H) - Z(FA)

where Z(H) is the standard normal deviate of the hit rate and Z(FA) is the standard normal deviate of the false alarm rate.  The function Z() is the inverse cumulative distribution function of the standard normal distribution.

### Criterion (C)
The criterion (C) is a measure of the observer's response bias, defined as the point above which the participant will decide "signal":

C = -0.5 * (Z(H) + Z(FA))

where Z(H) and Z(FA) are as defined above.

## Implementing Signal Detection Theory
In this assignment, you will write a class in either MATLAB or Python that implements the formulas described above. The class should at least have the following methods:

- `d_prime`: Returns the d-prime value given the hit rate and false alarm rate.
- `criterion`: Returns the criterion value given the hit rate and false alarm rate.

Your implementation should pass the unit test suite provided in the class repository.  Your grade will be based on the passing of the suite.

Additionally, you should not rely on too many external modules or packages.  MATLAB users may use the `Statistics and Machine Learning Toolbox` and python users may use `numpy` and `scipy`.  Python 3.8 is preferred.

---

## Some hints to get started

1. Start by checking out the test suites ([MATLAB](https://github.com/joachim-student/cogs106/tree/master/2-tdd/assignment/m), [python](https://github.com/joachim-student/cogs106/tree/master/2-tdd/assignment/py)) to get an idea of what they expect.
2. Use the BayesFactor class ([MATLAB](https://github.com/joachim-student/cogs106/tree/master/2-tdd/m), [python](https://github.com/joachim-student/cogs106/tree/master/2-tdd/py)) as a template.
3. Start writing your class with the constructor method, which takes four inputs in the right order: `SignalDetection(hits, misses, falaseAlarms, correctRejections)`

---

Good luck!
