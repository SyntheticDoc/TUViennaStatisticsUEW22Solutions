# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("HW9_helper.R")

file_header(5, 9)
cat("The problem: Simulation of test-power\n")
cat("Simulate the distribution of the p-value in the two-sided two-sample t-test: ")
cat("Let X1, ..., X20, Y1, ..., Y20 be independent random variables with Xi ~ N(0, 1) ")
cat("and Yi ~ N(d, 1) for all i = 1, 2, ..., 20. For each d in {0, 0.25, 0.5}, ")
cat("derive p-values in 10000 simulations (H0 : d = 0) and plot them in a histogram ")
cat("of unit area. Comment on your three histograms.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR\n")
cat("See the generated plots for the histogram data.\n\n")
# Since df is constant in this exercise, take it out of all functions to prevent
# unneccessary repeated variable assignments:
df <- (20 + 20 - 2)

# The p-value for two-sided tests is defined as:
# p = P_H0(|Z| >= |z|)
# This can also be expressed as:
# p = 2 * min(P_H0(Z >= z), P_H0(Z <= z)))
# We can calculate this easily in R with
# p = 2 * min(pt(t, df), 1 - pt(t, df))
# = 2 * pt(-abs(t), df)
#
# Since both population variances are = 1 in our case, we assume equal variances
# and use model "Student" for our calculations
get_p_val <- function(X, Y) {
  # Since d0 = 0, we can omit d0 in (mean(X) - mean(Y) - d0)
  std_err <- get_std_err_student(X, Y) # See HW9_helper.R for code for get_std_err_student()
  t <- (mean(X) - mean(Y)) / std_err
  p = 2 * pt(-abs(t), df)
  return(p)
}

# Simulation variables
iterations <- 10000
d_vals <- c(0, 0.25, 0.5)

# Pregenerated matrix to hold p-values - columns are d-values, rows are p-values
p_matrix <- matrix(nrow = iterations, ncol = 3)

# Margin of error for comparing own results to t.test(), since float values should
# never be compared with equal or == because of rounding or truncation issues
margin_of_error <- 0.00001

# If the execution of the simulation takes to long, set the following variable to
# false to skip time consuming t.test()-calculations in each iteration step, which
# are only used for verification, anyway
skip_verification <- TRUE

# SIMULATION STARTS HERE
cat("Starting simulation with", iterations, "iterations...\n")

for(d_i in 1:3) {
  d <- d_vals[d_i]
  cat("  Simulating d =", d, "\n")
  
  for(i in 1:iterations) {
    X_i <- rnorm(20)
    Y_i <- rnorm(20, mean = d, sd = 1)
    
    p_val <- get_p_val(X_i, Y_i)
    
    if(!skip_verification) {
      # Verify result
      test_p_val <- t.test(X_i, Y_i, var.equal = TRUE)$p.value
      
      if(p_val < (test_p_val - margin_of_error) | p_val > (test_p_val + margin_of_error)) {
        error_msg <- sprintf("p_val != test_p_val (%f != %f)", p_val, test_p_val)
        stop(error_msg)
      }
    }
    
    p_matrix[i, d_i] <- p_val
  }
}

cat("Simulation finished!\n\n")
# SIMULATION ENDS HERE

par(mfrow=c(3,1))

# Start drawing histograms
for(d_i in 1:3) {
  d <- d_vals[d_i]
  p_data <- p_matrix[,d_i]
  
  title <- sprintf("Histogram of p-values for d = %.2f", d)
  hist(p_data, breaks = 30, main = title, las = 1, freq = FALSE, xlab = "p-values")
  lines(density(p_data), col = "Orange", lwd = 2)
  abline(v = mean(p_data), col = "Blue", lwd = 3, lty = 2)
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)
  legend("topright", legend = c(sprintf("Mean = %.2f", mean(p_data)), "Density of data"), 
         lwd = c(3, 2), col = c("Blue", "Orange"), lty = c(2, 1))
}

cat("COMMENT:\n\n")
cat("We see that the p-values are pretty uniformly distributed in the first case, ")
cat("where the means of both samples are equal in truth. If we had a alpha of for ")
cat("example 0.05, this would indeed mean that we would reject the (true!) null ")
cat("hypothesis of equal means in about 5% of all cases - which is exactly the ")
cat("definition of the Type I error with respect to alpha. Using p-values to ")
cat("interpret the outcome of the test, we would make the wrong decision as ")
cat("often as expected, given a certain alpha.\n")
cat("When the means of both samples are not equal, but very close to each other ")
cat("(d = 0.25), we see the distribution of the p-values getting skewed towards ")
cat("p = 0, which means the t-test is starting to recognize a difference in both ")
cat("means, albeit not very often. We are safe to assume that the test power is ")
cat("already ok with the exact model 'Student' of the t-test we use here, but it ")
cat("could be better - we would often miss the difference in means here.\n")
cat("When the means are even further apart (d = 0.5), the test power of the t-test ")
cat("naturally increases steeply, as evidenced by the last histogram. The z- and t-tests ")
cat("are much better in identifying large discrepancies than small ones, and the ")
cat("t-test would start to rightfully reject H0 (mean(X) = mean(Y)) pretty often ")
cat("in this last case (depending on the choice of alpha, of course).")

cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE