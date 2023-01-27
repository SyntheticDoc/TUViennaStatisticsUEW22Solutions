# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")
source("problem 3b.R")

file_header(3, 11)
cat("The problem: χ^2-test for independence (without R)\n")
cat("100 students from major computer science of three Viennese Universities were ")
cat("randomly chosen and asked which lecture of mathematics (a: calculus, b: ")
cat("algebra, c: probability) they enjoyed most. The frequencies are given in ")
cat("the following table:\n\n")

cat(sprintf("               |  Uni A   Uni B   Uni C\n"))
cat("---------------|------------------------\n")
cat(sprintf(" %13s | %4d    %4d    %4d\n", "calculus", 10, 5, 5))
cat(sprintf(" %13s | %4d    %4d    %4d\n", "algebra", 10, 20, 10))
cat(sprintf(" %13s | %4d    %4d    %4s\n\n", "probability", 20, 5, "-"))

cat("Perform a χ^2-test to test whether the preference for a lecture is independent ")
cat("from the university, on a 5% significance level. Only use the following table ")
cat("which gives the 95%-quantile q of the χ^2-distribution with df degrees of freedom.\n\n")

cat(" df |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   \n")
cat("----|-------|-------|-------|-------|-------|-------|-------|-------|-------\n")
cat("  q |  3.84 |  5.99 |  7.81 |  9.49 | 11.07 | 12.59 | 14.07 | 15.51 | 16.92  ")

cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("Let feature 1 be the kind of mathematics lecture (calculus, algebra, probability) ")
cat("and feature 2 the University in question (Uni A, Uni B, Uni C). Our question ")
cat("now is: Is the frequency of lectures preferred by students independent from the ")
cat("university they are from?\n\n")

cat("If we add up all answers by students, we quickly realize that the result is ")
cat("85 and that data for the probability-lecture at Uni C is missing. We can make ")
cat("one of two assumptions now: Either all 15 missing students choose probability ")
cat("at Uni C, so the missing entry in the table would be \"15\" - or all 15 students ")
cat("did choose no lecture at all, so the missing table entry would be \"0\". We will ")
cat("calculate the χ^2-test for both assumptions and compare the results at the end.\n\n")

cat("Lets start calculating:\n\n")

# Calculus frequencies
L1_vec <- c(10, 5, 5)

# Algebra frequencies
L2_vec <- c(10, 20, 10)

# Probability frequencies with both assumptions about the missing value
L3_1_vec <- c(20, 5, 15)
L3_2_vec <- c(20, 5, 0)

#test <- get_matrix_test(c(25, 22, 19, 14), c(27, 19, 44, 60))
dat1 <- get_matrix(L1_vec, L2_vec, L3_1_vec)
dat2 <- get_matrix(L1_vec, L2_vec, L3_2_vec)

#test_e <- get_e_matrix(test)
dat1_e <- get_e_matrix(dat1)
dat2_e <- get_e_matrix(dat2)

#chi_s_test <- get_chi_squared(test, test_e)
chi_s_dat1 <- get_chi_squared(dat1, dat1_e)
chi_s_dat2 <- get_chi_squared(dat2, dat2_e)

#cat("\tchi_s_test = ", chi_s_test, "\n")
cat("\tchi_s_dat1 = ", chi_s_dat1, "\n")
cat("\tchi_s_dat2 = ", chi_s_dat2, "\n\n")

cat("Our df for both tests are: (3 - 1) * (3 - 1) = 4. Therefore, q = 9.49 for the ")
cat("95%-quantile. For both assumptions, we get the following results:\n\n")

cat("\tAssumption 1, missing value = 15:\n")
cat(sprintf("\t   chi_squared = %.3f > q = 9.49 => reject H0.\n\n", chi_s_dat1))

cat("\tAssumption 2, missing value = 0:\n")
cat(sprintf("\t   chi_squared = %.3f > q = 9.49 => reject H0.", chi_s_dat2))

cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE