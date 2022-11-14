# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

# Import ball game, call do_game(iterations) to start the game with iterations runs
source("problem 4b.R")

file_header(1, 1)
cat("The problem: Urn problem\n")
cat("There are 8 red and 2 black balls in an urn. John takes n balls at once. ")
cat("What is the minimal number of balls that he should take so the probability ")
cat("that there is at least one black ball among those that he took, is greater ")
cat("than 2/3?\n\n")
cat("SOLUTION\n")
cat("Lets first look at red balls. If John takes just one ball, how big is the ")
cat("probability that all balls taken are red? The answer is obviously:\n\n")
cat("\tP(n = 1, all balls red) = 8/10\n\n")
cat("What if he takes two balls? The chance for the first ball remains at 2/10, ")
cat("for the second ball, there are 9 balls left with 7 of them red, hence:\n\n")
cat("\tP(n = 2, all balls red) = 8/10 * 7/9\n\n")
cat("For three balls:\n\n")
cat("\tP(n = 3, all balls red) = 8/10 * 7/9 * 6/8\n\n")
cat("And so on ... The complete formula is:\n\n")
cat("\tMultiply with each from k = 1 to n: (9 - k)/(11 - k)\n\n")
cat("But we want to know how big the probability for getting at least ")
cat("one black ball is. But if not ALL balls we got are red, we MUST have at least ")
cat("one black ball already! So we can calculate the probability for at least one ")
cat("black ball as:\n\n")
cat("\tP(n = ?, at least one ball black) = 1 - P(n = ?, all balls red)\n\n")
cat("We can now simply calculate this probability for all n and will arrive at ")
cat("the conclusion that the probability is exactly 2/3 for n = 4, so John has ")
cat("to take at least n = 5 balls if the probability for at least one black ball ")
cat("shall exceed 2/3.\n\n")
cat("To add substance to our claims, lets run a simulation of our game, calculate ")
cat("the probabilities according to our formula above and compare them to the ")
cat("simulation results:\n\n")

do_game(10000)

cat("\n\n")
cat("END OF SOLUTION FILE")

# END OF SOLUTION
# END OF FILE