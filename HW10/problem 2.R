# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(2, 10)
cat("The problem: One-sample test for proportions (without R)\n")
cat("In the context of the one-sample situation for proportions let the observed ")
cat("relative frequency be h = 1/2. Let the null hypothesis be H0 : p = 0.4 and ")
cat("further let the (approximate) test be two-sided. Answer the following questions ")
cat("only using the table below, which shows the alpha-quantiles q_alpha of the ")
cat("N(2, 1)-distribution.\n\n")

cat(sprintf("\t  alpha || %5.2f | %5.2f | %5.2f | %5.2f | %5.2f\n", 0.01, 0.05, 0.1, 0.2, 0.5))
cat("\t--------------------------------------------------\n")
cat(sprintf("\tq_alpha || %5.2f | %5.2f | %5.2f | %5.2f | %3s\n\n", -0.32, 0.36, 0.72, 1.16, "?"))

cat("\ta) What is the value of the question mark in the table?\n")
cat("\tb) For n = 49 the null hypothesis is rejected on the 10%-level?\n")
cat("\tc) For n = 144 the null hypothesis is rejected on the 3%-level?")

cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("For all N(x, 1)-distributions, q_alpha equals the mean x of the distribution for ")
cat("alpha = 0.5. Therefore:\n\n")

cat("\t? = 2")


cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Since the N(2, 1)-distribution yields the same q_alpha values as the N(0, 1)-")
cat("distribution, just shifted to the right by a factor of two, we have to subtract ")
cat("2 from all values in the table to convert the table to a standardized N(0, 1)-table:\n\n")

cat("\tFor N(0, 1):\n")
cat(sprintf("\t  alpha || %5.2f | %5.2f | %5.2f | %5.2f | %5.2f\n", 0.01, 0.05, 0.1, 0.2, 0.5))
cat("\t--------------------------------------------------\n")
cat(sprintf("\tq_alpha || %5.2f | %5.2f | %5.2f | %5.2f | %3s\n\n", -0.32 - 2, 0.36 - 2, 0.72 - 2, 1.16 - 2, 0))

cat("With this information, we can calculate all necessary values for a one-sample proportion test ")
cat("again:\n\n")

alpha = 0.1
p_0 <- 0.4
h <- 1/2
n <- 49
se_h <- sqrt((h*(1-h))/n)
z <- (h - p_0) / se_h
q_0.05 <- 0.36 - 2
R_lower <- q_0.05
R_upper <- R_lower * -1
I_lower <- h - (-q_0.05) * se_h
I_upper <- h + (-q_0.05) * se_h

cat(sprintf("\th = %.2f, p_0 = %.2f, n = %d, se_h = %.2f\n\n", h, p_0, n, se_h))
cat(sprintf("\t|h - p_0| = %.2f * se_h\n\n", abs(h - p_0)/se_h))
cat(sprintf("\tz = (h - p_0) / se_h = (%.2f - %.2f) / %.2f = %.2f\n", h, p_0, se_h, z))
cat(sprintf("\tR = (-inf, %.2f] AND [%.2f, inf)\n", R_lower, R_upper))
cat(sprintf("\tI = (%.2f, %.2f)\n\n", I_lower, I_upper))
cat(sprintf("\tSince z = %.2f, 0.05 < p/2 < 0.1 => 0.1 < p < 0.2[Because p = 2 * pnorm(-abs(z))]\n\n", z))

cat("Result: z is not in R, p_0 is in I, p > 0.1 -> We don't reject H0.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("As above, we recalculate all values:\n\n")

alpha <- 0.03
n <- 144
se_h <- sqrt((h*(1-h))/n)
z <- (h - p_0) / se_h

cat(sprintf("\th = %.2f, p_0 = %.2f, n = %d, se_h = %.2f\n\n", h, p_0, n, se_h))
cat(sprintf("\t|h - p_0| = %.2f * se_h\n\n", abs(h - p_0)/se_h))
cat(sprintf("\tz = (h - p_0) / se_h = (%.2f - %.2f) / %.2f = %.2f\n", h, p_0, se_h, z))

cat("Result: Since z is smaller than q_alpha for 0.01, it must also be smaller than ")
cat("q_alpha for 0.03. Therefore, it must lie in the rejection region. We reject H0.")


cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE