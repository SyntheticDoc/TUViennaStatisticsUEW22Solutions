# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
k <- 2
lambda <- 1

source("globalFunctionRepository.R")
source("problem 5b.R")

file_header(5, 4)
cat("The problem: Generating random numbers from a Weibull distribution\n")
cat("The cumulative distribution function of a random variable X ~ Weibull(k, lambda) is given by\n\n")
cat("\tF_X(x) = 1 - e^(-(x/lambda)^k)\t\tif x >= 0\n")
cat("\tF_X(x) = 0\t\t\t\tif x < 0\n\n")
cat("where k > 0 is the shape parameter and lambda > 0 is the scale parameter of the distribution.\n\n")
cat("Example (4) shows that if U ~ U(0, 1), then X = F^(-1)(u) generates a random number X from ")
cat("any continuous distribution with the specified cdf F. This gives us the following algorithm ")
cat("to generate random numbers from a random variable X with the given cdf F.\n\n")
cat("ALGORITHM: INVERSION METHOD\n")
cat("\t1) compute the inverse F^(-1) of F\n")
cat("\t2) generate n independent random numbers u_1, u_2, ..., u_n from U(0, 1)\n")
cat("\t3) compute x_1 = F^(-1)(u_1), x_2 = ^(-1)(u_2), ..., x_n = F^(-1)(u_n).\n\n")
cat("Then, x_1, x_2, ..., x_n are independent random observations of the random variable X.\n\n")
cat("In R, generate 30 observations from a random variable X with the Weibull(2, 1) by applying ")
cat("the inversion method.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("We start the inversion algorithm with the first step - calculating F^(-1) for the ")
cat("Weibull distribution:\n\n")

cat("\tF_X(x) = 1 - e^(-(x/lambda)^k) => y = 1 - e^(-(x/lambda)^k)\n")
cat("\t=> e^(-(x/lambda)^k) = 1 - y => (x/lambda)^k = -ln(1 - y)\n")
cat("\t=> x/lambda = (-ln(1 - y))^(1/k) => x = lambda * (-ln(1 - y))^(1/k)\n\n")

cat("With this, the full function F^(-1) finally is:\n\n")

cat("\tF_X^-1(x) = lambda * (-ln(1 - x))^(1/k)\t\tif 0 <= x <= 1\n")
cat("\tF_X^-1(x) = 0\t\t\t\t\tif x < 0\n\n")

cat("Steps 2 and 3 of the algorithm are implemented in \"problem 5b.R\". If we ")
cat("execute the algorithm, it gets 30 random draws u_1 to u_30 of the U(0, 1)-distribution and ")
cat("then uses the inverse of the Weibull(k, lambda)-cdf to map all u_n to random ")
cat("observations x_1 to x_30 of the Weibull-distribution.\n")
cat("In the following table, the column u_n represents the random observations from U(0, 1), ")
cat("the column x_n represents the corresponding random observations from Weibull(k, lambda) ")
cat("and the column F_X(x_n) finally represents the results of the cdf of Weibull(k, lambda) for the ")
cat("corresponding x_n-values. The last column verifies the correctness of ")
cat("the algorithm by checking if u_n and F_X(x_n) are both equal down to a tolerance of ")
cat("1/1000000 (since floating point numbers can't always be exactly matched in computer ")
cat("programs), denoted here by the symbol \"~=\", which means \"about equal\" in our context. ")
cat("It should yield TRUE in all cases, if the algorithm works as intended.\n\n")

get_random_X_table(k, lambda, 30)

cat("\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE