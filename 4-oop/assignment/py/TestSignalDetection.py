#!/usr/bin/python3.8

import unittest
from SignalDetection import SignalDetection

class TestSignalDetection(unittest.TestCase):

    def test_d_prime_zero(self):
        sd   = SignalDetection(15, 5, 15, 5)
        expected = 0
        obtained = sd.d_prime()
        # Compare calculated and expected d-prime
        self.assertAlmostEqual(obtained, expected, places=10)

    def test_d_prime_nonzero(self):
        sd   = SignalDetection(15, 10, 15, 5)
        expected = -0.421142647060282
        obtained = sd.d_prime()
        # Compare calculated and expected d-prime
        self.assertAlmostEqual(obtained, expected, places=10)

    def test_criterion_zero(self):
        sd   = SignalDetection(5, 5, 5, 5)
        # Calculate expected criterion
        expected = 0
        obtained = sd.criterion()
        # Compare calculated and expected criterion
        self.assertAlmostEqual(obtained, expected, places=10)

    def test_criterion_nonzero(self):
        sd   = SignalDetection(15, 10, 15, 5)
        # Calculate expected criterion
        expected = -0.463918426665941
        obtained = sd.criterion()
        # Compare calculated and expected criterion
        self.assertAlmostEqual(obtained, expected, places=10)

    def test_addition(self):
        sd = SignalDetection(1, 1, 2, 1) + SignalDetection(2, 1, 1, 3)
        expected = [3, 2, 3, 4]
        obtained = [sd.hits, sd.misses, sd.false_alarms, sd.correct_rejections]
        # Compare calculated and expected criterion
        self.assertEqual(obtained, expected)

    def test_multiplication(self):
        sd = SignalDetection(1, 2, 3, 1) * 4
        expected = [4, 8, 12, 4]
        obtained = [sd.hits, sd.misses, sd.false_alarms, sd.correct_rejections]
        # Compare calculated and expected criterion
        self.assertEqual(obtained, expected)

if __name__ == '__main__':
    unittest.main()
