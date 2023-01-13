# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
cals <- c(186, 181, 176, 149, 184, 190, 158, 139, 175, 148, 152, 111, 141, 153, 190, 157, 131, 149, 135, 132)

source("globalFunctionRepository.R")
source("HW8_helper.R")

file_header(5, 8)
cat("The problem: Confidence interval\n")
cat("In the June 1986 issue of Consumer Reports, some data on the calorie content of beef hot ")
cat("dogs is given. Here are the numbers of calories in 20 different hot dog brands:\n\n")
cat("\t", cals, "   [n = ")
cat(length(cals))
cat("]\n\n")
cat("Assume that the numbers are from a normal distribution with mean µ and variance sigma^2, both ")
cat("unknown. Use R to obtain a 90% confidence interval for the mean number of calories µ.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("Lets draw a histogram of the data to visualize it.\n\n")

col_norm <- "Blue"
col_density <- "Red"

title <- "Histogram of calorie content of beef hot dogs"
hist(cals, breaks = 20, main = title, las = 1, freq = FALSE, xlab = "Calories (in kcal)")
grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)

curve(dnorm(x, mean = mean(cals), sd = sd(cals)), col = col_norm, lwd = 2, add = TRUE)
lines(density(cals), col = col_density, lwd = 2)

norm_name <- sprintf("N(%.2f, %.2f^2)", mean(cals), sd(cals))
legend("topright", legend = c(norm_name, "Density of calories"), 
       col = c(col_norm, col_density), lwd = c(2, 2), lty = c(1, 1))

cat("We let R do all necessary calculations to get the CI:\n\n")

sample_mean <- mean(cals)
cat("  1) Calculate the sample mean:\n")
cat("\tsample_mean = mean(cals) =", mean(cals), "\n\n")

sample_sd <- sqrt(calc_empirical_sigma(cals, sample_mean))
cat("  2) Calculate the empirical standard deviation:\n")
cat("\tsample_sd = sqrt(calc_empirical_sigma(cals, mean(cals))) =", sample_sd, "\n\n")

sem <- sample_sd/sqrt(length(cals))
cat("  3) Calculate SEM:\n")
cat("\tsem = sample_sd/sqrt(length(cals)) =", sem, "\n\n")

alpha <- 0.1
factor <- qt(alpha/2, length(cals) - 1) * sem
cat("  4) Calculate factor for CI:\n")
cat("\tfactor = qt((1 - alpha)/2, length(cals) - 1) * sem =", factor, "\n\n")

ci_upper <- sample_mean + factor
ci_lower <- sample_mean - factor
cat("  5) Calculate CI-bounds:\n")
cat("\tUpper bound = sample_mean + factor =", ci_upper, "\n")
cat("\tLower bound = sample_mean - factor =", ci_lower, "\n\n")

temp <- ci_upper
ci_upper <- ci_lower
ci_lower <- temp
cat("  5.1) Since ci_lower > ci_upper, flip both variables. Result:\n")
cat("\tUpper bound =", ci_upper, "\n")
cat("\tLower bound =", ci_lower, "\n\n")

cat("The resulting 90%-confidence interval thus is:\n\n")
cat(sprintf("\tI = (%.3f, %.3f)\n\n", ci_lower, ci_upper))

ci_func <- get_conf_inf(cals, alpha)
cat("Lets calculate the same now with my own confidence-interval-function:\n\n")
cat(sprintf("\tget_conf_inf(cals, alpha) = (%.3f, %.3f)", ci_func[1], ci_func[2]), "\n\n")

cat("We can verify our solution with a t-test:\n\n")
t_test_results <- capture.output(t.test(cals, mu = mean(cals), conf.level = 0.90))

for(s in t_test_results) {
  cat(s, "\n")
}

cat("\n\nEND OF SOLUTION FOR")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE