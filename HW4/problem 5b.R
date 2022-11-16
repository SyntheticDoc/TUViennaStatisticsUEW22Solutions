# Function repository for problem 5

# Define Euler's number
e <- exp(1)
equality_tolerance <- 1/1000000

get_random_X_table <- function(k, lambda, count) {
  input_vec <- runif(count)
  output_vec_random_X <- c()
  output_vec_control <- c()
  correctness_vec <- c()
  
  for(i in 1:count) {
    output_vec_random_X <- c(output_vec_random_X, get_inverse_Weibull_value(k, lambda, input_vec[i]))
    output_vec_control <- c(output_vec_control, get_Weibull_value(k, lambda, output_vec_random_X[i]))
    correctness_vec <- c(correctness_vec, abs(input_vec[i] - output_vec_control[i]) <= equality_tolerance)
  }
  
  frame <- data.frame(u_n = input_vec, x_n = output_vec_random_X, control_n = output_vec_control, equality = correctness_vec)
  colnames(frame)[3] = "F_X(x_n)"
  colnames(frame)[4] = "u_n ~= F_X(x_n)?"
  
  cat("Table with", count, "random observations of X ~ Weibull(")
  cat(k)
  cat(", ")
  cat(lambda)
  cat("):\n")
  print(frame)
}

get_Weibull_value <- function(k, lambda, x) {
  if(x < 0) {
    return(0)
  } else {
    return(1 - e^(-(x/lambda)^k))
  }
}

get_inverse_Weibull_value <- function(k, lambda, x) {
  if(x < 0) {
    return(0)
  } else {
    return(lambda * (-log(1 - x))^(1/k))
  }
}