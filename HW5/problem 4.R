# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
mean_X <- 5
var_X <- 4
mean_S <- 50*mean_X
var_S <- 50*var_X
mean_X_bar <- mean_X
var_X_bar <- var_X/50

source("globalFunctionRepository.R")

file_header(4, 5)
cat("The problem: Sum and average\n")
cat("Let X be a random variable with N(5, 4). Let X_1, X_2, ..., X_50 be independent identically ")
cat("distributed copies of X. Let S be their sum and X_bar their average, i.e.")
cat("\n\n")
cat("\tS = X_1 + ... + X_50 and\n")
cat("\tX_bar = (1/50)*(X_1 + ... + X_50)\n\n")
cat("(a) Plot the density of X.\n\n")
cat("(b) What are the expectation and the standard deviation of S and of X_bar?\n\n")
cat("(c) Use R to generate a sample of 50 numbers from N(5, 4). Plot the histogram for this ")
cat("sample. Do the same for a sample of 500 numbers from N(5, 4).\n\n")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Since we have given X ~ N(5, 4), we can easily plot its density (see graphic)")

# Define resolution for sampling the density
res <- 10000

# Get x-values to sample the normal distribution in a range of +/- 5 standard deviations
# Adjust x-values by mean to be centered at the mean of N(5, 4) instead of y = 0
x <- seq(-5, 5, length = res) * sqrt(var_X) + mean_X

# Sample density of normal distribution by x
y <- dnorm(x, mean_X, sqrt(var_X))

# Create custom title
main_title <- "Density of N(5, 4)"

# Customize inner margins for plot
par(mai = c(1, 1, 1, 0.5))

plot(x, y, type = "l", ylab = "P(X = x)", las = 1)

# Add title to plot
title(main_title, line = 4)

# Add custom axis label for top axis
mtext("Standard deviations", 3, line = 2)

# Add axis above plot for showing standard deviations instead of x
axis(3, at = c(-5, -3, -1, 1, 3, 5, 7, 9, 11, 13, 15), las = 1, labels = seq(-5, 5, by = 1))

plot(seq(0, 10, length = res), main = "Cdf of N(5,4)", xlab = "x", ylab = "F(x)", pnorm(x, mean_X, sqrt(var_X)), type = "l")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("According to the addition rule from the slides (since X_1, ..., X_50 are independent), ")
cat("we derive:\n\n")

cat("\tS ~ N(sum(mean_X_1, ..., mean_X_50), sum(var_X_1, ..., var_X_50))\n\n")

cat("And since X_1, ... X_50 are all identically distributed:\n\n")

cat("\tmean_X_1 = mean_X_2 = ... = mean_X_50 = mean_X\n")
cat("\tvar_X_1 = var_X_2 = ... = var_X_50 = var_X\n")
cat("\t=> S ~ N(50*mean_X, 50*var_X) = N(")
cat(mean_S)
cat(",", var_S)
cat(")\n\n")

cat("Therefore:\n\n")

cat("\tE(S) = 50*mean_X =", mean_S, "\n")
cat("\tVar(S) = 50*Var(X) =", var_S, "\n")
cat("\tsd(S) = sqrt(Var(S)) =", sqrt(var_S), "\n\n")

cat("From the slides, we see that for the sample mean X_bar = 1/n*sum_from_i=1_to_n(X_i) ")
cat("and E(X_1) = mu, Var(X_1) = sigma^2 (if all X_i i.i.d.):\n\n")

cat("\tE(X_bar) = E(X_1) = mu =", mean_X_bar, "\n")
cat("\tVar(X_bar) = Var(X_1)/n = (sigma^2)/n =", var_X_bar, "\n")
cat("\tsd(X_bar) = sqrt(Var(X_bar)) =", sqrt(var_X_bar))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("See generated plots for the solution")
useCustomBins <- FALSE
customBinCount <- 20

for(sampleSize in c(50, 500)) {
  # Get random samples from the density
  x <- rnorm(sampleSize, mean_X, sqrt(var_X))
  
  if(useCustomBins) {
    hist_data <- hist(x, freq=TRUE, las = 1, breaks = customBinCount, main = paste("Histogram of", sampleSize, "random samples from N(5, 4)"))
  } else {
    hist_data <- hist(x, freq=TRUE, las = 1, main = paste("Histogram of", sampleSize, "random samples from N(5, 4)"))
  }
  
  # Multiplicator for curve fitting
  mult <- (max(hist_data$counts) / dnorm(mean_X, mean_X, sqrt(var_X)))
  
  x2 <- seq(-5, 5, length = 1000) * sqrt(var_X) + mean_X
  density_function <- (dnorm(x2, mean_X, sqrt(var_X))) * mult
  #density_from_data <- density(x)$y * mult
  
  # Sequence for curve-fitting x-coordinates
  #x_seq <- seq(1, 1000, b = 1000/512)
  
  # Normalize x_seq to histogram space
  #x_seq <- x_seq * (max(x2) / max(x_seq))
  
  lines(x2, density_function, col = "red")
  #lines(x_seq, density_from_data, col = "blue")
  
  grid(nx = NA, ny = NULL, col = "grey", lty = 3)
}

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE