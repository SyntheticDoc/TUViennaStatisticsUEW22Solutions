# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
lambda <- 27/22

source("globalFunctionRepository.R")

file_header(2, 3)
cat("The problem: Hurricane insurance\n")
cat("An insurance company needs to assess the risk associated with providing hurricane ")
cat("insurance. During 22 years from 1990 through 2011, Florida was hit by 27 major ")
cat("hurricanes (level 3 and above). The insurance company assumed Poisson distribution ")
cat("for modeling number of hurricanes.\n\n")
cat("\t(a) If hurricanes are independent and the mean has not changed, what is the probability ")
cat("of having a year in Florida with each of the following?\n")
cat("\t  (1) No hits.\n")
cat("\t  (2) Exactly one hit.\n")
cat("\t  (3) More than two hits.\n\n")
cat("\t(b) Use R to estimate the number of hurricane hits that will occur with the ")
cat("probability 97.5%.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
# Expectation and Variance for Poisson distribution: t^x/x! * e^(-t)
# E(X) = lambda, Var(X) = lambda
# lambda = mean event rate
cat("SOLUTION FOR a)\n")
cat("The probability mass function for the Poisson distribution is given as:\n\n")
cat("\tp(x) = P(X = x) = (lambda^x / x!) * e^-lambda\n")
cat("\t(with lambda as intensity parameter, for x in {0, 1, 2, ...} and x as times ")
cat("an event occurs in an interval)\n\n")
cat("Since the parameter lambda of the Poisson distribution is the mean event rate ")
cat("empirically observed, we can set lambda at 27/22 =", lambda, "\n")
cat("Now we can easily calculate all wanted probabilities:\n\n")
cat("\t(1) No hits.\n")
cat("\t    P(X = 0) =", dpois(0, lambda), "\n\n")
cat("\t(2) Exactly one hit.\n")
cat("\t    P(X = 1) =", dpois(1, lambda), "\n\n")
cat("\t(3) More than two hits.\n")
cat("\t    P(X > 2) =", 1 - sum(dpois(0:2, lambda)), "\n\n")


cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("To calculate how many hurrican hits are to be expected in a certain year with ")
cat("a probability of at least 97.5%, we just sum up the probabilities for all X = x ")
cat("with x from 0 to possibly infinity until the sum is larger than 0.975:\n\n")

sum <- 0

for(i in 0:10) {
  sum <- sum + dpois(i, lambda)
  cat("sum(", i, "):", sum, "\n")
  
  if(sum > 0.975) {
    cat("Calculated max i:", i)
    break
  }
}

cat("\n\nThis means that we can expect 0-4 hurrican hits in a certain year with at least ")
cat("97.5% probability (to be exact, the probability for 0-4 hits is", sum, ". We ")
cat("can arrive at the same conclusion by using qpois() in R:\n")
cat("\tqpois(0.975, lambda):", qpois(0.975, lambda))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE