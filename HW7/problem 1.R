# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(1, 7)
cat("The problem: z-test (without R)\n")
cat("In the context of a two-sided z-test let x_bar = 4/3 , sigma = 1, n = 9 and H0 : ")
cat("mu = 2/3.\n")
cat("The alpha-quantiles q_alpha of N(0, 1) are as follows\n\n")
cat(sprintf("\t%7s |  %.3f   %.3f   %.3f   %.3f   %.3f   %.3f   %.3f   %.3f\n", "alpha", 0.005, 0.010, 0.015, 0.020, 0.025, 0.030, 0.035, 0.040))
cat("        -------------------------------------------------------------------------\n")
cat(sprintf("\t%7s | %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f\n\n", "q_alpha", -2.576, -2.326, -2.170, -2.054, -1.960, -1.881, -1.812, -1.751))
cat("How do you decide for a significance level of\n")
cat("\ta) 1%,\n")
cat("\tb) 3%,\n")
cat("\tc) 6% and\n")
cat("\td) 10%\n")
cat("by only using the information above? Justify your answers.")
cat("\n\n", string_divider, "\n\n")

# -----------------------------------------------------------------------------#
cat("GENERAL NOTE\n")
cat("Even though the exercise title says \"without R\", i will do some calculations ")
cat("within R, but only those which could have also been done by pen, paper and calculator.\n")
cat("That being said, we begin by calculating the test statistic z:\n\n")
cat("\tz = (x_bar - mu_0) / (sigma / sqrt(n)) = (4/3 - 2/3) / (1 / sqrt(9)) = (2/3) / (1/3) = 6/3 = 2\n\n")
cat("Further, we know that Z = (X_bar - mu_0) / (sigma / sqrt(n)) ~ N(0, 1)\t[if H0 is true, note upper case X_bar instead of x_bar].\n\n")

cat("By now, we know that z = 2 and Z ~ N(0, 1) [if H0 is true]. We observe that ")
cat("the discrepancy of x_bar from mu_0 in units of sigma/sqrt(n) is 2, while the ")
cat("\"typical\" deviation is 1. For our p-value it holds:\n\n")

cat("\tp = P_H0(|Z| >= |z|)\n")
cat("\tRejection Area: R = (-inf, q_alpha/2] U [q_1-alpha/2, +inf)\n\n")

cat("Since the non-rejection area encompasses 1-alpha, each side of the distribution ")
cat("has a rejection area of alpha/2. Therefore, H0 is rejected if the alpha/2-quantile ")
cat("|q_alpha/2| is < 2. This is the case for alpha >= 0.05 or alpha >= 0.025 in the ")
cat("table provided, respectively.")

cat("\n\nEND OF GENERAL NOTE)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("For a significance level of 1%, we get alpha = 0.01/2 = 0.005, which has a ")
cat("q_alpha of -2.576 according to the table.\n\n")
cat("In this case, H0 would not be rejected at the given significance level ")
cat("(since 2 < |-2.576|).")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("For a significance level of 3%, we get alpha = 0.03/2 = 0.015, which has a ")
cat("q_alpha of -2.170 according to the table.\n\n")
cat("In this case, H0 would not be rejected at the given significance level ")
cat("(since 2 < |-2.170|).")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("For a significance level of 6%, we get alpha = 0.06/2 = 0.03, which has a ")
cat("q_alpha of -1.881 according to the table.\n\n")
cat("In this case, H0 would be rejected at the given significance level ")
cat("(since 2 > |-1.881|).")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("For a significance level of 10%, we get alpha = 0.1/2 = 0.05, the q_alpha-value ")
cat("of which is not given in the table, but we know that it is greater than -1.751 ")
cat("(the q_alpha for alpha = 0.04). \n\nTherefore, H0 would be rejected at the given ")
cat("significance level as in c).")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE