# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 100000
mean_ch <- 188
sd_ch <- 24

source("globalFunctionRepository.R")

file_header(4, 3)
cat("The problem: Drug company\n")
cat("Manufacturing and selling drugs that claim to reduce an individual's cholesterol ")
cat("level is big business. A company would like to market their drug to women if their ")
cat("cholesterol is in the top 15%. Assume the cholesterol levels of adult American women ")
cat("can be described by a Normal model with a mean of 188 mg/dL and a standard deviation of ")
cat("24.\nUse R to answer the following questions.\n\n")
cat("\t(a) Draw and label the cumulative distribution function of this model.\n\n")
cat("\t(b) Approximate the probability that cholesterol levels of adult American women are ")
cat("over 200 mg/dL?\n\n")
cat("\t(c) Approximate the probability that cholesterol levels of adult American women are ")
cat("between 155 and 170 mg/dL?\n\n")
cat("\t(d) Compute the interquartile range of the cholesterol levels.\n\n")
cat("\t(e) Above what value are the highest 10% of the cholesterol levels of adult American women?\n\n")
cat("\tHint: R commands pnorm(), qnorm(), and dnorm() are useful.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("[Draw and label the cumulative distribution function of this model.]\n\n")
cat("See generated graphic")
curve(pnorm(x, mean = mean_ch, sd = sd_ch), from = 100, to = 300, main = "Cumulative distribution function of cholesterol levels in adult American women", 
      xlab="Cholesterol level in mg/dL", ylab="Cumulative probability", xaxp=c(100, 300, 20), yaxp=c(0.0, 1.0, 10))
abline(v=mean_ch, col="blue")
abline(h=0.5, col="red", lty=2)
#text(labels = "Blue line: Mean cholesterol level of 188 mg/dL; Red line: Median of cumulative probability", x = 10, y = 10)
legend("topleft", legend=c("Mean cholesterol level of 188 mg/dL", "Median of cumulative probability"), 
       col=c("blue", "red"), lty=1:2)
cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("[Approximate the probability that cholesterol levels of adult American women are ")
cat("over 200 mg/dL?]\n\n")
cat("We calculate this probability by using pnorm(200, mean, sd, lower.tail = FALSE):\n\n")
cat("Result:", pnorm(200, mean_ch, sd_ch, lower.tail = FALSE))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("[Approximate the probability that cholesterol levels of adult American women are ")
cat("between 155 and 170 mg/dL?]\n\n")
cat("We calculate this probability by using pnorm(170, mean, sd) - pnorm(155, mean, sd):\n\n")
cat("Result:", pnorm(170, mean_ch, sd_ch) - pnorm(155, mean_ch, sd_ch))

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("[Compute the interquartile range of the cholesterol levels.]\n\n")
cat("We calculate this probability by using qnorm(0.75, mean, sd) - qnorm(0.25, mean, sd):\n\n")
cat("Result:", qnorm(0.75, mean_ch, sd_ch) - qnorm(0.25, mean_ch, sd_ch))

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e)\n")
cat("[Above what value are the highest 10% of the cholesterol levels of adult American women?]\n\n")
cat("We calculate this probability by using qnorm(0.1, mean_ch, sd_ch, lower.tail = FALSE):\n\n")
cat("Result:", qnorm(0.1, mean_ch, sd_ch, lower.tail = FALSE), "\n")
#cat("Result:", qnorm(0.9, mean_ch, sd_ch, lower.tail = TRUE))

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE