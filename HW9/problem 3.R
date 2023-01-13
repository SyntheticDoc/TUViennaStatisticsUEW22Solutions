# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("HW9_helper.R")
alpha <- 0.01

file_header(3, 9)
cat("The problem: Two-sample t-test using normal approximation\n")
cat("Messages are frequently sent from a sender to either receiver 1 or receiver 2. ")
cat("For both receivers, several times for the transfer were measured (in seconds) ")
cat("and stored in the file waitingtimes2.Rdata.\n\n")
cat("\ta) Visualize both data sets. Are the distributions approximately bell-shaped?\n")
cat("\tb) Test the null-hypothesis of equal mean transfer times for both receivers on \n")
cat("\t   the 1%-level with a two sample t-test (using the normal approximation).\n")
cat("\tc) Compare your result to the output of t.test().")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("GENERAL SECTION\n")
cat("We start by loading the data:\n\n")
dat_name <- load("waitingtimes2.Rdata")
cat("Data was loaded into", dat_name, "\n")
cat("The data contains", length(wt), "datasets with of the following sizes:\n")

for(i in 1:length(wt)) {
  cat(sprintf("  Dataset %d: n = %d", i, length(wt[[i]])))
  
  if(i < length(wt)) {
    cat("\n")
  }
}

cat("\n\nEND OF GENERAL SECTION")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("See the generated histograms for a visualization of both sets.\n\n")

par(mfrow=c(2,1))

for(i in 1:length(wt)) {
  title <- sprintf("Histogram for dataset %d", i)
  hist(wt[[i]], breaks = 30, main = title, las = 1, freq = FALSE, xlab = "Transfer time (in s)")
  lines(density(wt[[i]]), col = "Orange", lwd = 2)
  abline(v = mean(wt[[i]]), col = "Blue", lwd = 3, lty = 2)
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)
  legend("topright", legend = c(sprintf("Mean = %.2f", mean(wt[[i]])), "Density of data"), 
         lwd = c(3, 2), col = c("Blue", "Orange"), lty = c(2, 1))
}

cat("Both data sets don't seem to be normally distributed. Lets verify this intuition ")
cat("with a Shapiro-Wilk normality test:\n\n")

for(i in 1:length(wt)) {
  cat("Test for dataset", i, "\n")
  shap_result <- capture.output(shapiro.test(wt[[i]]))
  
  for(s in shap_result) {
    cat(s, "\n")
  }
}

cat("Since both tests yield p-values far smaller than 0.05, we can safely assume ")
cat("that both sets indeed aren't normally distributed.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Since both datasets aren't bell-shaped, we use a normal approximation to ")
cat("test H0 (mean of both datasets is equal). Lets first calculate the test ")
cat("statistic:\n\n")

mean_1 <- mean(wt[[1]])
mean_2 <- mean(wt[[2]])
sem_1 <- calc_SEM(wt[[1]]) # See Hw9_helper.R for code for calc_SEM()
sem_2 <- calc_SEM(wt[[2]])
t <- (mean_1 - mean_2)/(sqrt(sem_1^2 + sem_2^2))

cat("\tt = (sample_1_bar - sample_2_bar)/(sqrt(SEM_sample_1^2 + SEM_sample_2^2))\n")
cat(sprintf("\t= (%.3f - %.3f) / (sqrt(%.3f^2 + %.3f^2)) = %.3f\n\n", mean_1, mean_2, sem_1, sem_2, t))

cat("Lets calculate the Rejection area R by approximating the t-distribution with ")
cat("the N(0, 1)-distribution:\n\n")

cat(sprintf("\tR = (-inf, %.3f] and [%.3f, inf)\n\n", qnorm(alpha/2), qnorm(1 - alpha/2)))

cat(sprintf("t = %.3f is not within the rejection area, so we have no reason to reject H0.\n\n", t))

cat("We could also approximate the p-value with N(0, 1):\n\n")

cat(sprintf("\tp = %.3f\n\n", 2 * pnorm(-abs(t))))

cat("p > alpha = 0.01, giving us also enough reason to reject H0.\n\n")

cat("We can also calculate our 99% confidence interval using a normal approximation:\n\n")

cat("\tI = (sample_1_bar - sample_2_bar) - q_1-alpha/2 * sqrt(SEM_sample_1^2 + SEM_sample_2^2),\n")
cat("\t(sample_1_bar - sample_2_bar) + q_1-alpha/2 * sqrt(SEM_sample_1^2 + SEM_sample_2^2)\n\n")

# Note the usage of qnorm below, since both samples aren't normally distributed with
# high probability (as given in the Shapiro-Wilk tests above)
factor <- qnorm(1 - alpha/2) * sqrt(sem_1^2 + sem_2^2)
upper_limit <- (mean_1 - mean_2) - factor
lower_limit <- (mean_1 - mean_2) + factor

# Switch limits if upper limit < lower limit
if(upper_limit < lower_limit) {
  temp <- upper_limit
  upper_limit <- lower_limit
  lower_limit <- temp
}

cat(sprintf("\tI = (%.3f, %.3f)\n\n", lower_limit, upper_limit))

cat("The Interval I overlaps d = 0. Thus, we have no reason do reject H0. We conclude:\n\n")

cat("\tDon't reject H0.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("Lets do a proper t-test in R:\n")
# Capture full console text output of the t-test:
result <- capture.output(t.test(wt[[1]], wt[[2]], conf.level = 1-alpha))
# Do t-test a second time to extract t-statistic and p-value
t_test_values <- t.test(wt[[1]], wt[[2]], conf.level = 1-alpha)
p_val <- t_test_values$p.value

for(s in result) {
  cat(s, "\n")
}

cat("The t-test yields the same t-statistic and about the same confidence interval ")
cat("as we have calculated. Furthermore, the t-test shows that p-value = ")
cat(p_val)
cat(", being practically the same as the value we have approximated. Small differences ")
cat("in the results of the built in R-function and our own calculations are due to the ")
cat("fact that we used a normal approximation, while the R-function calculated the ")
cat("degrees of freedom of the underlying t-distribution itself and therefore didn't use ")
cat("a normal approximation. As expected, the built in function also yields no reason ")
cat("to reject H0. We conclude again:\n\n")

cat("\tDon't reject H0.\n\n")

mean_dif <- (mean(wt[[2]]) - mean(wt[[1]]))
sample_1_range <- (max(wt[[1]]) - min(wt[[1]]))
sample_2_range <- (max(wt[[2]]) - min(wt[[2]]))
mean_dif_range_1 <- mean_dif / sample_1_range
mean_dif_range_2 <- mean_dif / sample_2_range
mean_dif_range_arith_mean <- (mean_dif_range_1 + mean_dif_range_2) / 2
cat("Note about qnorm()/qt(): Interestingly, since we used qnorm() in our calculations above and the ")
cat("t.test()-function gives us a slightly larger confidence interval than we ")
cat("calculated ourselves, t.test() most probably used qt() for calculating the CI. ")
cat("More credence is given to this claim since with qt() instead of qnorm(), the ")
cat("resulting CI will always be slightly larger than the CI derived from using qnorm(), ")
cat("since the t-distribution is more tail-heavy than the normal distribution. ")
cat("However, the difference in CI widths is small enough that we don't reject H0 ")
cat("in both cases for these specific samples, with or without using a normal approximation. ")
cat("Intuitively, this is understandable, since the histograms of both datasets look pretty ")
cat(sprintf("similar and their means differ only by about %.2f%% of the complete data range ", 100*mean_dif_range_arith_mean))
cat(sprintf("(range = %.3f for sample 1, %.3f for sample 2).", sample_1_range, sample_2_range))

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE