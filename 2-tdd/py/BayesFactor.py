import scipy.integrate as spi
import numpy as np

class BayesFactor:
    def __init__(self, n, k, prior1, prior2):
        self.n = n
        self.k = k
        self.prior1 = prior1
        self.prior2 = prior2
    
    def binomial_pdf(self, p, n, k):
        return (np.math.factorial(n) / (np.math.factorial(k) * np.math.factorial(n - k))) * \
            (p ** k) * ((1 - p) ** (n - k))
    
    def integrand1(self, p):
        return self.binomial_pdf(p, self.n, self.k) * self.prior1(p)

    def integrand2(self, p):
        return self.binomial_pdf(p, self.n, self.k) * self.prior2(p)

    def compute(self):
        integration1 = spi.quad(self.integrand1, 0, 1)[0]
        integration2 = spi.quad(self.integrand2, 0, 1)[0]
        return integration2 / integration1

def uniform_prior1(p):
    if p >= 0 and p <= 1:
        return 1.0
    return 0.0

def uniform_prior2(p):
    if p >= 0.45 and p <= 0.55:
        return 10.0
    return 0.0

bf = BayesFactor(30, 15, uniform_prior1, uniform_prior2)
result = bf.compute()
print(result)

import unittest

class TestBayesFactor(unittest.TestCase):  
    
    def test_init(self):
        n = 5
        k = 2
        bf = BayesFactor(n, k, uniform_prior1, uniform_prior2)
        self.assertEqual(bf.n, n)
        self.assertEqual(bf.k, k)
        self.assertEqual(bf.prior1, uniform_prior1)
        self.assertEqual(bf.prior2, uniform_prior2)
    def test_compute(self):
        n = 5
        k = 2
        bf = BayesFactor(n, k, uniform_prior1, uniform_prior1)

        self.assertEqual(bf.compute(), 1.)
          
# Run the tests
if __name__ == '__main__':
    unittest.main()
    #unittest.main(argv=['first-arg-is-ignored'], exit=False) # for jupyter
