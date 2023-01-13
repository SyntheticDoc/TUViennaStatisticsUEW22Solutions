# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("problem 4b.R")
source("HW8_helper.R")

file_header(4, 8)
cat("The problem: One-sample confidence intervals\n")
cat("a) Let I = (X_bar + q_alpha/2 * SEM, X_bar + q_1-alpha/2 * SEM) be Student’s (1-alpha)*100%-confidence interval\n")
cat("   for the expectation, while q_alpha is the alpha-quantile of the t(n)-distribution (for alpha in (0, 1)).\n")
cat("   Comment on the following statements:\n\n")
cat("\t i) At level alpha = 10% the confidence interval I is smaller than at level alpha = 5%\n")
cat("\t ii) The sample size is n - 1\n")
cat("\tiii) If the sample size is doubled, then the width of the confidence interval is halved\n")
cat("\t iv) The probability to find the expectation left of I is at the most alpha\n")
cat("\t  v) If I overlaps the expectation, then the null hypothesis is not significant\n\n")
cat("b) Messages are regularly sent from a sender to a receiver. For randomly chosen messages\n")
cat("   the transfer times were measured and stored in the file waitingtimes.Rdata.\n\n")
cat("\t  i) Represent the data in a histogram. Is the distribution approximately bell-shaped?\n")
cat("\t ii) Construct an approximate 99%-confidence interval for the expectation and plot it\n")
cat("\t     into the graphic.\n")
cat("\tiii) An engineer claims that the mean transfer time is 1.5 seconds. Are the measurements\n")
cat("\t     compatible with this statement?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("i) [At level alpha = 10% the confidence interval I is smaller than at level alpha = 5%]\n")
cat("TRUE.\n")
cat("We know from the t-distribution that qt(0.05) < qt(0.1) and qt(1-0.05) > qt(1-0.1). ")
cat("Therefore, the statement above is correct, since qt(0.05) < qt(0.1) < qt(1-0.1) < qt(1-0.05).\n\n")

cat("ii) [The sample size is n - 1]\n")
cat("FALSE.\n")
cat("Since we have been given the distribution as t(n) already and we know that the ")
cat("degrees of freedom of t equal n - 1, the sample size must be n + 1 here, accordingly.\n\n")

cat("iii) [If the sample size is doubled, then the width of the confidence interval is halved]\n")
cat("FALSE.\n")
cat("The width of the confidence interval is:\n\n")
cat("\t(X_bar + q_alpha/2 * (S/sqrt(n))) - (X_bar - q_alpha/2 * (S/sqrt(n)))\n\n")
cat("If X_bar = a and q_alpha/2 * S = b, we calculate:\n\n")
cat("\t(a + (b/sqrt(n)) - (a - (b/sqrt(n)) = a + b/sqrt(n) - a + b/sqrt(n) = 2b/sqrt(n)\n\n")
cat("Lets now determine the size increase of the Interval when we double n:\n\n")
cat("\t((2b)/sqrt(n))/((2b)/sqrt(2n)) = (2b*sqrt(2n))/(sqrt(n)*2b)\t[Cancel common factor 2b]\n")
cat("\t= sqrt(2n)/sqrt(n) = (sqrt(2)*sqrt(n))/sqrt(n)\t\t\t[Cancel common factor sqrt(n)]\n")
cat("\t= sqrt(2)\n\n")
cat("Thus, the Interval shrinks only by sqrt(2) instead of 2 if n doubles.\n\n")

cat("Another way to calculate:\n\n")
cat("\tWidth of CI: (X_bar + q_alpha/2 * (S/sqrt(n))) - (X_bar - q_alpha/2 * (S/sqrt(n)))\n")
cat("\t= X_bar + q_alpha/2 * (S/sqrt(n)) - X_bar + q_alpha/2 * (S/sqrt(n))\n")
cat("\t= 2 * q_alpha/2 * (S/sqrt(n))\n\n")
cat("Thus, if we double n, the new width w2 is the old width * factor:\n\n")
cat("\tfactor = w2/w1 = (2 * q_alpha/2 * (S/sqrt(2*n))) / (2 * q_alpha/2 * (S/sqrt(n)))\n")
cat("\t= (S/sqrt(2*n)) / (S/sqrt(n)) = (S/(sqrt(2) * sqrt(n)) * (sqrt(n))/S) = 1/sqrt(2)\n\n")
cat("\t=> w2 = w1 * factor = w1 * 1/sqrt(2) ~= w1 * 0.707\n\n")

cat("iv) [The probability to find the expectation left of I is at the most alpha]\n")
cat("FALSE.\n")
cat("The probability to find the expectation left of I is at most alpha/2, since the ")
cat("t-distribution is symmetric.\n\n")

cat("v) [If I overlaps the expectation, then the null hypothesis is not significant]\n")
cat("FALSE (depending on interpretation).\n")
cat("Saying \"the null hypothesis is not significant\" does not make much sense, since ")
cat("the null hypotheses itself has no property \"significance\", only the discrepancy ")
cat("between two values can be significant. However, if I overlaps the expectation, ")
cat("this still doesn't tell us anything about H0. Only if I also overlaps mu_0 ")
cat("(which it does with 1-alpha probability if H0 : mu = mu_0), we could say anything ")
cat("about H0.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
dat_name <- load("waitingtimes.Rdata")
cat("  ... Data successfully loaded into \"")
cat(dat_name)
cat("\"\n\n")
cat("Data (sorted):", sort(wz), "\n\n")
cat("Data length n =", length(wz), "\n\n")

cat("i)\n\n")
cat("See the generated histogram.\n\n")
cat("The distribution looks a bit bell-shaped, more like a mixture of a normal and ")
cat("an exponential distribution. We perform a Shapiro-Wilk normality test to see ")
cat("if our data could probably come from a normal distribution:\n\n")
shap_result <- capture.output(shapiro.test(wz))

for(s in shap_result) {
  cat(s, "\n")
}

cat("The answer is no, since p < 0.05.\n\n")

par(mfrow=c(1,1))

draw_hist(wz)

cat("ii)\n\n")
cat("We construct a confidence interval of alpha = 0.01 and get:\n\n")
ci <- get_conf_inf_non_normal(wz, 0.01)
cat(sprintf("\tI = (%.4f, %.4f)\n\n", ci[1], ci[2]))
cat("See the generated plot for the added CI.\n\n")

sample_mean <- mean(wz)
cat("  1) Calculate the sample mean:\n")
cat("\tsample_mean = mean(wz) =", mean(wz), "\n\n")

sample_sd <- sqrt(calc_empirical_sigma(wz, sample_mean))
cat("  2) Calculate the empirical standard deviation:\n")
cat("\tsample_sd = sqrt(calc_empirical_sigma(wz, mean(wz))) =", sample_sd, "\n\n")

sem <- sample_sd/sqrt(length(wz))
cat("  3) Calculate SEM:\n")
cat("\tsem = sample_sd/sqrt(length(wz)) =", sem, "\n\n")

alpha <- 0.01
factor <- qnorm(1 - alpha/2) * sem
cat("  4) Calculate factor for CI:\n")
cat("\tfactor = qnorm((1 - alpha)/2) * sem =", factor, "\n\n")

ci_upper <- sample_mean + factor
ci_lower <- sample_mean - factor
cat("  5) Calculate CI-bounds:\n")
cat("\tUpper bound = sample_mean + factor =", ci_upper, "\n")
cat("\tLower bound = sample_mean - factor =", ci_lower, "\n\n")

cat("The resulting 99%-confidence interval thus is:\n\n")
cat(sprintf("\tI = (%.3f, %.3f)\n\n", ci_lower, ci_upper))

draw_hist(wz, plot_ci = TRUE, ci = ci)

cat("iii)\n\n")
cat("Since the upper bound of the CI is", ci[2], "the claim that the mean transfer ")
cat("time is 1.5s is not substantiated, since 1.5 lies outside of the CI.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE