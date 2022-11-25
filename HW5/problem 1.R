# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
mean_iq <- 100
sd_iq <- 16

source("globalFunctionRepository.R")

file_header(1, 5)
cat("The problem: Human resource testing\n")
cat("Some human resource departments administer standard IQ tests to all employees. The Stanford-")
cat("Binet test scores are well modeled by a Normal model with expectation 100 and standard ")
cat("deviation 16.\n\n")
cat("a) If the applicant pool is well modeled by this distribution, what is the probability that a ")
cat("randomly selected applicant would have the score in between 84 and 116?\n\n")
cat("b) For the IQ test administered by human resources, what cutoff value would separate the ")
cat("middle 95%?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION for a)\n")
cat("We calculate the probability for a proband to have score <= 116 and from this ")
cat("subtract the probability for the proband to have a score <= 84. From the ")
cat("68-95-99.7 rule of the normal distribution, we know that the result should be ")
cat("about 0.68, since both scores in question are one standard deviation away from ")
cat("the expectation:\n\n")

cat("\tpnorm(116, mean_iq, sd_iq) - pnorm(84, mean_iq, sd_iq):", pnorm(116, mean_iq, sd_iq) - pnorm(84, mean_iq, sd_iq))

cat("\n\nEND OF SOLUTION FOR A")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION for b)\n")
cat("If we interpret the question as \"what is the minimum and the maximum value ")
cat("for the middle 95% of the population?\", we just have to calculate the values ")
cat("for which (1-0.95)/2 * 100% of the population are below and above those values, ")
cat("respectively:\n\n")

upper_cutoff <- qnorm(0.025, mean_iq, sd_iq, lower.tail = FALSE)
lower_cutoff <- qnorm(0.025, mean_iq, sd_iq, lower.tail = TRUE)

cat("\tUpper cutoff (qnorm(0.025, mean_iq, sd_iq, lower.tail = FALSE)):", upper_cutoff, "\n")
cat("\tLower cutoff (qnorm(0.025, mean_iq, sd_iq, lower.tail = TRUE)):", lower_cutoff, "\n\n")

cat("We can transform those values to standard deviations easily:\n\n")

sd_cutoff <- (100 - upper_cutoff) / 16

cat("\t(100 - ")
cat(upper_cutoff)
cat(") / 16 =", sd_cutoff, "\n\n")

cat("We see that 95% of the population are within about +/-", sprintf("%.2f", abs(sd_cutoff)))
cat(" standard deviations from the mean/expectation.")

cat("\n\nEND OF SOLUTION FOR B")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE