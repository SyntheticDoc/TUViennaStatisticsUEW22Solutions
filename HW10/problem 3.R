# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(3, 10)
cat("The problem: Which statement is correct?\n")
cat("In the situation of the two-sample test for proportions, the null hypothesis ")
cat("that the population proportions are equal was not rejected at the 3%-level. ")
cat("(Let the sample sizes be large in the sense that the normal approximation is ")
cat("accurate). Comment on the following statements.\n\n")

cat("\ta) The two observed relative frequencies are equal.\n")
cat("\tb) The observed relative frequencies are equal if and only if the absolute ")
cat("frequencies are equal.\n")
cat("\tc) The test statistic was larger than the 95%-quantile of the standard normal distribution.\n")
cat("\td) If we had performed a right-sided test, then (c) would be true.\n")
cat("\te) The 99%-confidence interval overlaps zero.\n")
cat("\tf) The null hypothesis is correct with probability 97%.\n")
cat("\tg) If the null hypothesis holds true, then a type-I error was not made.")

cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("False.\n\n")

cat("We can only infer that the differences between both relative frequencies ")
cat("are not large enough to be detected as significant at the 3%-level by this test.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("False.\n\n")

cat("Let for example the absolute frequencies be 10 in both cases, while n = 10000 ")
cat("in the first case and n = 10001 in the second case. Both absolute frequencies ")
cat("are equal, but the relative frequencies differ.\n")
cat("Now let the absolute frequencies be 5 and 50 and n = 10 in the first case, ")
cat("n = 100 in the second case. The absolute frequencies differ, but the relative ")
cat("frequencies don't.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("Unknown.\n\n")

cat("Since the rejection area on the right side of the normal distribution starts ")
cat("at the 98.5%-quantile of the standard normal distribution, we don't know if ")
cat("the test statistic was larger than, equal to or smaller than the 95%-quantile.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("False.\n\n")

cat("c) is still unknown, since with a right-sided test, we still don't know where ")
cat("exactly the test statistic was to the left of the 97%-quantile of N(0, 1).")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e)\n")
cat("True.\n\n")

cat("Since the 99%-CI is wider than the 97%-CI and the latter overlaps H0 = 0, the ")
cat("former must also overlap 0.")

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR f)\n")
cat("False.\n\n")

cat("Hypothesis testing tells us nothing about the truth of H0.")

cat("\n\nEND OF SOLUTION FOR f)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR g)\n")
cat("True.\n\n")

cat("However, this does not depend on the truth of H0. Since we did not reject H0, ")
cat("we can't commit a Type I error either way, regardless if H0 really holds true ")
cat("or not (but it would be a Type II error, if H0 doesn't hold true).")

cat("\n\nEND OF SOLUTION FOR g)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE