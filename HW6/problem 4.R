# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(4, 6)
cat("The problem: Unbiasedness of the empirical variance\n")
cat("Let n >= 2 and X1, ..., Xn be i.i.d. (independent and identically distributed) ")
cat("random variables, with ?sigma^2 := Var(X1) < inf. Calculate the expectation of ")
cat("the empirical variance\n\n")
cat("\tS^2 = (1/(n-1)) * sum_of_i=1_to_n_of((Xi - X_bar)^2)\n\n")
cat("What would have been the expectation if in S2 we had scaled with n instead of n - 1?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("TEXT")


cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE