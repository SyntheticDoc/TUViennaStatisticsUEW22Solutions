# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
alpha <- 0.05
mu_0 <- 550
df <- 50 - 1

source("globalFunctionRepository.R")
source("HW8_helper.R")

file_header(2, 8)
cat("The problem: One-sample t-test (with R)\n")
cat("Two programmers are developing a computer game in which a BMX rider has to pass a ")
cat("parcours. The goal is to cover as much distance as possible. They are interested in the mean ")
cat("distance covered by a layman, who plays the game for the first time. For that they let some ")
cat("trialists play the game and for each player note the distance covered. The distances (unit ")
cat("meter) are found in the file dist.Rdata.\n\n")
cat("Test the null hypothesis, that the mean distance covered by a layman is 550 meters using a
two-sided one-sample t-test. Set the significance level to alpha = 5%.\n\n")
cat("Proceed as follows:\n\n")
cat("\ta) Create a histogram to visualize the data. Are the data approximately bell-shaped?\n")
cat("\t   Mark the null hypothesis, the mean and the standard error of the mean (i.e., mean +/-\n")
cat("\t   one standard error of the mean). Add labels and legends.\n")
cat("\tb) Calculate the t-statistic (without using t.test())\n")
cat("\tc) Calculate the p-value (without t.test()). Do you reject the null hypothesis?\n")
cat("\td) Interpret your result.\n")
cat("\te) Now perform the test using t.test() and compare your results.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
# Standard error of mean: SEM := S / sqrt(n)
# SEM is the estimated variability of the mean
# Similar to standard deviation of mean: sigma_x_bar = sigma / sqrt(n)
# t-test measures discrepancy X_bar - mu_0 in units SEM: T = (X_bar - mu_0) / SEM
cat("SOLUTION FOR a)\n")
cat("We begin by loading the data:\n\n")
dat_name <- load("dist.Rdata")
cat("  ... Data successfully loaded into \"")
cat(dat_name)
cat("\"\n\n")
cat("Data (sorted):", sort(distanz), "\n\n")
cat("Data length n =", length(distanz), "\n\n")

cat("See the attached histogram for the rest of this solution. The data seems to be ")
cat("approximately bell-shaped.")

col_norm <- "darkorange3"
col_density <- "Red"
col_mu_marker <- "Blue"
col_mean_marker <- "Blue"
col_sem <- "darkmagenta"

S_hist <- calc_SEM(distanz)

title <- "Histogram of distance covered by players (H0 : µ0 = 550)"
hist(distanz, breaks = 30, main = title, las = 1, freq = FALSE, xlab = "Distance (in m)", xlim = c(0, 1200))
grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)

curve(dnorm(x, mean = mu_0, sd = sd(distanz)), col = col_norm, lwd = 2, add = TRUE)
lines(density(distanz), col = col_density, lwd = 2)

norm_name <- sprintf("N(%.2f, %.2f^2)", mu_0, sd(distanz))
legend("topright", legend = c(norm_name, "Density of distance"), col = c(col_norm, col_density), lwd = c(2, 2), lty = c(1, 1))
abline(v = mu_0, col = col_mu_marker, lty = 3, lwd = 3)
abline(v = mean(distanz), col = col_mean_marker, lty = 2, lwd = 3)
arrows(mean(distanz) - S_hist, 0.001, mean(distanz) + S_hist, 0.001, angle = 90, code = 3, 
       col = col_sem, lwd = 3, length = 0.1)
text(530, 0.00053, labels = "µ0", col = col_mu_marker, cex = 1.3)
text(645, 0.00053, labels = "µ (mean)", col = col_mean_marker, cex = 1.3)
text(675, 0.0011, labels = "SEM", col = col_sem, cex = 1.3)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
n <- length(distanz)
S_squared <- calc_empirical_sigma(distanz, mean(distanz))
S <- sqrt(S_squared)
t <- (mean(distanz) - mu_0)/(S / sqrt(n))

cat("First, we calculate the empirical variance:\n\n")
cat("\t", get_string_empirical_sd_formula(), "=", S_squared, "\n\n")
cat("Thus, our empirical standard deviation S is:", S, "\n\n")
cat("Lets calculate the t-statistic now:\n\n")
cat(sprintf("\tt = (x_bar - µ0)/(S / sqrt(n)) = (%.3f - %d)/(%.3f / %.3f) = %.5f", 
            mean(distanz), mu_0, S, sqrt(n), t))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
p <- 2 * min(pt(t, df), 1 - pt(t, df))
cat("The p-value for two-sided tests is defined as:\n\n")
cat("\tp = P_H0(|Z| >= |z|)\n\n")
cat("This can also be expressed as:\n\n")
cat("\tp = 2 * min(P_H0(Z >= z), P_H0(Z <= z))\n\n")
cat("We can calculate this easily in R with:\n\n")
cat("\tp = 2 * min(pt(t, df), 1 - pt(t, df)) =", p)

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("Since p =", p, "and alpha = 0.05, we see that p > alpha. We reject H0, thus.")

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e)\n")
cat("The results via \"t.test(distanz, mu = 550, conf.level = 0.95)\":\n")
t_test_results <- capture.output(t.test(distanz, mu = 550, conf.level = 0.95))

for(s in t_test_results) {
  cat(s, "\n")
}

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE