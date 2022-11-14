# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
sim_iterations <- 100000

source("globalFunctionRepository.R")

file_header(5, 3)
cat("The problem: Uniform-exponential relationship\n")
cat("Let X ~ U(0, 1).\n\n")
cat("\t(a) Find the cumulative distribution function of X.\n\n")
cat("\t(b) Show that the random variable Y = -ln(X) has exponential distribution exp(1), ")
cat("where ln denotes the natural logarithm.")
cat("\n\n", string_divider, "\n\n")
cat("SOLUTION FOR a)\n")
cat("We already know from the problem description that X is distributed uniformly. ")
cat("Therefore, we just use the common cdf for uniform distributions, which is:\n\n")
cat("\tFor X ~ U(a, b):\n")
cat("\t  F(X) = 0\t\t\tif x <= a\n")
cat("\t  F(X) = 1\t\t\tif x >= b\n")
cat("\t  F(X) = (x - a)/(b - a)\tif a < x < b\n\n")

cat("For X ~ U(0, 1), we have a = 0, b = 1, and therefore the cdf is:\n\n")
cat("\tF(X) = 0\t\t\tif x <= 0\n")
cat("\tF(X) = 1\t\t\tif x >= 1\n")
cat("\tF(X) = (x - 0)/(1 - 0) = x\tif 0 < x < 1\n\n")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("We use the method for transformations of continuous random variables from the ")
cat("slides, which is:\n\n")

cat("\tUse the cumulative distribution function of X:\n")
cat("\t  i) Determine F_X\n")
cat("\t  ii) Determine F_Y for Y = g(X)\n")
cat("\t  iii) Find f_Y(y) = F'_Y(y)\n\n")

cat("We have Y = -ln(X), and therefore:\n\n")
cat("\tF_Y(y) = P(Y <= y) = P(-ln(X) <= y)\n")
cat("\tSolve P(-ln(X) <= y) for X:\n")
cat("\t  P(-ln(X) <= y) = P(ln(X) >= -y) = P(X >= e^(-y)) = P(X < 1 - e^(-y))\n\n")
cat("\tWe plug this value now into F_X to get F_Y. To get the full cdf, we ")
cat("first calculate what will happen for y <= 0 and y >= 1. We get:\n\n")
cat("\ty = 0 => 1 - e^(0) = 1 - 1 = 0\n")
cat("\ty < 0 => lim_for_y_to_minus_inf(1 - e^(-y)) = 1 - lim_for_y_to_minus_inf(e^(-y))\n")
cat("\t  (with u = -x and lim_for_x_to_minus_inf(-x) = inf) => lim_for_u_to_pos_inf(e^u) = inf\n")
cat("\t  1 - lim_for_y_to_minus_inf(e^(-y)) = 1 - inf = -inf\n")
cat("\ty >= 1 => lim_for_y_to_pos_inf(1 - e^(-y)) = 1 - lim_for_y_to_pos_inf(e^(-y))\n")
cat("\t  lim_for_y_to_pos_inf(1/(e^y)) = 1/lim_for_y_to_pos_inf(e^y) = 1/inf = 0\n")
cat("\t  lim_for_y_to_pos_inf(1 - e^(-y)) = 1 - 0 = 1\n\n")

cat("The cdf therefore is:\n\n")
cat("\tF_Y(y) = 0\t\t\tif y < 0\n")
cat("\tF_Y(y) = 1 - e^(-y)\t\tif y >= 0\n\n")

cat("We differentiate F_Y to get f_y:\n")
cat("F'_Y(y) = d/dx(1 - e^(-y)) = d/dx(1) - d/dx(e^(-y)) = 0 - e^(-y)*d/dx(-y) [Limit chain rule: df(u)/dx = df/du * du/dx]\n")
cat("= 0 - e^(-y) * (-1) = 0 + e^(-y) = e^(-y)\n\n")

cat("The pdf therefore is:\n\n")
cat("\tf_Y(y) = 0\t\t\tif y < 0\n")
cat("\tf_Y(y) = e^(-y)\t\t\tif y >= 0\n\n")

cat("The exponential distribution exp(lambda) is the same, except for the term for ")
cat("y >= 0, which is lambda*e^(-lambda*y) for exp(lambda). For exp(1) <> lambda = 1, ")
cat("we obviously have lambda*e^(-lambda*y) = 1*e^(-y * 1) = e^(-y), which is exactly ")
cat("the term in the pdf we found and thus proof that Y = -ln(X) has exponential distribution exp(1).")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE