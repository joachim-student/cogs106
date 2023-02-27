# Simulation

## Random Number Generation: Overview of Algorithms

Random number generation is the process of generating a sequence of numbers that are not predictable and have no discernible pattern. There are many algorithms for generating random numbers, but they can be broadly classified into two categories:

- Pseudorandom number generators: These are algorithms that use a deterministic process to generate a sequence of numbers that appear random, but are actually predictable if you know the algorithm and the seed value that was used to initialize it.
- True random number generators: These are algorithms that generate numbers from a source of entropy, such as atmospheric noise or radioactive decay, that are truly random and not predictable.

## Generating Random Numbers in Python

The `numpy` package provides a convenient and efficient way to generate random numbers. The `rand()` function in `numpy` generates a random float between 0 and 1.

```{python}
import numpy as np

n = np.random.rand()
print(n)  # prints a random float between 0 and 1
```

## Seeding Random Number Generators

Pseudorandom number generators use a seed value to initialize the algorithm. If you use the same seed value, you will get the same sequence of numbers every time:

```{python}
np.random.seed(1234)  # seed with a fixed value
n = np.random.rand()
print(n)  # prints 0.1915194503788923
```

By using the same seed value, we can ensure that the same random sequence is generated every time the code is run.

## Sampling from Statistical Distributions

The `normal()` function in `numpy` generates random variables from a Gaussian distribution with the specified mean and standard deviation:

```{python}
mu    = 0  # Gaussian mean
sigma = 1  # Gaussian standard deviation

n = np.random.normal(mu, sigma)
```

## More examples

Generate a sequence of 5 random integers from a binomial distribution with 10 trials and probability of success 0.5

```{python}
b = np.random.binomial(n=10, p=0.5, size=5)
```

Generate 10 numbers from a standard uniform distribution

```{python}
n = np.random.rand(10)
```

Generate 10 integers from a discrete uniform between 1 and 100

```{python}
du = np.random.randint(1, 101, size=10)
```

Generate SDT data from 100 signal and 10 noise trials

```{python}
hr, far, nSig, nNoi = .6, .4, 100, 10
hits, fas = np.random.binomial(n=[nSig, nNoi], p=[hr, far])
```