# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

get_sum_for_k <- function() {
  sum <- 0
  
  for(x in 0:6) {
    sum <- sum + ((x + 1) * (-x + 7))
  }
  
  return(sum)
}

print_pmf_for <- function(x, k) {
  cat("\tp(")
  cat(x)
  cat(") =", get_pmf_for(x, k), "\n")
}

get_pmf_for <- function(x, k) {
  return(k * ((x + 1) * (-x + 7)))
}

get_pmf_for_X_le_5 <- function(k) {
  sum <- 0
  
  for(i in 0:5) {
    sum <- sum + get_pmf_for(i, k)
  }
  
  return(sum)
}

get_expected_value_times <- function(k, e) {
  sum <- 0
  
  for(i in 0:6) {
    sum <- sum + ((i^e) * get_pmf_for(i, k))
  }
  
  return(sum)
}

variance_test <- function(iterations) {
  v <- c()
  car_vec <- c(0, 1, 2, 3, 4, 5, 6)
  
  for(i in 1:iterations) {
    v <- c(v, sample(car_vec, 1, replace = TRUE, c(0.08333333, 0.1428571, 0.1785714, 0.1904762, 0.1785714, 0.1428571, 0.08333333)))
  }
  
  cat("\n\nVariance:", var(v), "\nStandard deviation:", sd(v),"\n\n")
}