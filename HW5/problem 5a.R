# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("problem 5b.R")

file_header(5, 5)
cat("The problem: Histograms of averages of exp(1)\n\n")
cat("a) Generate a frequency histogram of 1000 samples from an exp(1) random variables.\n\n")
cat("b) Generate a density histogram for the average of 2 independent exp(1) random variables.\n\n")
cat("c) Using rexp(), matrix() and colMeans() generate a density histogram for the average ")
cat("of 50 independent exp(1) random variables. Make 10000 sample averages and use a ")
cat("binwidth of 0.1 for this. Look at the spread of the histogram.\n\n")
cat("d) Add a graph of the pdf of N(1, 1/50) on your plot in problem (c).")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("See generated plot for the solution")
# Get random samples from the exp(1) distribution
x <- rexp(1000, rate = 1)

h <- hist(x, freq=TRUE, las = 1, main = paste("Histogram of 1000 random samples from exp(1)"))

grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("There are three ways to calculate the necessary histograms. The first one is to ")
cat("just sample the random variables and draw a histogram from the sampled data.\n\n")

sampleSize <- 10000
mean_exp_1 <- 1
var_exp_1 <- 1/2
sd_exp_1 <- sqrt(var_exp_1)
ylimit = c(0, 1)

dat <- (rexp(sampleSize, 1) + rexp(sampleSize, 1)) / 2
w = 0.05
b = seq(min(dat), max(dat)+w, w)
h_title1 <- paste("Averages of", sampleSize, "random samples from two exp(1) variables")
hist(dat, breaks=b, main = h_title1, freq=FALSE, ylim = ylimit)
attach_density_curve_to_histo(min(dat), max(dat)+w, 0.01, dat, "Density plot of samples", TRUE)
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("According to the central limit theorem, for large n the following holds for i.i.d. ")
cat("random variables:\n\n")

cat("\tE(X_bar) = mu = E(exp(1)) = 1/lambda = 1\n")
cat("\tVar(X_bar) = (sigma^2)/n = Var(exp(1))/n = 1/n = 1/2\n\n")

cat("In this case, we have E(X_bar) = 1 and Var(X_bar) = 1/2. We can now draw random samples ")
cat("from this approximation, which is an approximation of the average of the ")
cat("two exp(1) variables.\n\n")

dat2 <- get_positive_rnorm(sampleSize, mean_exp_1, sd_exp_1, min(dat), max(dat))
w2= 0.05
b2 = seq(min(dat), max(dat)+w2, w2)
h_title2 <- paste(sampleSize, "random samples from an N(", mean_exp_1, ",", sd_exp_1^2, ") approximation of X_bar")
hist(dat2, breaks=b2, main = h_title2, freq=FALSE, ylim = ylimit)
attach_curves_to_histo(min(dat), max(dat)+w2, 0.01, dat2, mean_exp_1, sd_exp_1, TRUE, TRUE, FALSE)
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("Since the central limit theorem holds only for large n, and n = 2 certainly isn't ")
cat("large, we will get a much more accurate result if we calculate the average of ")
cat("our two exp(1) variables with a Gamma distribution, since the addition rules for ")
cat("exponential random variables are:\n\n")

cat("\tIf X_1, ..., X_k (k as natural number) are independent random variables and\n")
cat("\tS = X_1 + ... + X_k, then: If X_i ~ exp(lambda) then S ~ Gamma(k, lambda)\n\n")

cat("We calculate the Gamma distribution as following:\n\n")

cat("Let X_1 ~ exp(1), X_2 ~ exp(1). Since in this case k = 2, we have:\n")
cat("\tS = X_1 + X_2 => S ~ Gamma(2, 1)\n\n")

cat("But since we are not interested in the mere sum S, we have to calculate X_bar instead. ")
cat("For X_bar with n variables, the corresponding Gamma distribution is given by ")
cat("Gamma(n, n*lambda), and therefore we calculate:\n\n") 
# https://math.stackexchange.com/questions/1998285/find-the-distribution-of-the-average-of-exponential-random-variables")

cat("The pdf of a Gamma(k, lambda) random variable is given by:\n\n")

cat("\tf(x) = (lambda^k)/G(k) * x^(k-1) * e^(-(lambda * x))\tif x > 0\n")
cat("\t[With the Euler gamma function G(k) = integral_from_0_to_inf_of(x^(k - 1) * e^(-x) dx)]\n\n")

cat("We can skip calculating the Euler gamma function with a little trick:\n\n")

cat("\tFor all positive integers n: G(n) = (n - 1)!\n")
cat("\tIn this case n = k = 2, therefore: G(2) = 1\n\n")

cat("With this, the pdf of our Gamma(2, 2) random variable is reduced to:\n\n")

cat("\tf(x) = (lambda^2) * x^(2-1) * e^(-(2 * x))\tif x > 0\n")
cat("\tf(x) = 4 * x * e^(-(2 * x)\t\t\tif x > 0\n\n")

cat("The fact that the Gamma distribution is only defined for x > 0 in our definition ")
cat("from the slides (there are other definitions) doesn't disturb us here, since ")
cat("exp(lambda) = 0 for all x < 0 anyway.\n\n")

cat("We can now use the inverse cumulative distribution function of Gamma as provided ")
cat("by R to get random draws from Gamma(2, 2) and generate a third histogram from those.\n\n")

dat3 <- get_random_Gamma(sampleSize, min(dat), max(dat))
w3= 0.05
b3 = seq(min(dat3), max(dat3)+w3, w3)
h_title3 <- paste(sampleSize, "random samples from an Gamma(2, 2) distribution")
hist(dat3, breaks=b3, main = h_title3, freq=FALSE, ylim = ylimit)
attach_curves_to_histo(min(dat3), max(dat3)+w3, 0.01, dat3, 0, 0, TRUE, FALSE, TRUE)
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("To compare our results from random drawing from (exp(1) + exp(1))/2 with the ")
cat("result from the Gamma distribution, we generate a fourth histogram with the same data ")
cat("as the first and draw the Gamma distribution density on top of it.")

hist(dat, breaks=b, main = h_title1, freq=FALSE, ylim = ylimit)
attach_curves_to_histo(min(dat), max(dat)+w, 0.01, dat, mean_exp_1, sd_exp_1, TRUE, TRUE, TRUE)
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("See the following code for the solution. We see immediately, that the histogram ")
cat("looks approximately normally distributed, as we have expected from the central ")
cat("limit theorem.")
# We start by creating a matrix of size 50xsampleSize
sampleSize = 10000
rexp_matrix <- matrix(rexp(50 * sampleSize, 1), nrow = 50, ncol = sampleSize)

# Now we can calculate the colMeans of the matrix columns
rexp_matrix_means <- colMeans(rexp_matrix)

# Calculate minimum and maximum from means to generate histogram bars with binwidth = 0.1
# without losing any data
colMeans_min <- min(rexp_matrix_means)
colMeans_max <- max(rexp_matrix_means)
break_seq <- seq(colMeans_min, colMeans_max + 0.1, by = 0.1)

# Then we calculate the height for the histogram with exercise d) in mind to fit
# both the histogram data from this example and the curve from d) completely inside
# the plot
# First, extract the histogram data
hist_data <- hist(rexp_matrix_means, breaks = break_seq, plot = FALSE)

# Get max density value
hist_density_max <- max(hist_data$density)

# Get max height of dnorm from exercise d)
norm_center <- qnorm(0.5, 1, sqrt(1/50))
norm_height_max <- dnorm(norm_center, 1, sqrt(1/50))

# Set max y-height of histogram plot to the maximum of both values
y_max <- max(hist_density_max, norm_height_max)

# From this data, we can now generate a histogram
hist_title <- paste("Histogram of", sampleSize, "averages of 50 exp(1) random variables")
hist(rexp_matrix_means, freq = FALSE, las = 1, xlab = "Average", ylim = c(0, y_max), main = hist_title, breaks = break_seq)

grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("As the histogram from c) is still in memory, we can easily add a graph of the ")
cat("pdf of N(1, 1/50) to the histogram. See code for the solution.")

curve(dnorm(x, 1, sqrt(1/50)), from = colMeans_min, to = colMeans_max, col = "red", add = TRUE)
legend("topright", legend = "pdf of N(1, 1/50)", col = "red", lty = 1)

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\nEND OF SOLUTION FILE")
# END OF FILE