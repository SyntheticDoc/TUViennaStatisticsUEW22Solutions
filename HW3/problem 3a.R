# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 10000000
mean_tires <- 32000
sd_tires <- 2500

source("globalFunctionRepository.R")
source("problem 3b.R")

file_header(3, 3)
cat("The problem: Tire company\n")
cat("A tire manufacturer believes that the tread life of its snow tires can be distributed ")
cat("by a Normal model with a mean of 32 000 miles and a standard deviation of 2 500 miles. ")
cat("Use the values of the cumulative distribution function Phi(z) = P(Z <= z) of the standard ")
cat("normal distribution Z given in Table 1 to answer the following questions.\n\n")
cat("\t(a) Approximately what fraction of these tires can be expected to last between ")
cat("30 000 and 35 000 miles?\n\n")
cat("\t(b) Calculate the interquartile range of this distribution.\n\t    Recall, the ")
cat("interquartile range is the difference between the upper x_0.75 and the lower quartile ")
cat("x_0.25, i.e., IQR = x_0.75 - x_0.25.\n\n")
cat("\t(c) In a marketing strategy, a local tire dealer wants to offer a refund to ")
cat("any customer whose tires fail to last a certain number of miles. However, the ")
cat("dealer does not want to take too big risk. If the dealer is willing to give ")
cat("refunds to no more than one of every 15 customers, for what milage can he guarantee ")
cat("these tires to last?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("To use the supplied table to calculate the corresponding probabilities, we have to ")
cat("standardize our numbers to a N(0, 1)-distribution, then get the corresponding table ")
cat("entries for our minimum and maximum life expectancy for the tires and subtract ")
cat("the probability for the maximum life expectancy from that for the minimum life expectancy:\n\n")

# Variable section
Z_30000 <- (30000 - 32000) / 2500
Z_35000 <- (35000 - 32000) / 2500
phi_table_Z_30000 <- get_phi_from_table(Z_30000, 0)
phi_table_Z_35000 <- get_phi_from_table(Z_35000, 0)

cat("\tp(Z <= (30000 - 32000) / 2500 =", Z_30000, "):", phi_table_Z_30000, "\n")
cat("\tp(Z <= (35000 - 32000) / 2500 =", Z_35000, "):", phi_table_Z_35000, "\n")
cat("\tp(30000 <= Z <= 35000) = ", phi_table_Z_35000 - phi_table_Z_30000, "\n\n")

cat("A cleaner way to do this in R:\n")
cat("We calculate the probability for tires to approximately last up to 35000 miles and ")
cat("subtract from this result the probability for tires to last up to 30000 miles:\n\n")
cat("\tpnorm(30000):", pnorm(30000, mean = mean_tires, sd = sd_tires),"\n")
cat("\tpnorm(35000):", pnorm(35000, mean = mean_tires, sd = sd_tires),"\n")
cat("\tresult:", pnorm(35000, mean = mean_tires, sd = sd_tires) - pnorm(30000, mean = mean_tires, sd = sd_tires),"\n\n")
cat("We can verify this result by randomly drawing lots of tires from the normal distribution ")
cat("and counting how many tires are in the specified interval:\n\n")
get_interval_probability(sim_iterations, mean_tires, sd_tires, 30000, 35000)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("By extracting the corresponding values from the supplied table, we get:\n\n")

inverse_phi_0_25 <- get_inverse_phi_from_table(0.25)
inverse_phi_0_75 <- get_inverse_phi_from_table(0.75)
sd_to_0_25 <- sd_tires * inverse_phi_0_25
sd_to_0_75 <- sd_tires * inverse_phi_0_75
tires_at_0_25 <- mean_tires + sd_to_0_25
tires_at_0_75 <- mean_tires + sd_to_0_75

cat("inverse_phi(0.25):", inverse_phi_0_25, "\n")
cat("inverse_phi(0.75):", inverse_phi_0_75, "\n")
cat("sd_to_0_25:", sd_to_0_25, "\n")
cat("sd_to_0_75:", sd_to_0_75, "\n")
cat("tires_at_0_25:", tires_at_0_25, "\n")
cat("tires_at_0_75:", tires_at_0_75, "\n")
cat("IQR:", tires_at_0_75 - tires_at_0_25, "\n\n")

cat("We verify our results with the qnorm()-function of R:\n")
cat("\tqnorm(0.25):", qnorm(0.25, mean = mean_tires, sd = sd_tires), "\n")
cat("\tqnorm(0.75):", qnorm(0.75, mean = mean_tires, sd = sd_tires), "\n")
cat("\tIQR (qnorm(0.75) - qnorm(0.25)):", qnorm(0.75, mean = mean_tires, sd = sd_tires) - qnorm(0.25, mean = mean_tires, sd = sd_tires), "\n")
cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("The tire dealer needs to find the milage for which only 1/15 of all tires DON'T last. ")
cat("We convert this value to a percentage, get the inverse phi from the table again ")
cat("and then we can easily calculate the milage from it:\n\n")

inverse_phi <- get_inverse_phi_from_table(1/15)
sd_from_inverse_phi <- sd_tires * inverse_phi
tire_max_mileage <- mean_tires + sd_from_inverse_phi

cat("\t1/15 =", 1/15, "\n")
cat("\tinverse_phi(1/15):", inverse_phi, "\n")
cat("\tsd_from_inverse_phi:", sd_from_inverse_phi, "\n")
cat("\ttire_max_mileage:", tire_max_mileage, "\n\n")

cat("\t(With a larger inverse phi of", inverse_phi + 0.01, "the max mileage would be ")
cat(mean_tires + (sd_tires * (inverse_phi + 0.01)), "- this is slightly more than 1/15 of ")
cat("customers.)\n\n")

cat("Lets verify this result by calculating its probability:\n\n")
cat("\tCalculated result for tire_max_mileage:", pnorm(tire_max_mileage, mean = mean_tires, sd = sd_tires), "\n")
cat("\tExpected value:", 1/15, "(Difference:", abs(1/15 - pnorm(tire_max_mileage, mean = mean_tires, sd = sd_tires)), ")")

cat("\n\n")
cat("Lets verify this result with a simulation again:\n\n")
max_miles <- get_milage_for_percentage(sim_iterations, mean_tires, sd_tires, 1/15)
cat("\nVerifying simulation results:\n")
cat("\tCalculated result for max_miles:", pnorm(max_miles, mean = mean_tires, sd = sd_tires), "\n")
cat("\tExpected value:", 1/15, "(Difference:", abs(1/15 - pnorm(max_miles, mean = mean_tires, sd = sd_tires)), ")")
cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE