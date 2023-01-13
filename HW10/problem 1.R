# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

# The following variable controls the number of runs done in simulations. If simulations
# take too long on your machine, reduce this variable accordingly (at the expense of
# simulation accuracy)
sim_iterations <- 10000

source("globalFunctionRepository.R")

file_header(1, 10)
cat("The problem: One-sample test for proportions\n")
cat("You are at a fair and a lottery booth showman claims that every second lottery ")
cat("ticket is a win. You observe the hustle and bustle around the lottery booth ")
cat("for a while and count that from 58 tickets sold 17 won. Does this observation ")
cat("let you doubt the claim?\n\n")
cat("\ta) Calculate the p-value in the context of the (two-sided) one-sample test ")
cat("for proportions.\n")
cat("\tb) What do you answer the showman?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("We have categorial data with two categories - either a ticket wins or it doesn't ")
cat("(Categories: Win, Lose). Every ticket draw is a random variable Y and is bernoulli-")
cat("distributed, hence:\n\n")

cat("\tLottery draws Y_1, ..., Y_n, i.i.d. with Y_1 ~ ber(p) and p in (0, 1)\n")
cat("\tY_i = 1 (Win, probability p) OR 0 (Lose, probability 1 - p)\n\n")

cat("Therefore, the relative frequency of winning tickets is:\n\n")

# H is a random variable, too! h is the realization of H
cat("\tH := (1/n) sum_of_i=1_to_n_of(Y_i)\n\n")

cat("Further:\n\n")

cat("\tE(H) = p, Var(H) = (p(1-p))/n\n")

# H is asymptotic normal, which means for n -> inf:
# (H - p) / sqrt((p(1-p))/n) -> N(0, 1)
# We use a normal approximation of H instead of a t-test, since we don't assume the 
# RVs to be normally distributed

cat("\tStandard error of H: SE_H := sqrt((H(1 - H))/n)\n\n")

cat("We will now estimate the standard error of the relative frequency based on ")
cat("our data:\n\n")

h <- 17/58
n <- 58
se_h <- sqrt((h*(1-h))/n)

cat("\tse_h = sqrt((h(1 - h))) =", se_h, sprintf("\t[With h = 17/58 = %.2f, n = %d]\n\n", h, n))

cat("The showman claims p_0 = 0.5. Therefore:\n\n")

p_0 <- 0.5
cat(sprintf("\t|h - p_0| = %.2f * se_h\n\n", abs(h - p_0)/se_h))

cat("As this value is pretty far away from the mean, we doubt the showmans claim and ")
cat("perform a two-sided one-sample test for proportions to add substance to our doubts:\n\n")

alpha <- 0.05
z <- (h - p_0) / se_h
R_lower <- qnorm(alpha/2)
R_upper <- R_lower * -1
p <- 2 * pnorm(-abs(z))
I_lower <- h - qnorm(1-alpha/2) * se_h
I_upper <- h + qnorm(1-alpha/2) * se_h
cat("\tWe choose a confidence level of 95% / alpha = 0.05.\n")
cat(sprintf("\tz = (h - p_0) / se_h = (%.2f - %.2f) / %.2f = %.2f\n", h, p_0, se_h, z))
cat(sprintf("\tR = (-inf, %.2f] AND [%.2f, inf)\n", R_lower, R_upper))
cat(sprintf("\tp = 2 * pnorm(-abs(z)) = %.5f\n", p))
cat(sprintf("\tI = (%.2f, %.2f)\n\n", I_lower, I_upper))

cat("We see the following:\n\n")
cat("\t-> z lies in the rejection area\n")
cat("\t-> p < alpha\n")
cat("\t-> p_0 does not lie in I\n\n")

cat("Therefore, we reject H0 := p_0 = 0.5.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("We can't be sure if the showman is lying, if he just errs or if he is indeed ")
cat("correct. We can only say: Our statistical model, applied to the data given, ")
cat("doesn't support his claim. He may still be right, but if he is, this round of ")
cat("ticket draws was pretty extraordinarily bad (for ticket buyers), statistically speaking.")


cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE