# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
k <- 100
sample_size <- sample(k:(2*k),1)
sample_mean <- runif(1,0,k)
sample_sd <- rexp(1,1/k)
x <- rnorm(sample_size, sample_mean, sample_sd)

source("globalFunctionRepository.R")

file_header(3, 6)
cat("The problem: Histogram\n")
cat("Set k <- 100 and generate x <- rnorm(sample(k:(2*k),1), runif(1,0,k), rexp(1,1/k)).\n\n")
cat("\ta) Explain what is realized in x.\n\n")
cat("\tb) Plot a histogram of x. Mark its mean in red, its standard deviation in blue and add a ")
cat("legend which explains them both. Helpful commands: hist(), mean(), sd(), lines(), ")
cat("abline(), arrows(), legend().")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("x is a random sample from a normal distribution with the following properties:\n\n")
cat("\tSample size: sample(k:(2*k), 1)\n")
cat("\t[Draws at random a single number from a sample of natural ")
cat("numbers starting at k = 100 and ending with 2*k = 300]\n\n")

cat("\tMean of normal distribution: runif(1,0,k)\n")
cat("\t[Gets a single random number from an uniform distribution U(0, 100)]\n\n")

cat("\tStandard deviation of normal distribution: rexp(1,1/k)\n")
cat("\t[Gets a single random number from an exponential distribution exp(1/100)]\n\n")

cat("In the current execution run, we have drawn", sample_size, "random samples from ")
cat("an N(")
cat(sample_mean)
cat(", ")
cat(sample_sd^2) # Note the exponentiation to get the variance, since R uses the sd in rnorm!
cat(")-distribution.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("See generated histogram.")

w <- (max(x) - min(x)) / 30
b <- seq(min(x), max(x)+w, w)
title <- "Histogram of x = rnorm(sample(100:200,1), runif(1,0,100), rexp(1,1/100))"
title_sub <- sprintf("(= %d samples from N(%.2f, %.2f))", sample_size, sample_mean, sample_sd)
hist_data <- hist(x, breaks = b, main = title, sub = title_sub, las = 1)
abline(v = sample_mean, col = "red", lwd = 3)
line_x = c(sample_mean - sample_sd, sample_mean + sample_sd)
line_y = c(max(hist_data$counts) / 2, max(hist_data$counts) / 2)
arrows(line_x[1], line_y[1], line_x[2], line_y[2], code = 3, col = "blue", lwd = 3, angle = 90, length = 0.1)
leg1 <- sprintf("Mean of x (= %.2f)", sample_mean)
leg2 <- sprintf("+/- one SD (= +/- %.2f) from mean", sample_sd)
legend("topright", col = c("red", "blue"), legend = c(leg1, leg2), lty = c(1, 1), lwd = c(3, 3))
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE