# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 100000

source("globalFunctionRepository.R")
source("problem 2b.R")

sum_for_k <- get_sum_for_k()
k = 1 / sum_for_k

file_header(2, 2)
cat("The problem: A left-turn lane problem\n")
cat("A civil engineer is studying a left-turn lane that is long enough to hold ") 
cat("six cars. Let X be the number of cars in the lane at the end of a randomly ")
cat("chosen red light. The engineer believes that the probability that X = x is ")
cat("proportional to (x + 1)(7 - x).\n\n")
cat("\ta) Find the probability mass function (pmf) of X.\n")
cat("\tb) Compute the probability that X will be at most 5.\n")
cat("\tc) Calulate the expectation and standard deviation of X.\n")
cat("\t   Note: R might be useful.")
cat("\n\n", string_divider, "\n\n")
cat("SOLUTION FOR a)\n")
cat("The pmf of a discrete random variable X is defined as:\n\n")
cat("\tp(a) = P(X = a)\t[with always 0 <= p(a) <= 1 and a as real number]\n")
cat("\t(of course, if a is a value that X never takes then p(a) = 0)\n\n")
cat("In this case, p(x) = P(X = x) is said to be proportional to (x + 1)(-x + 7), ")
cat("which means p(x) = k * (x + 1)(-x + 7) (with k as proportionality constant). ")
cat("To calculate the pmf, we must first derive k. We know the following:\n\n")
cat("\t(Sum of all p(x) with x = 0 to x = 6) = 1\n")
cat("\t<=> (Sum of all (k * (x + 1)(-x + 7)) with x = 0 to x = 6) = 1\n")
cat("\t<=> k * (Sum of all (x + 1)(-x + 7) with x = 0 to x = 6) = 1\t[Since k is constant]\n")
cat("\t<=> k = 1 / (Sum of all (x + 1)(-x + 7) with x = 0 to x = 6)\n\n")
cat("The only thing left to do now to get k is to calculate the sum:\n\n")
cat("\t(Sum of all (x + 1)(-x + 7) with x = 0 to x = 6)\n")
cat("\t= (0 + 1)(-0 + 7) + (1 + 1)(-1 + 7) + ... + (7 + 1)(-7 + 7) =", sum_for_k,"\n\n")
cat("And hence:\n\n")
cat("\tk = 1 /", sum_for_k, "=", k, "\n\n")
cat("Therefore, our pmf is:\n\n")
cat("\tp(x) = k * (x + 1)(-x + 7) = 1/")
cat(sum_for_k)
cat(" * (x + 1)(-x + 7)\n")
cat("\t  with p(x) = 0 if x < 0 or x > 6\n\n")
cat("Individual probabilities:\n\n")

for(x in 0:6) {
  print_pmf_for(x, k)
}

cat("\n\n")
cat("END OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
cat("SOLUTION FOR b)\n")
cat("The probability that X will be at most 5 (= P(X <= 5)) is derived as follows:\n\n")
cat("\tP(X <= 5) = P(0) + P(1) + P(2) + P(3) + P(4) + P(5)\n")
cat("\t<=> P(X <= 5) = 1 - (P(6))\n\n")
cat("And with the values already calculated for task (a):\n\n")
cat("\tP(X <= 5) =", get_pmf_for_X_le_5(k), "\n\n")

cat("END OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
E_X_1 <- get_expected_value_times(k, 2)
E_X_2 <- get_expected_value_times(k, 1)^2
variance <- E_X_1 - E_X_2

cat("SOLUTION FOR c)\n")
cat("The expected value for random variables x_1, x_2, ... and pmfs P(x_i) is defined ")
cat("as:\n\n")
cat("\tE(X) = (sum of (x_i * p(x_i)) from i = 1 to infinity\n\n")
cat("But remember: p(x) = 0 if (x < 0 or x > 6)! Furthermore in this case, x_1 = 0, ")
cat("x_2 = 1, ..., x_7 = 6. So in this case, we have to sum only from i = 1 to i = 7, ")
cat("since for all other values of i (x_i * p(x_i)) = (x_i * 0) = 0.\n")
cat("This gives us the following expected value:\n\n")
cat("\tE(X) = 0 * p(0) + 1 * p(1) + 2 * p(2) + ... + 6 * p(6) =", get_expected_value_times(k, 1),"\n\n")
cat("Then the variance (central moment of order 2) of X is:\n\n")
cat("\tVar(X) = E((X - E(X))^2) = E(X^2) - (E(X))^2\n")
cat("\t=", E_X_1, "-", E_X_2, "=", variance,"\n\n")
cat("Therefore, the standard deviation is:\n\n")
cat("\tStdD = sqrt(Var(X)) =", sqrt(variance), "\n\n")
cat("END OF SOLUTION FOR c)\n\n")

variance_test(sim_iterations)

cat("END OF SOLUTION FILE")

# END OF PROBLEM B SOLUTION
# END OF FILE