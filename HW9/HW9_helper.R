# Function repository for homework 9

# Get standard error according to t-test, Model 'Student'
get_std_err_student <- function(X, Y) {
  n1 <- length(X)
  n2 <- length(Y)
  multiplier <- 1/n1 + 1/n2
  
  return(sqrt(multiplier * get_pooled_empirical_variance(X, Y)))
}

# Get pooled empirical variance
get_pooled_empirical_variance <- function(X, Y) {
  n1 <- length(X)
  n2 <- length(Y)
  numerator <- ((n1 - 1) * calc_empirical_variance(X)) + ((n2 - 1) * calc_empirical_variance(Y))
  denominator <- n1 + n2 - 2
  return(numerator/denominator)
}

# Calculate standard error of the mean
calc_SEM <- function(dat) {
  return(sqrt(calc_empirical_variance(dat))/sqrt(length(dat)))
}

# Calculate empirical variance
calc_empirical_variance <- function(X) {
  n <- length(X)
  mean_X <- mean(X)
  
  sum <- 0
  
  for(i in 1:n) {
    sum <- sum + ((X[i] - mean_X)^2)
  }
  
  return((1/(n-1))*sum)
}

# END OF FILE