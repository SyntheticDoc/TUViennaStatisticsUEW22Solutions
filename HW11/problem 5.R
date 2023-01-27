# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(5, 11)
cat("The problem: χ^2-statistics\n")
cat("In the situation of the χ^2-tests (both goodness of fit and test for independence) ")
cat("what happens to the test statistic if in each cell the observed frequencies ")
cat("are doubled?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("We can easily calculate this. The test statistic x^2 is given as:\n\n")

cat("\tx^2 = sum_of((observed_cell_frequency - expected_cell_frequency)^2 / expected_cell_frequency)\n\n")

cat("Lets now call the observed cell frequency o and the expected cell frequency e. ")
cat("Since we estimate the needed marginal probabilities with marginal frequencies, ")
cat("e is calculated as:\n\n")

cat("\te = (corresponding_row_sum_of_cell * corresponding_column_sum_of_cell) / sample size\n\n")

cat("If we double all observed frequencies, the row and column sums are doubled too, ")
cat("as well as the sample size. Thus, when we double observed frequencies, e is doubled ")
cat("too:\n\n")

cat("\tobserved_frequency_new = 2 * observed_frequency_prev => e_new = 2 * e_prev\n\n")

cat("The test statistic x_new^2 for doubled observed frequencies is calculated as:\n\n")

cat("\tx_new^2 = sum_of((observed_cell_frequency * 2 - expected_cell_frequency * 2)^2 / (expected_cell_frequency * 2))\n")
cat("\t=> x_new^2 = sum_of(2 * (observed_cell_frequency - expected_cell_frequency)^2 / expected_cell_frequency)\n")
cat("\t=> x_new^2 = 2 * sum_of((observed_cell_frequency - expected_cell_frequency)^2 / expected_cell_frequency)\n")
cat("\t=> x_new^2 = 2 * x^2\n\n")

cat("Therefore, when we double all observed frequencies, the test statistic is doubled too. ")
cat("This holds both for goodness of fit as well as for independence tests.")

cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE