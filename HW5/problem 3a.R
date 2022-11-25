# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 10000000
lambda <- 50
sd_car <- sqrt(lambda)

source("globalFunctionRepository.R")
source("problem 3b.R")

file_header(3, 5)
cat("The problem: Cars arrivals\n")
cat("Suppose cars arrive at a parking lot at a rate of 50 per hour. Assume that the process is ")
cat("modeled by a Poisson random variable with λ = 50.\n\n")
cat("\t(a) Compute the probability that in the next hour the number of cars that arrive at this ")
cat("parking lot will be between and including 54 and 62.\n\n")
cat("\t(b) Compare the value obtained in (a) with the probability calculated by using a Normal ")
cat("approximation.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("We can calculate this easily with ppois() in R:\n\n")

poisson_result <- ppois(62, lambda) - ppois(53, lambda)
cat("\tppois(62, lambda) - ppois(53, lambda):", poisson_result, "\n\n")

cat("Lets verify this with a simulation:\n")
get_probability_for_cars_within_span(54, 62, lambda, sim_iterations)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("The continuity correction for an approximation with the Normal distribution ")
cat("is basically the same for Poisson distributions as it was for Binomial distributions. ")
cat("For Poisson distributions we have E(X) = lambda and Var(X) = lambda.\n\n")

cat("We use the continuity correction formula from the slides, which states ")
cat("for a <= b, where a and b both are natural numbers:\n")

cat("\tP(a <= S_n <= b) ~= Phi((b + 0.5 - lambda)/(sqrt(lambda))) - Phi((a - 0.5 - lambda)/(sqrt(lambda)))\n")
cat("\t  [With S_n = X_1 + ... + X_n, sum of independent ber(p) random variables]\n\n")

norm_result_with_correction <- pnorm((62 + 0.5 - lambda)/(sd_car)) - pnorm((54 - 0.5 - lambda)/(sd_car))
cat("If we calculate the probability again with the formula above, we get:\n\n")
cat("\tpnorm((62 + 0.5 - lambda)/(sqrt(lambda))) - pnorm((54 - 0.5 - lambda)/(sqrt(lambda))):", norm_result_with_correction, "\n\n")

cat("\tDifference from approximation to Poisson result:", abs(diff(c(poisson_result, norm_result_with_correction))), "\n\n")

cat("According to the rule of thumb from the slides, the approximation is reasonable ")
cat("when lambda > 15, which is true here.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE