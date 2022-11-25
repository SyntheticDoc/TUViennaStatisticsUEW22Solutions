# Function repository for problem 2a

get_probability_for_cars_within_span <- function(min_val, max_val, lambda, iterations) {
  cat("Starting parking lot simulation with", iterations, "iterations:\n")
  
  total_cars <- rpois(iterations, lambda)
  average <- sum(total_cars) / iterations
  within_span <- 0
  
  for(c in total_cars) {
    if(c >= min_val && c <= max_val) {
      within_span <- within_span + 1
    }
  }
  
  cat("  Average number of cars from all iterations:", average, "\n")
  cat("  Probability for number of cars to be between ")
  cat(min_val, "and ")
  cat(max_val)
  cat(":", within_span / iterations)
}


# END OF FILE