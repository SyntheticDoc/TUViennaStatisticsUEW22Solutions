# Function repository for helper functions for HW8

get_string_empirical_sd_formula <- function() {
  return("S^2 = 1/(n - 1) * sum_from_i=1_to_n_of((X_i - X_bar)^2)")
}

get_conf_inf <- function (dat, alpha) {
  factor <- qt(1 - alpha/2, length(dat) - 1) * calc_SEM(dat)
  left_bound <- mean(dat) - factor
  right_bound <- mean(dat) + factor
  
  if(left_bound > right_bound) {
    temp <- left_bound
    left_bound <- right_bound
    right_bound <- temp
  }
  
  return(c(left_bound, right_bound))
}

get_conf_inf_non_normal <- function (dat, alpha) {
  factor <- qnorm(1 - alpha/2) * calc_SEM(dat)
  left_bound <- mean(dat) - factor
  right_bound <- mean(dat) + factor
  
  if(left_bound > right_bound) {
    temp <- left_bound
    left_bound <- right_bound
    right_bound <- temp
  }
  
  return(c(left_bound, right_bound))
}

calc_empirical_sigma <- function(X_i, X_bar) {
  n <- length(X_i)
  
  sum <- 0
  
  for(i in 1:n) {
    sum <- sum + ((X_i[i] - X_bar)^2)
  }
  
  return((1/(n-1))*sum)
}

calc_SEM <- function(dat) {
  return(sqrt(calc_empirical_sigma(dat, mean(dat)))/sqrt(length(dat)))
}