# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(4, 4)
cat("The problem: Inversion\n")
cat("Let F be a continuous cumulative distribution function (cdf).\n\n")
cat("\t(a) Let U ~ U(0, 1) and Y = F^(-1)(U). Find the cdf of Y.\n\n")
cat("\t(b) Let X be a random variable with cdf F and Z = F(X). Find the cdf of Z.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Lets start by calculating Y = F^(-1)(U). The cdf of U(a, b) is given as:\n\n")

cat("\tF(x) = (x - a)/(b - a)\t for a <= x <= b\n")
cat("\tF(x) = 0\t\t for x < a\n")
cat("\tF(x) = 1\t\t for x > b\n\n")

cat("Therefore:\n\n")

cat("\tF^(-1)(U): y = (x - a)/(b - a) => x = a + y*(b - a)\n\n")

cat("Thus, the cdf for Y = F^(-1)(U) with U(0, 1) is:\n\n")

cat("\tY = 0 + y*(1 - 0) = y\tfor 0 <= y <= 1\n")
cat("\tY = 0\t\t\tfor y < 0\n")
cat("\tY = 1\t\t\tfor y > 1")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("We don't know the exact cdf F_X of X, since it is not explicitly stated. But since a ")
cat("cdf F_X(x) is defined as F_X(x) = P(X <= x), we can say:\n\n")

cat("\ti) F_Z(z) = P(Z <= z) = P(F_X(X) <= z)\t[since Z = F_X(X)]\n\n")

cat("As we don't have any information if F_X is not only continous but also strictly ")
cat("increasing, we have to use the generalized inverse F_X^(-1) at this point, which is:\n\n")

cat("\tii) F_X^(-1) = inf{x | F_X(x) >= p}\tfor p element of (0, 1)\n\n")

cat("With the definition from ii), we can proceed with i) in the following manner:\n\n")

cat("\tP(F_X(X) <= z) = P(X <= inf{x | F_X(x) >= z})\n\n")

cat("The step above is motivated by the following train of thought: Let us take a set A containing all x ")
cat("with F_X(x) >= z. If we now take the infimum of A, it is necessary that either F_X(x) = z ")
cat("if the infimum is just the minimum of the set A or even F_X(x) <= z if the infimum ")
cat("of A is not an element of A itself (since any cdf of continous random variables is ")
cat("monotonically increasing by definition).\n\n")

cat("Since P(X <= inf{x | F_X(x) >= z}) = P(X <= F_X^(-1)(z)):\n\n")

cat("\tF_Z(z) = P(X <= F_X^(-1)(z)) = F_X(F_X^(-1)(z)) = z\n\n")

cat("A random variable x with a cdf of the form F_X(x) = x has the same distribution as ")
cat("any U(0, 1) random variable, thus proving that Z has standard uniform distribution.\n\n")

cat("q.e.d.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE