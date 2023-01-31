function tests = test_BayesFactor
  tests = functiontests(localfunctions);
end

function test_priors(testCase)
  prior1 = @(p) (0.45 <= p & p <= 0.55);
  prior2 = @(p) (0.45 <= p & p <= 0.55);
  
  BF = BayesFactor(10, 3, prior1, prior2);

  obtained = BF.compute();
  expected = 1;

  testCase.verifyEqual(obtained, expected);
end

function test_spike_and_slab(testCase)
  prior1 = @(p) (0.00 <= p & p <= 1.00);
  prior2 = @(p) (0.45 <= p & p <= 0.55);
  
  BF = BayesFactor(10, 3, prior1, prior2);

  relTol = 1e-4;
  
  obtained = BF.compute();
  expected = 0.130159445116760;

  testCase.verifyEqual(obtained, expected, 'RelTol', relTol);
end

function test_compute(testCase)
  n = 10;
  k = 7;
  prior1 = @(p) (0.00 <= p & p <= 1.00);
  prior2 = @(p) (0.45 <= p & p <= 0.55);

  bf = BayesFactor(n, k, prior1, prior2);

  relTol = 1e-4;
    
  obtained = bf.compute();
  expected = 0.13015944511676;
    
  testCase.verifyEqual(obtained, expected, 'RelTol', relTol);
end

function test_binomial_pdf(testCase)
  n = 10;
  k = 7;
  p = 0.7;

  bf = BayesFactor(n, k, @(p) 1, @(p) 1);
    
  relTol = 1e-4;
    
  obtained = bf.binomial_pdf(p);
  expected = 0.266827932000000;
    
  testCase.verifyEqual(obtained, expected, 'RelTol', relTol);
end



