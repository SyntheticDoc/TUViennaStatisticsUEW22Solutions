# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(2, 7)
cat("The problem: Interpretation of test results\n")
cat("In the context of a statistical test at significance level alpha, the test ")
cat("statistic lies in the rejection region. Comment on the following statements.\n\n")
cat("\ta) The null hypothesis is rejected at the alpha-level.\n")
cat("\tb) The null hypothesis is rejected at the alpha/2-level.\n")
cat("\tc) The null hypothesis is rejected at the 2*alpha-level.\n")
cat("\td) The p-value was at least alpha.\n")
cat("\te) The null hypothesis was significant.\n")
cat("\tf) The null hypothesis is not true.\n")
cat("\tg) The null hypothesis is probably not true.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("[The null hypothesis is rejected at the alpha-level.]\n\n")
cat("True.\n\n")
cat("If the test statistic lies in the rejection area, we say:\n\n")
cat("\tWithin the limits of our model and our chosen significance level alpha,\n ")
cat("\tour data does not fit with the assumption of the null hypothesis.\n")
cat("\tTherefore, the null hypothesis is rejected at the alpha-level.")


cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("[The null hypothesis is rejected at the alpha/2-level.]\n\n")
cat("False/Unknown.\n\n")
cat("A significance level of alpha/2 is more strict than one of alpha. Therefore, ")
cat("if H0 is rejected at alpha, we can't automatically assume that it will also be ")
cat("rejected at alpha/2.")


cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("[The null hypothesis is rejected at the 2*alpha-level.]\n\n")
cat("True.\n\n")
cat("A significance level of alpha*2 is less strict than one of alpha. Therefore, ")
cat("if H0 is rejected at alpha, we can infer that it is also rejected at alpha*2.")


cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("[The p-value was at least alpha.]\n\n")
cat("False.\n\n")
cat("H0 is rejected iff p <= alpha. H0 is not rejected iff p > alpha.")


cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e)\n")
cat("[The null hypothesis was significant.]\n\n")
cat("False/Unknown.\n\n")
cat("This statement does not make any sense. We can say that the discrepancy between our ")
cat("sample data and our prognosis of H0 is significant or not, but a null hypothesis ")
cat("itself has no property like \"significance\".")


cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR f)\n")
cat("[The null hypothesis is not true.]\n\n")
cat("False.\n\n")
cat("This can never be inferred from statistical teting. We are just making probability ")
cat("statements about our sample data under the theoretical ssumption that H0 holds. ")
cat("This tells us nothing about the population from which our data comes or H0 itself.")


cat("\n\nEND OF SOLUTION FOR f)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR g)\n")
cat("[The null hypothesis is probably not true.]\n\n")
cat("False.\n\n")
cat("Same argument as for f).")


cat("\n\nEND OF SOLUTION FOR g)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE