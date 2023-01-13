# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(4, 9)
cat("The problem: Which statement is correct?\n")
cat("In the situation of a (two-sided) two-sample t-test at 5%-significance level, ")
cat("assume that the null hypothesis H0 : d = d0 was rejected. Comment on the ")
cat("following statements.\n\n")
cat("\ta) The null hypothesis would also be rejected at the 7%-level.\n")
cat("\tb) The equivalent 99% confidence interval does not contain d0.\n")
cat("\tc) If both sample sizes are increased by a factor 4, then the value of\n")
cat("\t   the t-statistic is halved if all other estimates remain the same.\n")
cat("\td) If one of the sample sizes is increased, then the width of the 95%-confidence\n")
cat("\t   interval is increased (if all other estimates remain the same)\n")
cat("\te) There is a 5% chance that the null hypothesis is true.\n")
cat("\tf) If the null hypothesis is true, there is a 5% chance that we came to the wrong conclusion.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a) [The null hypothesis would also be rejected at the 7%-level.]\n")
cat("True.\n\n")
cat("As we already know, for the quantiles of the t-distribution it holds (since ")
cat("its cdf is strictly monotonically increasing):\n\n")

cat("\tq_0.025 < q_0.035, q_1-0.025 > q_1-0.035\n\n")

cat("Obviously, the rejection area R = (-inf, q_alpha/2] AND [q_1-alpha/2, inf) is ")
cat("smaller for a 5%-significance level than at a 7%-level. Therefore, rejecting at ")
cat("alpha = 0.05 implies also rejecting at alpha = 0.07, since if t is in R for ")
cat("alpha = 0.05, it must also be in R for alpha = 0.07.\n\n")
cat("Another argument: a significance level (= probability for a Type I error) of ")
cat("0.05 is more strict than a level of 0.07. Thus, rejecting at alpha = 0.05 implies ")
cat("also rejecting at alpha = 0.07.")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b) [The equivalent 99% confidence interval does not contain d0.]\n")
cat("Unknown.\n\n")
cat("If H0 is rejected, the probability that d0 is not included in the 95%-CI is alpha, ")
cat("which is 0.05 = 5% in our case. For a 99%-CI, the probability that d0 is not ")
cat("included in this interval is only 0.01 = 1%. Since alpha = 0.01 is more strict ")
cat("than alpha = 0.05, we do not know if H0 would also be rejected on this significance ")
cat("level. This also implies that we can't know if the 99%-CI includes d0 or not.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c) [Both sample sizes increased by 4 => value of t-statistic halved?]\n")
cat("False.\n\n")
cat("The t-statistic is given as:\n\n")
cat("\tt = (x_bar - y_bar) / sqrt(sem_x^2 + sem_y^2)\n\n")

cat("Lets calculate the factor by which some t-statistic t_1 is multiplied to get ")
cat("the t-statistic t_4 (the t-statistic for quadrupled sample sizes m = n*4, all other things ")
cat("being equal):\n\n")

cat("\tLets first calculate the factor by which sem changes:\n")
cat("\tsem = 1/sqrt(n) => sem_4 = 1/sqrt(m) = 1/sqrt(4*n)\n")
cat("\tsem_4 = sem * (sem_4/sem) = sem * (sqrt(n)/(sqrt(4)*sqrt(n))) = sem * 0.5\n\n")

cat("\tt_4 = t_1 * factor => factor = t_4/t_1\n")
cat("\tfactor = (1/sqrt(sem_4_x^2 + sem_4_y^2)) / (1/sqrt(sem_x^2 + sem_y^2)\n")
cat("\t= sqrt(sem_x^2 + sem_y^2) / sqrt((0.5 * sem_x)^2 + (0.5 * sem_y)^2)\t[Use sem_4 = 0.5 * sem from above]\n")
cat("\t= sqrt((sem_x^2 + sem_y^2) / (0.5 * sem_x)^2 + (0.5 * sem_y)^2)\n")
cat("\t= sqrt((sem_x^2 + sem_y^2) / 0.25 * ((sem_x)^2 + (sem_y)^2))\t\t[Cancel common factor (sem_x^2 + sem_y^2)]\n")
cat("\t= sqrt(1/0.25) = sqrt(4) = 2\n\n")
cat("\t=> t_4 = t_1 * 2\n\n")

cat("The t-statistic is doubled instead of halved.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d) [If one sample size is increased, is width of 95%-CI also increased?]\n")
cat("False.\n")
cat("The CI is given as:\n\n")
cat("\tI := ((X_bar - Y_bar) - q_1-alpha/2 * sqrt(sem_x^2 + sem_y^2),\n")
cat("\t      (X_bar - Y_bar) + q_1-alpha/2 * sqrt(sem_x^2 + sem_y^2))\n\n")

cat("Therefore, the width of the CI is:\n\n")
cat("\tw = (X_bar - Y_bar) + q_1-alpha/2 * sqrt(sem_x^2 + sem_y^2) - (X_bar - Y_bar) + q_1-alpha/2 * sqrt(sem_x^2 + sem_y^2)\n")
cat("\t= 2 * q_1-alpha/2 * sqrt(sem_x^2 + sem_y^2)\n\n")

cat("Let w1 be the width for a 95%-CI for sample sizes n1, n2. Let w2 be the width for ")
cat("a 95%-CI for sample sizes m1, m2 (with (m1 > n1 and m2 = n2) or (m1 = n1 and m2 > n2). ")
cat("Let all estimated variances S_i be equal to 1. Now, if m1 > n1 it follows that ")
cat("(1/sqrt(m1))^2 < (1/sqrt(n1))^2. m2 > n2 equivalently implies (1/sqrt(m2))^2 < (1/sqrt(n2))^2. ")
cat("Either way, from the derivation of the factor above, we immediately see that the ")
cat("factor decreases since:\n\n")

cat("\tIf (m1 > n1, m2 = n2) or (m1 = n1, m2 > n2):\n")
cat("\tsqrt((1/sqrt(m1))^2 + (1/sqrt(m2))^2) < sqrt((1/sqrt(n1))^2 + (1/sqrt(n2))^2)\n")
cat("\t => w2 < w1\n\n")

cat("This is clear intuitively: More samples mean more information to draw conclusions ")
cat("from, so our estimates naturally get more precise. Since the CI is a measure of ")
cat("estimation reliability, the CI gets narrower (= more precise) when the sample ")
cat("size increases.")


cat("\n\nEND OF SOLUTION FOR d)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR e) [There is a 5% chance that the null hypothesis is true.]\n")
cat("False.\n")
cat("We can't know if the null hypothesis is true. In fact, to do hypothesis testing, ")
cat("we already theoretically assume that H0 is true and calculate how compatible with H0 ")
cat("our data is. This doesn't tell us anything about the null hypothesis itself, since ")
cat("we only reason about (probably small) data samples from a very large unknown ")
cat("population. What a significance level of 5% is indeed telling us is the probability ")
cat("to commit a Type I error: wrongfully rejecting H0 (under the assumption that H0 is true!).")

cat("\n\nEND OF SOLUTION FOR e)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR f) [If the null hypothesis is true, there is a 5% chance that we came to the wrong conclusion.]\n")
cat("False.\n")
cat("As remarked in e), if H0 is true, we have a 5% chance of committing a Type I error. ")
cat("Since we rejected H0 already in this example, there is no probability to make any decision ")
cat("anymore - we know we have made a Type I error, since H0 in this case is true, ")
cat("but we have rejected it.\n")
cat("If H0 would instead not be known to be true, then the chance to have come to the wrong ")
cat("conclusion would indeed have been 5% (= alpha = P(Type I error)).")

cat("\n\nEND OF SOLUTION FOR f)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE