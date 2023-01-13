# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("HW9_helper.R")

file_header(2, 9)
cat("The problem: Two-sample t-test\n")
cat("Create two independent samples from the normal distribution. The first sample of size 10 ")
cat("shall be taken from the standard normal distribution. The second sample of size 20 shall be ")
cat("taken from the N(1, 1)-distribution. Test the null hypothesis that the populations means are ")
cat("equal with a (two-sided) two-sample t-test at the 5%-significance level:\n\n")
cat("\ta) Calculate the t-statistic (without t.test()).\n")
cat("\tb) Compare it to the output of t.test().\n")
cat("\tc) Interpret the result of the test.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("GENERAL SECTION\n")
cat("We start by generating the two samples from the normal distribution as stated ")
cat("above and set alpha to 0.05.")
sample_1 <- rnorm(10) # 10 samples from N(0, 1)
sample_2 <- rnorm(20, mean = 1, sd = 1) # 20 samples from N(1, 1)
alpha <- 0.05

cat("\n\nEND OF GENERAL SECTION")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Since the variance in both populations is 1, we assume equal variances and ")
cat("use the t-test model \"Student\" here, which uses the following test statistic:\n\n")

cat("\tt = (x_bar - y_bar)/(sqrt((1/n1 + 1/n2) * (S_p)^2))\n")
cat("\twith S_p^2 = ((n1 - 1)*S_x^2 + (n2 - 1)*S_y^2)/(n1 + n2 - 2)\n\n")

cat("We will calculate this t-statistic now for our samples (see HW9_helper.R for ")
cat("the corresponding code for get_std_err_student()):\n\n")

mean_1 <- mean(sample_1)
mean_2 <- mean(sample_2)
std_err_student <- get_std_err_student(sample_1, sample_2) # See HW9_helper.R for code
t <- (mean_1 - mean_2)/std_err_student

cat("\tt = (sample_1_bar - sample_2_bar)/std_err_student\n")
cat(sprintf("\t= (%.3f - %.3f) / %.3f = %.3f", mean_1, mean_2, std_err_student, t))

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Lets calculate the t-statistic by using t.test() now:\n")
# Capture full console text output of the t-test:
result <- capture.output(t.test(sample_1, sample_2, conf.level = 1-alpha, var.equal = TRUE))
# Do t-test a second time to extract t-statistic and p-value
t_test_values <- t.test(sample_1, sample_2, conf.level = 1-alpha, var.equal = TRUE)
t_stat <- t_test_values$statistic
p_val <- t_test_values$p.value

for(s in result) {
  cat(s, "\n")
}

cat("We see that the t-statistic from t.test() (= ")
cat(t_stat)
cat(") is equal to the value we calculated manually (= ")
cat(t)
cat(").")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("H0: The difference of the means of sample_1 and sample_2 is equal to 0.\n")
cat("Reject H0 if p <= alpha.\n")
cat("Given the data above, we conclude:\n\n")

if(p_val <= alpha) {
  cat(sprintf("\tp = %.3f <= %.2f\n\tReject H0.", p_val, alpha))
} else {
  cat(sprintf("\tp = %.3f > %.2f\n\tDon't reject H0.", p_val, alpha))
}


cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE