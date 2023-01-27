# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("HW12_helper.R")

file_header(1, 12)
cat("The problem: Regression\n")
cat("A lecture was evaluated. In the file Evaluation.Rdata you find data of n = 25 ")
cat("students. Acquired were first, the points achieved in the associated exercises ")
cat("(between 0 and 200 possible), and second, the result of the exam (in %).\n\n")

cat("1) Can the result of the exam be explained by the points achieved in the exercises?\n\n")

cat("\ta) Plot the result of the exam (yi) against the exercise points (xi). Do you ")
cat("observe a relation?\n")
cat("\tb) Compute the intercept b0 and the slope b1 of the regression line (without lm()) ")
cat("and plot the regression line. Comment on the meaning of the slope.\n")
cat("\tc) Would you say that the relation is causal? This means, that e.g., many ")
cat("points in the exercises are the reason for a good exam?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
Evaluation <- load_evaluation_data()
cat("\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("See code for plot generation.\n\n")

x <- Evaluation$Uebungspunkte
y <- Evaluation$Klausurergebnis

plot(x, y, type = "p", main = "Exercise points vs. exam results, 25 students", 
     xlab = "Exercise points (0-200)", ylab = "Exam results in %", xlim = c(0, 200),
     ylim = c(0, 100), las = 1)

grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)

cat("DISCUSSION:\n")

cat("There seems to be a somewhat linear relation between exercise points and exam ")
cat("results in the sense of a positive correlation. This means that with increasing ")
cat("exam points, students may also achieve better exam results. The correlation is ")
cat("not extremely strong however, and further calculations are needed to verify ")
cat("our intuition.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("See regression line yi is given as:\n\n")

cat("\tyi = beta_0 + beta_1 * x_i + e_i\n\n")

cat("Only a line which minimizes the sum of squares of the residuals is actually a ")
cat("regression line. We now employ the method of least squares to estimate values ")
cat("b_0 and b_1 for beta_0 and beta_1, respectively, such that the following sum is minimal:\n\n")

cat("\tsum_from_i=1_to_n_of((e_i)^2) = sum_from_i=1_to_n_of((yi - [beta_0 + beta_1 * x_i])^2)\n\n")

cat("We start by calculating the means x_bar and y_bar of x and y and the standard ")
cat("deviations s_x and s_y of x and y:\n\n")

x_bar <- mean(x)
y_bar <- mean(y)
s_x <- sd(x)
s_y <- sd(y)
cat(sprintf("\tx_bar = %.2f, y_bar = %.2f, s_x = %.2f, s_y = %.2f\n\n", x_bar, y_bar, s_x, s_y))

cat("Now we estimate the empirical calculation r:\n\n")

r <- get_empirical_correlation(x, y, length(x)) # For code see HW12_helper.R
cat("\tr = ", r, "\n\n")

cat("We can now easily calculate the estimators b0 and b1:\n\n")

b1 <- r * (s_y/s_x)
b0 <- y_bar - b1 * x_bar
cat(sprintf("\tb1 = r * (s_y/s_x) = %.2f * (%.2f/%.2f) = %.2f\n", r, s_y, s_x, b1))
cat(sprintf("\tb0 = y_bar - b1 * x_bar = %.2f - %.2f * %.2f = %.2f\n\n", y_bar, b1, x_bar, b0))

cat("We can now plot the regression line (see code).\n\n")

plot(x, y, type = "p", main = "Exercise points vs. exam results, 25 students", 
     xlab = "Exercise points (0-200)", ylab = "Exam results in %", xlim = c(0, 200),
     ylim = c(0, 100), las = 1)
abline(a = b0, b = b1, col = "Red", lwd = 2)
legend("topright", legend = "Regression line", col = "Red", lwd = 2)

grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)

cat("Regarding the slope s_y/s_x of the regression line:\n")
cat("The slope means that for each step to the right of size s_x, the y-value ")
cat("increases by s_y. In other words: for each increase of s_x in exercise points, ")#
cat("the exam result increases by s_y.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("One of the most important statements in science in general is:\n\n")

cat("\tCorrelation does not equal causation.\n\n")

cat("This statement will be easily understandable if we enumerate the possible ")
cat("causes for a high correlation between two variables x and y:\n\n")

cat("\t1) Variable x affects variable y\n")
cat("\t2) Variable y affects variable x\n")
cat("\t3) Both variables affect each other\n")
cat("\t4) Both variables are affected by an hitherto unknown variable z\n")
cat("\t5) The correlation is artificial, there is no real connection between\n")
cat("\t   x and y in truth\n\n")

cat("Since we have no way to know which of the statements 1-5 is true here just ")
cat("from the data given, all statements about causation in this example would be ")
cat("pure conjecture without scientific basis.\n\n")

cat("See https://www.tylervigen.com/spurious-correlations for some excellent and ")
cat("quiet entertaining examples for correlations mainly of type 5 (and sometimes ")
cat("perhaps type 4).")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE