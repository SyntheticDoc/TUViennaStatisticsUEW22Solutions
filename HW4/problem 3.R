# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(3, 4)
cat("The problem: Mail order company\n")
cat("A mail order company provides free examination of its products for 7 days. If not completely ")
cat("satisfied, a customer can return the product within that period and get a full refund. ")
cat("According to past records of the company, an average of 2 of every 10 products sold by this ")
cat("company are returned for a refund.\n\n")
cat("\t(a) Compute the probability that no more than 6 of the 40 products sold by this company ")
cat("on a given day will be returned for a refund.\n\n")
cat("\t(b) Use a Poisson distribution to approximate the probability in (a). What can be said ")
cat("about the accuracy of this approximation?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Since \"products returned\" obviously is a discrete random variable and we are only ")
cat("interested in a binary state (returned/not returned), we can model the probabilities ")
cat("in this matter with a binomial distribution. We already know that E(X) for n = 10 for this ")
cat("distribution equals 2, and since E(X) = n*p for the binomial distribution, we ")
cat("derive p = 2/10 = 0.2. The probability for no more than 6 products of 40 returned ")
cat("can now be retrieved from the binomial distribution model:\n\n")

cat("\tpbinom(6, 40, 0.2) =", pbinom(6, 40, 0.2))

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Lets model the same product returns as in a) with a Poisson distribution. ")
cat("If the sample size is large enough and the probability low enough, we can ")
cat("approximate a Binomial distribution X ~ B(n, p) with an Poisson distribution ")
cat("Y ~ P(np). Since n = 40 and p = 0.2, we have np = lambda = 40*0.2 = 8. Therefore:\n\n")

cat("\tppois(6, 8):", ppois(6, 8))

cat("\n\nThe result is close to the result from B(n, p), but there is still a difference ")
cat("visible. The rule of thumb given in the slides suggests n >= 50, p <= 1/10 and ")
cat("np <= 10. Since here n = 40, p = 2/10 and np = 8, we are just short of fulfilling ")
cat("this rule. We can add substance to this claim by rerunning the approximation with ")
cat("numbers more suited to the rule of thumb:\n\n")

cat("Let on average 2 of 1000 products be returned, what is the probability of ")
cat("no more than 6 of 4000 products being returned? Lets calculate:\n\n")

cat("\tpbinom(6, 4000, 0.002):", pbinom(6, 4000, 0.002), "\n")
cat("\tppois(6, 4000*0.002):", ppois(6, 4000*0.002), "\n\n")

cat("We see that the results fit much better if the rule of thumb is satisfied.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE