# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

box1_white <- 15
box1_black <- 12
box1_total <- box1_white + box1_black

box1_ww_prob <- (box1_white/box1_total) * ((box1_white - 1)/(box1_total - 1))
box1_wb_prob <- (box1_white/box1_total) * ((box1_black)/(box1_total - 1))
box1_bw_prob <- (box1_black/box1_total) * ((box1_white)/(box1_total - 1))
box1_bb_prob <- (box1_black/box1_total) * ((box1_black - 1)/(box1_total - 1))

p_w_ww <- (16/34) * box1_ww_prob
p_w_wb <- ((15/34) * box1_wb_prob) + ((15/34) * box1_wb_prob)
p_w_bb <- (14/34) * box1_bb_prob
p_w_total <- p_w_ww + p_w_wb + p_w_bb
p_wb_or_bw_from_box1 <- box1_wb_prob + box1_bw_prob
p_b_total <- 1 - p_w_total
p_b_given_a <- (19/34)

# Import box simulation
source("problem 5b.R")

file_header(1, 1)
cat("The problem: Boxes\n")
cat("Two boxes are given. There are 15 white and 12 black balls in the first box, ")
cat("and 14 white and 18 black balls in the second box. Anna provides the following ")
cat("experiment. Anna takes at once two balls from the first box and places them ")
cat("in the second box. Then, she takes one ball without looking from the second box.\n\n")
cat("Problem a)\n")
cat("What is the probability that she took a white ball from the second box?\n\n")
cat("SOLUTION\n")
cat("Lets try an easy and straightforward way to calculate this. In the first step ")
cat("(drawing two balls from the first box), we can have four results for those ")
cat("two balls: ww, wb, bw and bb. The probabilities for those are obviously:\n\n")
cat("\tP(ww) = 15/27 * 14/26 =", box1_ww_prob, "\n")
cat("\tP(wb) = 15/27 * 12/26 =", box1_wb_prob, "\n")
cat("\tP(bw) = 12/27 * 15/26 =", box1_bw_prob, "\n")
cat("\tP(bb) = 12/27 * 11/26 =", box1_bb_prob, "\n\n")
cat("This means that if we run this first part of the exercise many, many times, ")
cat("the second box will look like this:\n\n")
cat("\t14w, 18b + 2w:", sprintf("%1.2f%%", 100*box1_ww_prob), "of all cases\n")
cat("\t14w, 18b + 1w1b:", sprintf("%1.2f%%", 100*(box1_wb_prob + box1_bw_prob)), "of all cases\n")
cat("\t14w, 18b + 2b:", sprintf("%1.2f%%", 100*box1_bb_prob), "of all cases\n\n")
cat("We can now easily calculate how probable it is to draw a single white ball from each ")
cat("of this cases:\n\n")
cat("\tP(1w from [16w18b]) = 16/34 =", (16/34), "\n")
cat("\tP(1w from [15w19b]) = 15/34 =", (15/34), "\n")
cat("\tP(1w from [14w20b]) = 14/34 =", (14/34), "\n\n")
cat("Now we have to multiply the probability for each possible configuration of ")
cat("box2 with the probability of getting a white ball from it:\n\n")
cat("\tP(1w given P(ww)) = 16/34 * P(ww) =", p_w_ww, "\n")
cat("\tP(1w given P(wb) or P(bw)) = (15/34 * P(wb)) + (15/34 * P(bw)) =", p_w_wb, "\n")
cat("\tP(1w given P(bb)) = 14/34 * P(bb) =", p_w_bb, "\n\n")
cat("And finally we just add up all three of those results to get the final chance ")
cat("to get a white ball in this problem:\n\n")
cat("P(1w total) = P(1w given P(ww)) + P(1w given P(wb) or P(bw)) + P(1w given P(bb)) = ")
cat(p_w_total, "\n\n")

cat("To check our result, we do a couple of simulation runs:\n\n")

do_game_problem1(1000000)

cat(string_divider, "\n\n")
cat("Problem b)\n")
cat("Knowing that she took a black ball from the second box, what is the probability ")
cat("that she transferred two balls of different colors from the first box to the ")
cat("second box?\n\n")
cat("SOLUTION\n")
cat("This problem finally is the chance for Bayes' theorem to shine! Bayes theorem states:\n\n")
cat("\tP(A|B) = (P(B|A)*P(A))/P(B)\n\n")
cat("In words: The probability of A given B already happened depends on the probabilities ")
cat("of both events themselves and the probability of B happening given A already ")
cat("happened. So if we already know P(B|A), P(A) and P(B), we can easily derive ")
cat("P(A|B). Now lets say:\n\n")
cat("\tP(A) = Chance for having taken wb or bw from the first box =", p_wb_or_bw_from_box1,"\n")
cat("\tP(B) = Chance for getting a black ball from the second box\n")
cat("\tP(A|B) = Chance for having taken wb or bw from the first box if we got a black one from the second box\n\n")
cat("Fortunately, we already calculated P(A) for the first exercise, and P(B) is simply ")
cat("the complementary probability for P(1w total) we calculated in the first exercise:\n\n")
cat("\tP(B) = 1 - P(1w total) =", 1 - p_w_total, "\n\n")
cat("For P(B|A), we can use our results above to get the chance of getting a black ball ")
cat("for cases in which we put wb or bw in our second box:\n")
cat("\tP(B|A) = P(1b from [15w19b]) = (19/34) =", p_b_given_a, "\n\n")
cat("Equipped with our a priori knowledge, we can now easily calculate P(A|B):\n\n")
cat("\tP(A|B) = (P(B|A)*P(A))/P(B) =", (p_b_given_a * p_wb_or_bw_from_box1) / p_b_total,"\n\n")
cat("\tP(A|B)/P(B) = (P(B|A)*P(A)) =", (p_b_given_a * p_wb_or_bw_from_box1),"\n\n")

cat("As always, lets check our result with simulations:\n\n")

do_game_problem2(1000000)

cat("END OF SOLUTION FILE")

# END OF PROBLEM B SOLUTION
# END OF FILE