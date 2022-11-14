# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 100000

source("globalFunctionRepository.R")
source("problem 1b.R")

file_header(1, 3)
cat("The problem: Basketball free throws\n")
cat("Two professional basketball players, Tom and John, each throw ten free throws with a ")
cat("basketball. Tom makes 80% of the free throws he tries, while John makes 85% of the free ")
cat("throws he tries. Player who achives the highest score wins the game. It is assumed that the ")
cat("two players do not influence each other when throwing. What is the probability that Tom ")
cat("will win the game?\n")
cat("Hint: R-function dbinom() can be used in computions.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("The probability is pretty easy to calculate. Tom wins the game if he has at least ")
cat("one more successes than John. We can calculate the probability for Tom to win ")
cat("as following:\n\n")
cat("\tFor each possible number n of successes Tom can achieve (1-10):\n")
cat("\t  - Get the probability tom_p with which Tom achieves exactly n successes\n")
cat("\t  - Get the sum of all probabilities john_p with which John achieves exactly 0 to n-1 successes\n")
cat("\t  - Calculate tom_wins_n (the probability that Tom wins with exactly n successes) as tom_p * john_p\n")
cat("\t  - Sum up tom_wins_n for n = 1 to 10 - this is the general probability that Tom wins the game\n\n")
cat("We use R and the dbinom()-function now to calculate those probabilities:\n\n")

sum <- 0

for(i in 0:9) {
  temp <- (dbinom(i + 1, 10, 0.8) * sum(dbinom(0:i, 10, 0.85)))
  cat("Tom wins with", i + 1, "successes probability:", temp, "\n")
  sum <- sum + temp
}

cat("Total probability for Tom to win the game:", sum)


cat("\n\n", string_divider, "\n\n")
cat("Lets verify this result with simulations:\n\n")

do_game(sim_iterations)

cat("\n\nEND OF SOLUTION FILE")

# END OF FILE