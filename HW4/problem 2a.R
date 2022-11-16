# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

# The following variable controls the number of runs done in simulations. If simulations
# take too long on your machine, reduce this variable accordingly (at the expense of
# simulation accuracy)
sim_iterations <- 100000

# Mean and sd values from the problem statement for corresponding normal distributions
mean_coffee <- 320
sd_coffee <- 20
mean_donut <- 150
sd_donut <- 12

source("globalFunctionRepository.R")
source("problem 2b.R")

file_header(2, 4)
cat("The problem: Coffee and doughnuts\n")
cat("At a certain coffee shop, all the customers can buy a cup of coffee and also a doughnut. The ")
cat("shop owner believes that the number of cups she sells each day is normally distributed with ")
cat("an expectation of 320 cups and a standard deviation of 20 cups. She also believes that the ")
cat("number of doughnuts she sells each day is independent of the coffee sales and is normally ")
cat("distributed with an expectation of 150 doughnuts and a standard deviation of 12.\n\n")

cat("\t(a) The shop is open every day but Sunday. Assuming day-to-day sales are independent, ")
cat("what is the probability she will sell more than 1900 cups of coffee in a week?\n\n")
cat("\t(b) If she makes a profit of 1.2 euro on each cup of coffee and 0.7 euro on each doughnut, ")
cat("can she reasonably expect to have a day’s profit over 550 euro? Justify your answer.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("The normal distributions for coffee and donuts are N(320, 20^2) and N(150, 12^2), ")
cat("respectively. Since it is stated that day-to-day sales are assumed to be independent, ")
cat("we are justified in using the addition rules for normal distributions from the slides, ")
cat("which are:\n\n")

cat("\tLet X_1, ..., X_k (with k as natural number) be independent random variables\n")
cat("\tLet S = X_1 + ... + X_k\n")
cat("\tThen: If X_i ~ N(mean_i, sd_i^2) then S ~ N(mean_1 + ... + mean_k, sd_1^2 + ... + sd_k^2)\n\n")

cat("Using this rule, we calculate the total distribution for coffees for a 6-day week as:\n\n")
cat("\tS ~ N(6*mean_coffee, 6*(sd_coffee^2))\n\n")

cat("We can now easily plug this values into R and get the following result:\n\n")
cat("\tpnorm(1900, 6*mean_coffee, sqrt(6*sd_coffee^2), lower.tail=FALSE) =", pnorm(1900, 6*mean_coffee, sqrt(6*sd_coffee^2), lower.tail=FALSE), "\n\n")

cat("Lets validate our result with some simulations:\n")
simulate_shop_week(mean_coffee, sd_coffee, 1900, sim_iterations)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("We already know the normal distributions for coffees and donuts for daily sales. ")
cat("As each unit of coffee or donut has a constant price tag, the distributions of ")
cat("profits for each item can easily be derived from the item distributions themselves:\n\n")

cat("\tNormal distribution for daily coffee sales: N(320, 20^2)\n")
cat("\tNormal distribution for daily coffee profit: N(320*1.2, (20*1.2)^2)\n")
cat("\tNormal distribution for daily donut sales: N(150, 12^2)\n")
cat("\tNormal distribution for daily donut profit: N(150*0.7, (12*0.7)^2)\n\n")

cat("Since coffee and donut sales are independent from each other, profits from both ")
cat("must also be independent from each other. Therefore, we are again justified to ")
cat("use the addition rule for profit distributions:\n\n")

mean_total_profit <- 320*1.2 + 150*0.7
var_total_profit <- (20*1.2)^2 + (12*0.7)^2
sd_total_profit <- sqrt(var_total_profit)

cat("\tNormal distribution for daily total profit: N(320*1.2 + 150*0.7, (20*1.2)^2 + (12*0.7)^2) = ")
cat("N(", mean_total_profit, ",", var_total_profit, ")\n\n")

cat("From this distribution, we can now easily calculate the probability to get a total ")
cat("daily profit of more than 550 euro:\n\n")
cat("pnorm(550,", mean_total_profit, ",", sd_total_profit, ", lower.tail=FALSE):", pnorm(550, mean_total_profit, sd_total_profit, lower.tail = FALSE), "\n\n")

cat("Lets validate our result with some simulations:\n")
simulate_shop_day_profit(mean_coffee, sd_coffee, mean_donut, sd_donut, 1.2, 0.7, 550, sim_iterations)

cat("\n\nFinal thoughts: Usually, it is pretty difficult to say what can be \"reasonably expected\", ")
cat("since it is pretty difficult to find a useful definition for \"reasonable expectation\" ")
cat("most people would agree with. But in this special case, most people probably ")
cat("would indeed agree that a probability of around 0.8% is so low that it should not ")
cat("be expected as probable for a single day.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE