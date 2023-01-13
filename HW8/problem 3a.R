# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("problem 3b.R")
load("dist.Rdata")
dist3x <- rep(distanz, 3)
use_own_data <- FALSE
mu_0 <- 550

# For fun and profit, generate more randomly distributed sample data by assuming 
# "distanz" is normally distributed
dist3x_generated <- rnorm(150, mean = mean(distanz), sd = sd(distanz))

file_header(3, 8)
cat("The problem: Effect of sample size\n")
cat("Consider the situation of the previous exercise except that three times the number of laymen ")
cat("played the game (for simplicity, literally repeat each sample 3 times). Call this new data set ")
cat("dist3x.\n\n")
cat("\ta) Perform a t-test. What is your conclusion?\n")
cat("\tb) Represent the data from dist.Rdata as well as dist3x each in a histogram, arranged\n")
cat("\t   below each other (par(mfrow=c(2,1))). Mark the mean, the 1se interval around the\n")
cat("\t   mean, as well as the value 550 meters.\n")
cat("\tc) Discuss your graphic regarding the outcomes of the tests.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("The results via \"t.test(dist3x, mu = 550, conf.level = 0.95)\":\n")
t_test_results <- capture.output(t.test(dist3x, mu = 550, conf.level = 0.95))

for(s in t_test_results) {
  cat(s, "\n")
}

if(use_own_data) {
  cat("\nThe results via \"t.test(dist3x_generated, mu = 550, conf.level = 0.95)\":\n")
  t_test_results_own <- capture.output(t.test(dist3x_generated, mu = 550, conf.level = 0.95))
  
  for(s in t_test_results_own) {
    cat(s, "\n")
  }
}

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("See generated histograms for the solution.")
# Set to matrix plotting
par(mfrow=c(2,1))

draw_hist(distanz, "Histogram of distanz", mu_0)
draw_hist(dist3x, "Histogram of dist3x", mu_0)

if(use_own_data) {
  draw_hist(distanz, "Histogram of distanz", mu_0)
  draw_hist(dist3x_generated, "Histogram of dist3x_generated", mu_0)
}

# Restore usual mfrow settings
par(mfrow=c(1,1))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("We see that with increasing sample size n, the SEM S/sqrt(n) is getting smaller ")
cat("(obviously). From the Gütefunktion (power function), we know that the sample ")
cat("size appears as a multiplicative factor in its formula.  With increasing sample ")
cat("size, as the SEM gets smaller, the test power increases. Note however, that this ")
cat("is not always desirable, since with increasing test power, detected effects ")
cat("get smaller and smaller - and it is questionable if the detection of arbitrarily ")
cat("small effects is desirable from a scientific viewpoint.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE