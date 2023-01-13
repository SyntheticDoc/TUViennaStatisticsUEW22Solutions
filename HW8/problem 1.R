# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
x_bar <- 2.05
s_squared <- 4
n <- 16
mu_0 <- 1
t <- (x_bar - mu_0)/(sqrt(s_squared) / sqrt(n))

source("globalFunctionRepository.R")

file_header(1, 8)
cat("The problem: One-sample t-test (without R)\n")
cat("In the context of a one-sample t-test let x_bar = 2.05, s^2 = 4, n = 16 and ")
cat("H0 : µ = 1. The values of the distribution function F of the t(n)-distribution are\n\n")
cat(sprintf("%17s | %.3f  %.3f  %.3f  %.3f  %.3f  %.3f\n", "t", -2.3, -2.2, -2.1, -2.0, -1.9, -1.8))
cat("------------------------------------------------------------------\n")
cat(sprintf("%17s |  %.3f   %.3f   %.3f   %.3f   %.3f   %.3f\n", "F(t) (for n = 15)", 0.018, 0.022, 0.027, 0.032, 0.038, 0.046))
cat(sprintf("%17s |  %.3f   %.3f   %.3f   %.3f   %.3f   %.3f\n\n", "F(t) (for n = 16)", 0.018, 0.021, 0.026, 0.031, 0.038, 0.045))
cat("What is your conclusion for the following cases:\n\n")
cat("\ta) at a right-sided test at level 5%\n")
cat("\tb) at a right-sided test at level 1%\n")
cat("\tc) at a left-sided test at level 5%\n")
cat("\td) at a two-sided test at level 5%\n\n")
cat("Briefly explain your choice. (Only use the upper information)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("GENERAL REMARK\n")
cat("We consider a one-sample t-test with (n - 1) = 15 degrees of freedom.\n")
cat("Since we already have sigma given, we don't have to estimate it and can immediately ")
cat("proceed with calculating the test statistic t:\n\n")
cat("\tt = (x_bar - µ0)/(s / sqrt(n)) = (2.05 - 1)/(sqrt(4) / sqrt(16)) = 1.05/0.5 =", 1.05/0.5, "\n\n")
cat("In all solutions to this exercise, we have to use the row \"F(t) (for n = 15)\", ")
cat("since a t-distribution has n-1 degrees of freedom, so for n = 16, we use a t(n-1) ")
cat("distribution, but the table rows are for a t(n)-distribution, so here we must use ")
cat("t(n) = t(15).")
cat("\n\nEND OF GENERAL REMARK")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a) [at a right-sided test at level 5%]\n")
cat("Right-sided test: H0 : µ <= µ0, H1 : µ > µ0, R[q_1-alpha, +inf), p = P_H0(Z >= z)\n\n")
cat("The rejection area starts at q_1-alpha = q_0.95. Since the t(n)-distribution is ")
cat("symmetric around 0, we have q_0.95 = |q_0.05| < |-1.8| [since 0.05 > 0.046].\n\n")
cat("Since t > q_0.95, our answer is:\n\n")
cat("\tReject H0.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b) [at a right-sided test at level 1%]\n")
cat("As argued above, the rejection area starts at q_1-alpha = q_0.99. We know that ")
cat("q_0.99 = |q_0.01| > |-2.3|. Since t =", t, "< 2.3, we conclude:\n\n")
cat("\tDon't reject H0.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c) [at a left-sided test at level 5%]\n")
cat("Left-sided test: H0 : µ >= µ0, H1 : µ < µ0, R(-inf, q_alpha], p = P_H0(Z <= z)\n\n")
cat("Since alpha < 0.5, we know that q_alpha < 0. Since t > 0, t is not in the ")
cat("rejection area, we even don't need the table for this. We conclude:\n\n")
cat("\tDon't reject H0.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d) [at a two-sided test at level 5%]\n")
cat("Two-sided test: H0 : µ = µ0, H1 : µ != µ0, R = (-inf, q_alpha/2] UNION [q_1-alpha/2, inf), p = P_H0(|Z| >= |z|)\n\n")
cat("Since the test is two-sided, we have q_0.025 and q_0.975, respectively. From ")
cat("the table, we see that -2.2 < q_0.025 < -2.1. Since t =", t, " and ")
cat("F(2.1) = 1-0.027 = 0.973 and q_0.973 < q_0.975, we can safely conclude:\n\n")
cat("\tDon't reject H0.")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE