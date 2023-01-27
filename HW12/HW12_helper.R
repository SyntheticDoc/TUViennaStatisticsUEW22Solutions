# Function repository for homework 12

load_evaluation_data <- function() {
  cat("Trying to load \"Evaluation.Rdata\"...\n")
  
  dat_name <- load("Evaluation.Rdata")
  
  cat("Data successfully loaded into", dat_name, "\n")
  
  column_names <- attributes(Evaluation)$names
  
  cat("Data contains the columns:\n")
  
  for(s in column_names) {
    cat("\t", s, "\n")
  }
  
  return(Evaluation)
}

get_empirical_correlation <- function(x, y, n) {
  x_bar <- mean(x)
  y_bar <- mean(y)
  s_x <- sd(x)
  s_y <- sd(y)
  sum <- 0
  
  for(i in 1:n) {
    sum <- sum + ((x[i] - x_bar) * (y[i] - y_bar))
  }
  
  r <- ((1/(n - 1)) * sum) / (s_x * s_y)
  
  # Check result validity
  if(r != cor(x, y)) {
    error_msg <- sprintf("Error in get_empirical_correlation(): r is not equal 
                         to cor(x, y): r = %.5f, cor(x, y) = %.5f", r, cor(x, y))
    stop(error_msg)
  }
  
  return(r)
}

get_least_square_estimators <- function(x, y) {
  x_bar <- mean(x)
  y_bar <- mean(y)
  s_x <- sd(x)
  s_y <- sd(y)
  r <- get_empirical_correlation(x, y, length(x))
  b1 <- r * (s_y/s_x)
  b0 <- y_bar - b1 * x_bar
  
  return(list(B0=b0, B1=b1))
}

get_Sr_squared <- function(x, y, B0, B1) {
  n <- length(x)
  sum <- 0
  
  for(i in 1:n) {
    sum <- sum + ((y[i] - (B0 + B1 * x[i]))^2)
  }
  
  return((1/(n - 2)) * sum)
}

# END OF FILE