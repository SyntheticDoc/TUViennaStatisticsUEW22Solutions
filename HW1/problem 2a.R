# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

probability_for_head <- 0.5

# Import coin toss game, call do_game() to execute game, new_head_prob(probability)
# to set the probability for the coin to toss to result in "head"
source("problem 2b.R")

file_header(2, 1)
cat("The problem: Coin game\n")
cat("Two players, A and B, alternately and independently flip a coin and the first player to obtain ")
cat("a head wins. Assume player A flips first. Suppose that P(head) = p, not necessarily 1/2 . What ")
cat("is the probability that the player B wins?\n\n")
cat("Hint: Different cases should be considered depending on (p element of [0, 1]).")
cat("\n\n")

# START OF PROBLEM A SOLUTION

cat("SOLUTION\n")
cat("Let us first construct a description for our sample space. When a coin is flipped, ")
cat("we have four possible outcomes:\n\n")
cat("\tA flips the coin and does not win (coin comes up tail). We denote this event with: a\n")
cat("\tA flips the coin and does win (coin comes up head). We denote this event with: A\n")
cat("\tB flips the coin and does not win (coin comes up tail). We denote this event with: b\n")
cat("\tB flips the coin and does win (coin comes up head). We denote this event with: B\n\n")
cat("Lets review some examples of our notation:\n\n")
cat("Example 1: The coin is tossed three times, after which A wins:\n")
cat("\tNotation: abA\n\n")
cat("Example 2: The coin is tossed six times, after which B wins:\n")
cat("\tNotation: ababaB\n\n")
cat("For fun and profit, lets do six random runs of this game:\n\n")

do_game()
cat("\n\n")
do_game()
cat("\n\n")
new_head_prob(0.3)
do_game()
cat("\n\n")
do_game()
cat("\n\n")
new_head_prob(0.1)
do_game()
cat("\n\n")
do_game()
cat("\n")

cat(string_divider)
cat("Now lets say that P(head) = p. Then the probability for A winning on his/her ")
cat("first flip is:\n")
cat("\tp(A) = p\n\n")
cat("Lets calculate the probability that A wins on the second iteration of the game (abA):\n")
cat("\tp(abA) = (1 - p) * (1 - p) * p = (1 - p)^2 * p\n\n")
cat("The probability for A winning on the third iteration of the game (ababA) is:\n")
cat("\tp(ababA) = (1 - p) * (1 - p) * (1 - p) * (1 - p) * p = (1 - p)^4 * p\n\n")
cat("We see that the probability for A winning the n-th iteration of the game is:\n")
cat("\tp(A wins on n-th iteration) = (1 - p)^((n * 2) - 2) * p\n")
cat(string_divider)
cat("We can now sum up all instances in which A wins to get the probability of A ")
cat("winning at any point in the game (see file problem 2c.jpg for full solution path). ")
cat("This ultimately results in the following formula for calculating if A wins the game:\n")
cat("\tp(A wins the game) = 1/(2-p)\n\n")
cat("We summed up to infinity, and in infinity, either A or B must win at some point. ")
cat("Thus, we can easily calculate the chance for B to win the game, which is:\n")
cat("\tp(B wins the game) = (1 - p(A wins the game)) = (1 - 1/(2-p))\n\n")
cat("Lets see if our calculations hold up to reality and do some simulation runs ")
cat("with varying probabilities and compare them to our calculated probability:\n\n")

iterations <- 100000
new_head_prob(0.9)
do_game_iter(iterations)
cat("\n\n")
new_head_prob(0.75)
do_game_iter(iterations)
cat("\n\n")
new_head_prob(0.5)
do_game_iter(iterations)
cat("\n\n")
new_head_prob(0.3)
do_game_iter(iterations)
cat("\n\n")
new_head_prob(0.1)
do_game_iter(iterations)
cat("\n\n")


cat("END OF SOLUTION FILE")

# END OF SOLUTION
# END OF FILE