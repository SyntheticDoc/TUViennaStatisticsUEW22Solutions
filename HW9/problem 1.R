# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(1, 9)
cat("The problem: Distribution of the p-value\n")
cat("In the context of a left-sided statistical test, let S be the test statistic ")
cat("which under H0 has a continuous and strictly monotone distribution function F. ")
cat("Then the p-value writes as\n\n")
cat("\tp = P_H0(S <= s) = F(s)\n\n")
cat("Note that this is the evaluation of the data summarized in the statistic s. ")
cat("The question arises of how the ’random p-value’ is distributed, i.e., ")
cat("if the random test statistic S is evaluated. In other words, what the distribution ")
cat("of P = F(S) under H0?\n")
cat("Note that this distribution is the same for right-sided tests, and also for ")
cat("two-sided tests if F is symmetric around zero, i.e., F(-x) = 1 - F(x) for all x as real numbers.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("As the exercise states, we have given p as:\n\n")

cat("\tp = P_H0(S <= s) = F(s)\n\n")

cat("To see what the distribution of p is, we simply calculate its cumulative ")
cat("distribution function F_p(p) under H0:\n\n")

cat("\tF_p(p) = P(P <= p) = P(F(S) <= p)\t\t[Since P = F(S)]\n")
cat("\t= P(S <= F^(-1)(p)) = F(F^(-1)(p)) = p\n\n")

cat("Since the test statistic S is already given as being strictly monotonous, we ")
cat("don't have to bother using the generalized inverse of F here and can use ")
cat("just the usual inverse function F^(-1) of F here. We see that F_p(p) = p, ")
cat("and since 0 <= p <= 1 by definition of the p-value, we conclude that p is ")
cat("thus following the standard uniform distribution:\n\n")

cat("\tp ~ U(0, 1)\n\n")

cat("Note: We could have seen this also from the probability integral transform ")
cat("we had in an earlier exercise sheet, were we haven already proven the following ")
cat("statement:\n\n")

cat("\tIf X is a random variable which is continuously distributed with cdf F(X), ")
cat("\tthe random variable Y = F(X) is distributed according to the standard uniform ")
cat("\tdistribution.\n\n")

cat("So if p = F(S) and S is continuously distributed (as the exercise already told us), ")
cat("it follows immediately from the probability integral transform that p ~ U(0, 1).")

cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE