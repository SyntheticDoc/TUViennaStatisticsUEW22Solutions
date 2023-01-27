# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(4, 11)
cat("The problem: χ^2-test for independence (with R)\n\n")
cat("\ta) Solve the previous exercise using R.\n")
cat("\tb) Can you also reject for a significance level of alpha = 0.1%?\n")
cat("\tc) Double observed frequencies in each cell and perform the test on the 0.1% level.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Lets get the data for our two assumptions again to feed them into R, then ")
cat("perform the chi-squared tests (see code for details):\n\n")

# Calculus frequencies
L1_vec <- c(10, 5, 5)

# Algebra frequencies
L2_vec <- c(10, 20, 10)

# Probability frequencies with both assumptions about the missing value
L3_1_vec <- c(20, 5, 15)
L3_2_vec <- c(20, 5, 0)

assumption_1 <- rbind(L1_vec, L2_vec, L3_1_vec)
assumption_2 <- rbind(L1_vec, L2_vec, L3_2_vec)

result_1 <- capture.output(chisq.test(assumption_1))
result_2 <- capture.output(chisq.test(assumption_2))

for(s in result_1) {
  cat(s, "\n")
}

cat("\n")

for(s in result_2) {
  cat(s, "\n")
}

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Lets get the p-values from the test and compare them to alpha = 0.001:\n\n")

p1 <- chisq.test(assumption_1)$p.value
p2 <- chisq.test(assumption_2)$p.value

cat(sprintf("\tp1 = %.5f, p2 = %.5f\n\n", p1, p2))

cat("The p-value from the second assumption is significantly smaller than alpha = 0.001, ")
cat("leading us to reject H0 for missing value = 0. But for missing value = 15 ")
cat("(first assumption), the p-value is larger than alpha, in which case we won't ")
cat("reject H0.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("See code for details, result:\n\n")

assumption_1_2 <- assumption_1 * 2
assumption_2_2 <- assumption_2 * 2

result_1_2 <- capture.output(chisq.test(assumption_1_2))
result_2_2 <- capture.output(chisq.test(assumption_2_2))

for(s in result_1_2) {
  cat(s, "\n")
}

cat("\n")

for(s in result_2_2) {
  cat(s, "\n")
}

cat("We would reject H0 in both cases, since both p-values are significantly smaller ")
cat("than alpha = 0.001.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE