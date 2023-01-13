# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

# Set the next variable to TRUE to skip the whole "General Remark"-part
skip_general_remark = FALSE

source("globalFunctionRepository.R")
source("problem 5b.R")
source("problem 1b.R")

file_header(5, 6)
cat("The problem: Postbox\n")
cat("Let x1, x2, ..., xn be the locations of n households along a street. At ")
cat("which position p should a postbox be placed such that\n\n")
cat("\ta) sum_of_i=1_to_n_of(|xi - p|) is minimized?\n\n")
cat("\tb) sum_of_i=1_to_n_of((xi - p)^2) is minimized?")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
# cat("NOTICE\n")
# cat("If we interpret a \"location\" as a point x on a line, we immediately ")
# cat("see that |xi - p| and (xi - p)^2 in this exercise can be read as metrics on ")
# cat("a metric space (a set with the added notion of \"distance\" between its elements, ")
# cat("which can be seen as the real numbers here).\n")
# cat("In this case, |xi - p| is the absolute difference between two real numbers xi and p, ")
# cat("while (xi - p)^2 is the square of the difference between two real numbers xi and p.")
# 
# cat("\n\nEND OF NOTICE")
# cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
if(!skip_general_remark) {
  cat("GENERAL REMARK\n")
  cat("We start this exercise by doing some test runs with an approximation algorithm ")
  cat("developed by me myself to verify our intuition that both the median and mean ")
  cat("are probably good solutions to a) and b):\n\n")
  
  debug <- FALSE
  dat <- c(1, 2, 3, 30)
  cat("d1 - ")
  d1 <- start_random_compared_run(0, 0, 0, dat)
  cat("\nWith our quantile estimator from exercise 1b, we get:\n")
  get_quantile(d1$data, 0.5)
  cat("\n-------------------------------------\n")
  cat("d2 - ")
  d2 <- start_random_compared_run(-30, 30, 10)
  cat("\nWith our quantile estimator from exercise 1b, we get:\n")
  get_quantile(d2$data, 0.5)
  cat("\n-------------------------------------\n")
  cat("d3 - ")
  d3 <- start_random_compared_run(-10, 300, 75)
  cat("\nWith our quantile estimator from exercise 1b, we get:\n")
  get_quantile(d3$data, 0.5)
  cat("\n-------------------------------------\n")
  #d4 <- start_random_compared_run(0, 0, 0, round(rnorm(80, 10, 60)))
  cat("d4 - ")
  d4 <- start_random_compared_run(0, 0, 0, round(rexp(100, 1/100)))
  cat("\nWith our quantile estimator from exercise 1b, we get:\n")
  get_quantile(d4$data, 0.5)
  
  plot_data(d1)
  plot_data(d2)
  plot_data(d3)
  plot_data(d4)
  
  cat("\n\nEND OF GENERAL REMARK")
  cat("\n\n", string_divider, "\n\n")
}
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("From our algorithmic probing above, we would intuitively say that any median ")
cat("of the sample data minimizes the sum of absolute deviations.\n\n")

cat("We try to outline a proof for this so called \"optimality property of the median\" now.\n\n")

cat("Let us first consider two arbitrary real-valued numbers x1, x2 with x1 < x2. ")
cat("Now let us choose a point a with x1 <= a <= x2. The sum of absolute deviations (SAD) ")
cat("of x1, x2 from a is: (a - x1) + (x2 - a) = -x1 + x2 = x2 - x1.\n")
cat("If a < x1, the SAD is: (x1 - a) + (x2 - a) = x1 + x2 - 2a > x1 + x2 - (2*x1) ")
cat("= x2 - x1. With the same reasoning, we get for a > x2: (a - x1) + (a - x2) = ")
cat("2a - x1 - x2 > (2*x2) - x1 - x2 = x2 - x1.\n\n")

cat("We see that any a minimizes the SAD of x1, x2 (with x1 < x2) if x1 <= a <= x2, ")
cat("and the resulting SAD always evaluates to x2 - x1.\n\n")

cat("We now examine a set of nested intervals of the form [x_1, x_n], [x_2, x_n-1], ..., ")
cat("[x_i, x_j] with i <= j and (n + 1) - i = j. We learned from our example of x1, x2 ")
cat(" (with x1 < x2) that a minimizes the SAD of any such two arbitrary real valued numbers and a, if ")
cat("a is an element of the interval [x1, x2]. With this reasoning, we can find an a ")
cat("which minimizes any of the nested intervals if x_i <= a <= x_j. We immediately see ")
cat("that an a which minimizes ALL nested intervals is always >= the left interval bound and ")
cat("<= the right interval bound and thus partitions the ordered set of x_1, ..., x_n in two ")
cat("halves, which is a definition of the median.\n\n")

cat("In other words: Any value minimizing the innermost interval (of an ordered set!) ")
cat("[x_floor(n/2), x_ceiling(n_2)] also minimizes all other (outer) intervals and is ")
cat("a median for the set.\n\n")

cat("q.e.d.\n\n")

cat("Example: Consider the ordered set {1, 2, 3, 4, 5, 6, 7, 8}:\n")
cat("Any number a that minimizes [4, 5] also minimizes [3, 6], [2, 7], [1, 8].")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Again from our algorithmic probing, we derive that the mean of the sample data ")
cat("minimizes the sum of its squared deviations.\n\n")

cat("We will prove this by contradiction. Let p be the sample mean. Suppose there ")
cat("is a number p + c (with c as real number) which minimizes the squared deviations ")
cat("more than p itself, then:\n\n")

cat("Sum((x_i - (p + c))^2) = Sum(x_i^2 - 2*x_i*(p + c) + (p + c)^2)\n")
cat("= Sum(x_i^2 - 2*x_i*p - 2*x_i*c + p^2 + 2*p*c + c^2)\n")
cat("= Sum(x_i^2) - 2*p*Sum(x_i) - 2*c*Sum(x_i) + Sum(p^2) + 2*c*Sum(p) + Sum(c^2)\n")
cat("= Sum(x_i^2) - 2*p*Sum(x_i) - 2*c*Sum(x_i) + Sum(p^2) + 2*c*n*p + n*(c^2)\n")
cat("= Sum(x_i^2) - 2*p*Sum(x_i) - 2*c*Sum(x_i) + Sum(p^2) + 2*c*n*(Sum(x_i)/n) + n*(c^2)\n")
cat("= Sum(x_i^2) - 2*p*Sum(x_i) - 2*c*Sum(x_i) + Sum(p^2) + 2*c*Sum(x_i) + n*(c^2)\n")
cat("= Sum(x_i^2) - 2*p*Sum(x_i) + Sum(p^2) + n*(c^2)\n")
cat("= Sum(x_i^2 - 2*p*x_i + p^2) + n*(c^2)\n")
cat("= Sum((x_i - p)^2) + n*(c^2)\n\n")

cat("It is obvious that if c != 0, the sum of squared deviations with respect to (p + c) ")
cat("will be greater by a factor of n*(c^2) than the sum of squared deviations with ")
cat("respect to p. So to minimize the sum of squared deviations, it is necessary that c = 0 and ")
cat("therefore (p + c) = p.\n\n")

cat("q.e.d.")

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE