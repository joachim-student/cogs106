function tests = test_example
  tests = functiontests(localfunctions);
end

function testSquare(testCase)
  % Test Case 1: Test that 3^2 is equal to 9
  obtainedAnswer = 3^2;
  expectedAnswer = 9;
  verifyEqual(testCase,obtainedAnswer,expectedAnswer)
end

function testSin(testCase)
  % Test Case 2: Test test sin(pi/2) is equal to 1
  obtainedAnswer = sin(pi/2);
  expectedAnswer = 1;
  verifyEqual(testCase,obtainedAnswer,expectedAnswer)
end

function testRoots(testCase)
  % Test Case 3: Test that the roots are correct
  obtainedAnswer = roots([1 -4 4]);
  expectedAnswer = [2; 2];
  verifyEqual(testCase,obtainedAnswer,expectedAnswer)
end
