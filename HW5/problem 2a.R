# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

# The following variable controls the number of runs done in simulations. If simulations
# take too long on your machine, reduce this variable accordingly (at the expense of
# simulation accuracy)
sim_iterations <- 1000000
p <- 3/4
n <- 600
binom_exp <- n*p
binom_variance <- n*p*(1-p)
binom_sd <- sqrt(binom_variance)

source("globalFunctionRepository.R")
source("problem 2b.R")

file_header(2, 5)
cat("The problem: Coin throws\n")
cat("An unfair coin is thrown 600 times. The probability of getting a tail in each throw is 1/4.\n\n")

cat("(a) Use a Binomial distribution to compute the probability that the number of heads ")
cat("obtained does not differ more than 10 from 440.\n\n")
cat("(b) Use a Normal approximation without a continuity correction to calculate the probability ")
cat("in (a). How does the result change if the approximation is provided with a continuity ")
cat("correction?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("We use a B(600, 3/4) distribution to model the coin throws. The question can ")
cat("be reformulated to \"What is the probability to have between 430 and 450 heads ")
cat("in 600 throws of the coin?\". Lets calculate this:\n\n")

# Note that the lower bound here is 429 because of P(430 < x <= 450)
binom_result <- pbinom(450, n, p) - pbinom(429, n, p)
cat("\tpbinom(450, n, p) - pbinom(429, n, p):", binom_result)

cat("\n\nAs usual, lets verify this result with a simulation of the coin throws:\n\n")

get_probability_for_coin_heads(430, 450, p, n, sim_iterations)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("First, we calculate the expectation and the variance for our binomial distribution:\n\n")

cat("\tFor X ~ B(600, 3/4):\n")
cat("\t  E(X) = np =", binom_exp, "\t\t[= binom_exp in the following calculations]\n")
cat("\t  Var(X) = np(1-p) =", binom_variance, "\t[= binom_sd^2 in the following calculations]\n\n")

cat("We use the continuity correction formula from the slides, which states ")
cat("for a <= b, where a and b both are natural numbers:\n")

cat("\tP(a <= S_n <= b) ~= Phi((b + 0.5 - np)/(sqrt(np(1-p)))) - Phi((a - 0.5 - np)/(sqrt(np(1-p))))\n")
cat("\t  [With S_n = X_1 + ... + X_n, sum of independent ber(p) random variables]\n\n")

cat("We use these values to approximate B(600, 3/4) with a Normal distribution of ")
cat("N(np, sqrt(np(1-p))) without continuity correction:\n\n")

norm_result_without_correction <- pnorm((450 - binom_exp)/(binom_sd)) - pnorm((430 - binom_exp)/(binom_sd))
cat("\tpnorm((450 - binom_exp)/(binom_sd)) - pnorm((430 - binom_exp)/(binom_sd)):", norm_result_without_correction)

cat("\n\nWe see that the result approximates the result from a) already pretty closely. ")
cat("Lets do the same calculation now with continuity correction:\n\n")

norm_result_with_correction <- pnorm((450 + 0.5 - binom_exp)/(binom_sd)) - pnorm((430 - 0.5 - binom_exp)/(binom_sd))
cat("\tpnorm((450 + 0.5 - binom_exp)/(binom_sd)) - pnorm((430 - 0.5 - binom_exp)/(binom_sd)):", norm_result_with_correction)

cat("\n\nWe can now calculate the difference of the results from the normal distribution approximation ")
cat("with the results from the binomial distribution to illustrate the effect of the ")
cat("continuity correction:\n\n")

cat("\tWithout continuity correction, difference:", abs(diff(c(binom_result, norm_result_without_correction))), "\n")
cat("\tWith continuity correction, difference:   ", abs(diff(c(binom_result, norm_result_with_correction))), "\n\n")

cat("According to the rule of thumb from the slides, the approximation is reasonable ")
cat("when min(np, np(1-p)) >= 10. Here:\n\n")

cat("\tmin(np, np(1-p)) =", min(binom_exp, binom_variance))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE