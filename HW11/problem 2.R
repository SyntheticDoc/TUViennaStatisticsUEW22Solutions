# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
source("globalFunctionRepository.R")

file_header(2, 11)
cat("The problem: Rolling die, part 2\n")
cat("Test the null hypothesis that the die is fair with a χ^2-test on the ")
cat("5%-significance level, without using R-command chisq.test().\n\n")

cat("\ta) What are the observed (absolute) frequencies?\n")
cat("\tb) What are the expected frequencies under the null hypothesis?\n")
cat("\tc) What is the value x^2 of the χ^2-statistic?\n")
cat("\td) How is the χ^2-statistic X^2 distributed under the null hypothesis (in ")
cat("the context of the associated model)\n")
cat("\te) What is the rejection area R?\n")
cat("\tf) Do you reject the null hypothesis?\n")
cat("\tg) Compute the p-value.\n")
cat("\th) Interpret your result.")

cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
load("die.Rdata")
n <- length(w)
col_names <- c("blue", "naranja", "rot", "verte")

cat("SOLUTION FOR a) [What are the observed (absolute) frequencies?]\n")
# Absolute frequencies
blue_abs_f <- length(w[w == "blue"])
naranja_abs_f <- length(w[w == "naranja"])
rot_abs_f <- length(w[w == "rot"])
verte_abs_f <- length(w[w == "verte"])
abs_f <- c(blue_abs_f, naranja_abs_f, rot_abs_f, verte_abs_f)

cat("Observed (absolute) frequencies:\n\n")

for(i in 1:4) {
  cat(sprintf("\t%9s: %d\n", col_names[i], abs_f[i]))
}

cat("\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b) [What are the expected frequencies under the null hypothesis?]\n")
cat("Expected frequencies under H0 (observed frequency in brackets):\n\n")

expected_freq <- 150/4
for(i in 1:4) {
  cat(sprintf("\t%9s: %.1f (%d)\n", col_names[i], expected_freq, abs_f[i]))
}

cat("\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c) [What is the value x^2 of the χ^2-statistic?]\n")
cat("The χ^2-statistic is calculated as follows:\n\n")

cat("\tχ^2 := sum_from_k=1_to_d_of((x_k - E_H0[X_k])^2 / E_H0[X_k])\n")
cat("\t[For n data in d categories, x_1, ..., xd as observed frequencies]\n\n")

cat("Result:\n\n")

chi_squared <- 0

for(i in 1:4) {
  chi_squared <- chi_squared + ((abs_f[i] - expected_freq)^2 / expected_freq)
}

cat("\tχ^2 = ", chi_squared)

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d) [How is the χ^2-statistic X^2 distributed under the null hypothesis (in ")
cat("the context of the associated model)]\n")
cat("\tX^2 ~ χ^2(d - 1) => X^2 ~ χ^2(3)")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e) [What is the rejection area R?]\n")
cat("The test is one-sided, since χ^2 is always positive and only large χ^2 speak ")
cat("against H0. The rejection area R is therefore calculated as:\n\n")

alpha <- 0.05
q_chisq <- qchisq(1 - alpha, df = 3)
cat(sprintf("\tR = [q_1-alpha, inf) = [qchisq(1 - alpha, df = 3), inf) = [%.2f, inf)", q_chisq))

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR f) [Do you reject the null hypothesis?]\n")
cat(sprintf("χ^2 = %.2f > R_lower = %.2f => χ^2 is in R => Reject H0.", chi_squared, q_chisq))

cat("\n\nEND OF SOLUTION FOR f)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR g) [Compute the p-value.]\n")
p_chisq <- pchisq(chi_squared, df = 3)
cat(sprintf("p = 1 - pchisq(χ^2, df = 3) = 1 - %.5f = %.5f", p_chisq, 1 - p_chisq))

cat("\n\nEND OF SOLUTION FOR g)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR h) [Interpret your result.]\n")
cat(sprintf("Since p = %.5f << alpha = 0.05 => Reject H0.", 1 - p_chisq))

cat("\n\nEND OF SOLUTION FOR h)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE