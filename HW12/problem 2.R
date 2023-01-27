# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("HW12_helper.R")

file_header(2, 12)
cat("The problem: Regression\n")
cat("A lecture was evaluated. In the file Evaluation.Rdata you find data of n = 25 ")
cat("students. Acquired were first, the points achieved in the associated exercises ")
cat("(between 0 and 200 possible), and second, the result of the exam (in %).\n\n")

cat("2) Assume now the linear regression model Yi = beta0 + beta1*xi + sigma*Zi, ")
cat("i = 1, ..., n with Z1, ..., Zn i.i.d. with Z1 ~ N(0, 1), and (beta0, beta1, sigma^2) ")
cat("in R x R x R+. Test the null hypothesis H0 : beta1 = 0 against HA : beta1 != 0 at ")
cat("a significance level of 5%. Without using R, compute\n\n")

cat("\ta) the standard error of the regression sr,\n")
cat("\tb) the standard error se_b1 of the slope beta1,\n")
cat("\tc) the value of the t-statistic,\n")
cat("\td) the t-distribution associated with H0, and,\n")
cat("\te) the p-value.\n")
cat("\tf) Formulate a result.\n")
cat("\tg) Fit the data to the model using the command lm(). Read the outcome of ")
cat("the test of the null hypothesis H0 : beta1 = 0 from the output of summary().")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
Evaluation <- load_evaluation_data()
x <- Evaluation$Uebungspunkte
y <- Evaluation$Klausurergebnis
cat("\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("The variance sigma^2 of the regression is estimated as:\n\n")

cat("\tSr^2 = 1/(n - 2) * sum_i=1_to_n_of([Yi - (B0 + B1 * xi)]^2)\n\n")

cat("We calculate B0 and B1 again and then we estimate the variance of the ")
cat("regressions as Sr^2:\n\n")

# See HW12_helper.R for code for functions used
estimators <- get_least_square_estimators(x, y)
Sr_squared <- get_Sr_squared(x, y, estimators$B0, estimators$B1)
Sr <- sqrt(Sr_squared)
cat(sprintf("\tB0 = %.3f, B1 = %.3f\n", estimators$B0, estimators$B1))
cat(sprintf("\tSr^2 = %.3f\n\n", Sr_squared))

cat("The standard error of the regression thus is:\n\n")
cat(sprintf("\tSr = %.3f", Sr))

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("The standard error se_b1 of the slope beta1 is given as:\n\n")

cat("\tse_b1 = Sr / (s_x * sqrt(n - 1))\n\n")

cat("We plug our previously calculated data into this formula and thus get:\n\n")

se_b1 <- Sr / (sd(x) * sqrt(length(x) - 1))
cat(sprintf("\tse_b1 = %.3f / (%.3f * sqrt(%d - 1)) = %.3f", Sr, sd(x), length(x), se_b1))

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("Under H0 : beta1 = beta1_0, the t-statistic is given as:\n\n")

cat("\tT = (B1 - beta_1_0) / se_b1\n")
cat("\tT ~ t(n - 2)\n\n")

cat("Since in our case H0 : beta1 = 0 and therefore beta_1_0 = 0, we calculate:\n\n")

t <- estimators$B1 / se_b1
cat(sprintf("\tt = b1 / se_b1 = %.3f / %.3f = %.3f", estimators$B1, se_b1, t))


cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("In the case of our statistical model, it holds:\n\n")

cat("\tT ~ t(n - 2)\n")
cat(sprintf("\t=> T ~ t(%d)", length(x) - 2))

cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e)\n")
cat("The p-value is calculated as follows (two-sided test!):\n\n")

p <- 2 * pt(-abs(t), df = length(x) - 2)
cat(sprintf("\tp = 2 * pt(-abs(t), df = n-2) = %.5f", p))

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR f)\n")
cat("Our significance level is %5, therefore:\n\n")

cat(sprintf("\tp = %.5f, alpha = 0.05\n", p))
cat("\t=> p < alpha\n\n")

cat("Reject H0 : beta1 = 0. Exam results don't seem to be independent from exercise ")
cat("points achieved at a significance level of 5%.")

cat("\n\nEND OF SOLUTION FOR f)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR g)\n")
cat("We recalculate the linear regression model with R:\n")

result_text <- capture.output(summary(lm(formula = y ~ x)))
result_data <- summary(lm(formula = y ~ x))

for(s in result_text) {
  cat(s, "\n")
}

cat("\nWe will now compare our calculated values with the values calculated by R:\n\n")

cat(sprintf("%16s|%11s|%11s\n", "", "our value ", "R value "))
cat("----------------|-----------|-----------\n")
cat(sprintf("%16s|%10.3f |%10.3f\n", "B0 ", estimators$B0, result_data$coefficients[1, 1]))
cat(sprintf("%16s|%10.3f |%10.3f\n", "B1 ", estimators$B1, result_data$coefficients[2, 1]))
cat(sprintf("%16s|%10.3f |%10.3f\n", "Sr ", Sr, result_data$sigma))
cat(sprintf("%16s|%10.3f |%10.3f\n", "se_b1 ", se_b1, result_data$coefficients[2, 2]))
cat(sprintf("%16s|%10.3f |%10.3f\n", "t ", t, result_data$coefficients[2, 3]))
cat(sprintf("%16s|%10.3f |%10.3f\n", "df ", length(x) - 2, result_data$df[2]))
cat(sprintf("%16s|%10.3f |%10.3f\n", "p ", p, result_data$coefficients[2, 4]))

cat("\nAs we see, we have manually calculated exactly the same values as R.")

cat("\n\nEND OF SOLUTION FOR g)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE