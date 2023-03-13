# Assignment Prompt: Metropolis Algorithm

In this assignment, you will create a new class called `Metropolis`.  The class implements the Metropolis algorithm, a Markov Chain Monte Carlo (MCMC) method used for generating samples from a probability distribution. 

## Background

The Metropolis algorithm is a type of MCMC method used to generate samples from a probability distribution $p$. The algorithm proceeds by starting with an initial state $s$ and proposing a new state $s^*$ using a Gaussian proposal distribution. The acceptance probability of the proposed state is then calculated:
$$
Pr = \min\left(1, \exp\left(\frac{p(s^*)}{p(s)}\right)\right)
$$
... and compared to a randomly generated number from a standard uniform distribution. If the acceptance probability is greater than the random number, the proposed state is accepted and becomes the new state. Otherwise, the current state is retained. During the **sampling phase** this process is repeated many times to generate a sequence (a "chain") of states that converges to the target distribution.

The Gaussian proposal distribution starts with state $\mu = 0$ and standard deviation $\sigma_1 = 1$, but these values first need to be automatically adjusted so that the rate of acceptance is approximately $r_\text{target} = 0.4$.  During the **adaptation phase**, no sample sequence should be saved, only the current state.  The adaptation occurs in $K$ blocks, with a series of $n_k$ proposals being generated, the observed acceptance rate $r_k$ being computed, and the proposal standard deviation being updated by the multiplicative factor given below. 
$$
\sigma_{k+1} = \sigma_{k} \times \left(\frac{r_\text{target}}{r_{k}}\right)^{1.1}
$$
The user should choose the number and length of adaptation blocks, $n_1, n_2, \ldots, n_K$.  The final standard deviation $\sigma_K$ will be used as the standard deviation during the sampling phase.

## Assignment Details

You will implement the Metropolis algorithm as a class called `Metropolis`. The class should have the following methods:

- Constructor method:  Initializes the Metropolis object with two input arguments. `logTarget` is a function that represents the log of the probability distribution from which we want to sample.  `initialState` is the initial state.
- `yesno = accept(self, proposal)`: A **private** method that checks whether to accept or reject the proposed value `proposal` based on the acceptance probability calculated from the current state and the proposed state. It returns `True` if the proposal is accepted and `False` otherwise.
- `self = adapt(self)`: Performs the adaptation phase of the Metropolis algorithm. It tries to adjust the step size $\sigma$ to achieve a target acceptance rate of approximately 0.4. It does so by running a few blocks of iterations and adjusting the $\sigma$ value using a formula based on the acceptance rate.  
- `self = sample(self, n)`: Generates $n$ samples from the target distribution using the Metropolis algorithm. It starts from the current state and proposes a new state using a normal distribution with the current state as the mean and $\sigma_K$ as the standard deviation. If the proposed state is accepted, it becomes the new state.
- `summ = summary(self)`: Returns a dictionary or structure containing the mean and 95% credible interval of the generated samples.
- The class should have a public property called `samples` that contains the retained samples.

You may add any number of additional methods to complete the integration test.  You may change the way properties and methods and variables are named to follow the conventions of the programming language you are using.  You may update your SignalDetection class code if needed.  You may not change the integration test code.  You may add tests to the unit test class, but not edit or remove any existing ones.  Please make sure your class is defined in a file called `Metropolis.py` or `Metropolis.m`.

The integration test code can be found here ([MATLAB](m/IntegrationTestMetropolis.m)) and here ([python](py/IntegrationTestMetropolis.py)).

**Your code should follow all the good practices we covered this quarter.**  This includes unit testing, not repeating code, useful variable names, and guarding against corruptible objects.

This is an individual assignment.  You must not discuss or share your solution with others.

## Hints

In no particular order:

* If $u$ follows a standard uniform distribution, then $\log(u)$ follows an exponential distribution with rate 1 and vice versa.
* My solution was about 40 lines of code.
* The integration test should produce a plot looking something like this: ![](/run/user/1000/doc/2388e89d/rocResults.png)

* If anything in this prompt is unclear, use your best judgment.
