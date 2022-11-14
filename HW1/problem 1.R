# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

totalPokerHands <- choose(52, 5)
c13_1 <- choose(13, 1)
c4_3 <- choose(4, 3)
c12_1 <- choose(12, 1)
c4_2 <- choose(4, 2)
fullHouseTotal <- c13_1 * c4_3 * c12_1 * c4_2
fullHouseProbability <- fullHouseTotal / totalPokerHands
royalFlushTotal <- 4
royalFlushProbability <- royalFlushTotal / totalPokerHands

file_header(1, 1)
cat("The problem: Poker game\n")
cat("A deck of 52 cards has 13 ranks (2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A) and 4 suits ")
cat("(hearts, diamonds, clubs, spades). ")
cat("A poker hand is a set of 5 cards randomly chosen from a deck of 52 cards.\n\n")
cat("PRELIMINARIES:\n")
cat("Since there are 52 cards in a poker game, there are (52 choose 5) =", totalPokerHands, "hands with 5 cards in total.")
cat("\n\n")

# START OF PROBLEM A SOLUTION

cat("PROBLEM A)\n")
cat("A full house in poker is a hand where three cards share one rank and two cards share ")
cat("another rank. How many ways are there to get a full-house? What is the probability of ")
cat("getting a full-house?\n\n")
cat("ANSWER\n")
cat("We need 3 cards of arbitrary suits from the same rank, and then another 2 cards ")
cat("of arbitrary suits from another rank, which must be DISTINCT from the rank of ")
cat("first three cards.\n")
cat("So lets get our triple first: We need exactly one rank of all 13 available ranks, ")
cat("which is (13 choose 1). This gives us three cards of the same rank. Now we have to ")
cat("to choose 3 arbitrary suits out of 4, which is (4 choose 3). Therefore, we now have:\n\n")
cat("\t(13 choose 1) * (4 choose 3)\n\n")
cat("We now need only two more cards of a rank not equal to the rank of our triple. ")
cat("Because of this, we only have 12 ranks left to choose from: (12 choose 1). ")
cat("Now we need only 2 arbitrary suits out of 4, which is (4 choose 2). For those two ")
cat("cards we therefore get:\n\n")
cat("\t(12 choose 1) * (4 choose 2)\n\n")
cat("To get the total number of hands to satisfy those conditions, we only have to multiply ")
cat("our calculations for three and for two cards. Our complete formula for a full house ")
cat("now is:\n\n")
cat("\t(13 choose 1) * (4 choose 3) * (12 choose 1) * (4 choose 2)\n\n")
cat("which results in", fullHouseTotal, "combinations of cards that make up a full house.\n\n")
cat("To calculate the probability for a full house, we now only have to divide the number ")
cat("of full house hands by the total number of hands with 5 cards, which yields: \n\n")
cat("\t", fullHouseTotal, "/", totalPokerHands, "=", fullHouseProbability, "\n\n")
cat("which is a probability of", sprintf("%1.5f%%", 100*fullHouseProbability), "\n\n")
cat("This concludes Problem A.\n\n")

# END OF PROBLEM A SOLUTION
#
# START OF PROBLEM B SOLUTION

cat("PROBLEM B)\n")
cat("A royal flush in poker is a hand with ten, jack, queen, king, ace in a single suit. ")
cat("What is the probability of getting a royal flush?\n\n")
cat("ANSWER\n")
cat("This one is straightforward. The ranks are already set, so we only have to worry about ")
cat("suits. All cards need to have the same suit, so since we have 4 suits, there are ")
cat("just four combinations of exactly those ranks with all five having the same suit. ")
cat("To get the probability for drawing a royal flush, we thus only have to divide the number ")
cat("of hands which are a royal flush by the total number of possible hands :\n\n")
cat("\t", royalFlushTotal, "/", totalPokerHands, "=", royalFlushProbability, "\n\n")
cat("which is a probability of", sprintf("%1.5f%%", 100*royalFlushProbability), "\n\n")
cat("This concludes Problem B.\n\n")
cat("END OF SOLUTION FILE")

# END OF PROBLEM B SOLUTION
# END OF FILE