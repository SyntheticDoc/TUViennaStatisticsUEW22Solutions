# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("problem 5b.R")

file_header(5, 10)
cat("The problem: Simulation of coverage probability\n")
cat("Simulate the coverage probability of the one-sample confidence interval for ")
cat("frequencies - does the confidence interval deliver what it promises? Let ")
cat("Y_1, ..., Y_n be i.i.d. random variables with Y_1 ~ bern(p) and p in (0, 1). ")
cat("Approximate in 10000 simulations the coverage probability of the 95%-confidence ")
cat("interval, i.e., simulate the proportion of coverage events of the parameter ")
cat("p. For that let\n\n")

cat("\ta) n = 45 and p = 4/9\n")
cat("\tb) n = 10 and p = 1/10\n")
cat("\tc) Visualize the simulated relative frequencies from (a) and (b) in two ")
cat("histograms and comment on the simulated coverage probabilities.\n\n")

cat("Hint: R-command rbinom and for example ifelse().")

cat("\n\n", string_divider, "\n\n")

# General data:
iterations <- 10000
alpha <- 0.05
param_data <- data.frame(n = c(45, 10), p = c(4/9, 1/10))
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Lets run simulations:\n\n")

h_vecs <- matrix(nrow = iterations, ncol = 2)
result <- do_run(iterations, param_data$n[1], param_data$p[1], alpha)
cov_prob <- c(result$covprob[1])
h_vecs[, 1] <- result$h_v

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Lets run simulations:\n\n")

result <- do_run(iterations, param_data$n[2], param_data$p[2], alpha)
cov_prob <- c(cov_prob, result$covprob[1])
h_vecs[, 2] <- result$h_v

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("See code for histogram generation.\n\n")

for(i in 1:2) {
  mean_h_vec <- mean(h_vecs[, i])
  title <- sprintf("Histogram for n = %d, p = %.2f, coverage prob. = %.4f", param_data$n[i], param_data$p[i], cov_prob[i])
  hist(h_vecs[, i], breaks = 10, main = title, las = 1, xlab = "Rel. frequency", xlim = c(0, 0.8))
  abline(v = mean_h_vec, col = "Blue", lwd = 3, lty = 2)
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)
  legend("topright", legend = c(sprintf("Mean = p = %.2f", mean_h_vec)), 
         lwd = c(3), col = c("Blue"), lty = c(2))
}

cat("Comment:\n")
cat("The coverage probability should equal the nominal coverage probability of 0.95 ")
cat("if all assumptions in deriving the CI are fully met. In a), the coverage probability ")
cat("comes extremely close to 0.95, while in b) it is already much lower with only ")
cat("about 0.65. Since our calculation of the CIs use a normal approximation, we ")
cat("can easily assume that n = 10 in b) is a much to small sample size to justify ")
cat("a normal approximation by the central limit theorem. The coverage probability ")
cat("in b) is much lower than the nominal coverage probability, this is called a ")
cat("\"anti-conservative\" or \"permissive\" confidence interval.\n")
cat("Another reason for the CI in b) being not equal to the nominal coverage prob. is ")
cat("the fact that we have used a continuous distribution (the normal dist.) to approximate ")
cat("a discrete distribution (the binomial distribution).")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE