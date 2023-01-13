# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(4, 7)
cat("The problem: Type I error and Type II error\n")
cat("Let X_1, ..., X_16 be i.i.d. random variables with X_1 ~ N(0, 4). Assume that ")
cat("for a realization it holds x_bar = 4. In the context of a right-sided z-test, ")
cat("let H0 : mu = 2 and the rejection area R = [3, +infinity). Which of the following ")
cat("statements are correct?\n\n")
cat("\ta) We will commit a Type I error\n")
cat("\tb) We will commit a Type II error\n")
cat("\tc) We will not commit a Type II error\n")
cat("\td) If we increase the significance level of the test, then we obtain a higher test power\n\n")
cat("Hint: The expectation of X_1 is fixed at zero. Is the null hypothesis true?\n\n")
cat("Remark: Note that this is a theoretical consideration of the z-test. Here, the ")
cat("distribution of X_1 is fixed (as the expectation is zero), while usually we assume ")
cat("the expectation (resp. the population) to be unknown. In this theoretical consideration ")
cat("we know whether the null hypothesis is true and we are thus able to make statements about ")
cat("the errors. From a practical point of view, the setup is not useful, because the reason ")
cat("to perform a statistical test is the fact that the population of interest is unknown.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("GENERAL REMARK\n")
cat("The sample mean X_bar for X1, ..., Xn i.i.d. variables with E(X1) = mu and ")
cat("Var(X_1) = sigma^2 is given by:\n\n")
cat("\tX_bar = 1/n * sum_from_i=1_to_n_of(X_i)\n")
cat("\tE(X_bar) = mu\n")
cat("\tVar(X_bar) = (sigma^2)/n\n\n")

cat("Therefore in our case:\n\n")
cat("\tE(X_bar) = E(X_1) = 0\n\n")

cat("We have H0 : mu = 2 with R = [3, +infinity), so we can calculate our z-statistic:\n\n")
cat("\tz = (x_bar - mu_0) / (sigma / sqrt(n)) = (4 - 2) / (sqrt(4) / sqrt(16)) = 4\n\n")

cat("Our z = 4 lies in R. Therefore, our test rejects the null hypothesis, and in ")
cat("this case we also know that H0 is indeed false because the true expectation ")
cat("of X_bar is mu = 0.")

cat("\n\nEND OF GENERAL REMARK")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("\nFalse.\n\n")
cat("H0 is rejected and we also know that it isn't true. Comitting an Type I error ")
cat("(which usually has a probability of alpha) would mean that we reject a true H0, ")
cat("which is not the case here.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("\nFalse.\n\n")
cat("To commit a Type II error, we must not reject H0 even though it does not hold ")
cat("true, which is not the case here, since we reject H0.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("\nTrue.\n\n")
cat("We know that H0 is false and we correctly reject it. This means we are not ")
cat("committing a Type II error here.")


cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("\nTrue.\n\n")
cat("If beta is not already fixed, increasing alpha also increases the test power.")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\nEND OF SOLUTION FILE")

x_start <- -1
x_seq = seq(x_start, 5, by = 0.01)
max_y <- max(dnorm(x_seq, mean = 0, sd = sqrt(4/16)))

plot(x_seq, dnorm(x_seq), xlab = "x", ylab = "y", main = "Visualisation for exercise 4",
     xlim = c(x_start, 5), ylim = c(0, max_y), type = "l", col = "Blue", lwd = 2)

lines(x_seq, dnorm(x_seq, mean = 0, sd = sqrt(4/16)), col = "Red", lwd = 2)

legend("topright", legend = c("N(0, 1)", "X_bar", "mu_0", "x_bar"), col = c("Blue", "Red", "Green", "Red"), lty = c(1, 1, 1, 2), lwd = c(2, 2, 2, 2))

abline(v = 2, col = "Green", lwd = 2)
abline(v = 4, col = "Red", lty = 2, lwd = 2)

# END OF FILE