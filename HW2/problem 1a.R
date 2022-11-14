# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 100000

source("globalFunctionRepository.R")
source("problem 1b.R")

file_header(1, 2)
cat("The problem: Fair six sided die\n")
cat("A fair six sided die is rolled repeatedly until the sum of all obtained numbers is greater ")
cat("than 6. Let X be the number of times the die was rolled and let F be the cumulative distribution ")
cat("function for X. Compute F(1), F(2) and F(3).")
cat("\n\n", string_divider, "\n\n")
cat("SOLUTION\n")
cat("First, we need to calculate the probability mass function P(dr) = P(X = dr), ")
cat("where dr denotes the number of consecutive dice rolls and P(a) the probability ")
cat("with which the sum of the results of dr dice rolls are greater than 6. We let ")
cat("the computer enumerate all valid combinations:\n\n")

for(i in 1:3) {
  get_combinations_greater_six(i)
}

cat("\nThus:\n")
cat("\tP(1) = 0\t[Its not possible to get a result greater than 6 with a single die roll]\n")
cat("\tP(2) = (1 + 2 + 3 + 4 + 5 + 6) / 36 = 21/36 =", 21/36, "\n")
cat("\tP(3) = 70 / 216 =", 70/216,"\n\n")
cat("Deriving the cumulative distribution function and calculating F(1), F(2) and ")
cat("F(3) are very easy now:\n\n")
cat("\tF(1) = P(1) = 0\n")
cat("\tF(2) = P(1) + P(2) = 0 + 21/36 =", 21/36,"\n")
cat("\tF(3) = P(1) + P(2) + P(3) = 0 + 21/36 + 70/216 =", 21/36 + 70/216,"\n\n")
cat(string_divider, "\n\n")
cat("Lets verify this result with simulations:\n\n")

for(i in 1:3) {
  roll_die(i, sim_iterations)
}

cat("END OF SOLUTION FILE")

# END OF FILE