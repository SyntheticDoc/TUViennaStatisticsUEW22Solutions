# Function repository for problem 2a

get_probability_for_coin_heads <- function(min_val, max_val, p_head, trials, iterations) {
  cat("Starting coin throw simulation with", iterations, "iterations:\n")
  
  total_heads <- rbinom(iterations, trials, p_head)
  average <- sum(total_heads) / iterations
  within_span <- 0
  
  for(h in total_heads) {
    if(h >= min_val && h <= max_val) {
      within_span <- within_span + 1
    }
  }
  
  cat("  Average number of heads from all iterations:", average, "\n")
  cat("  Probability for number of heads to be between ")
  cat(min_val, "and ")
  cat(max_val)
  cat(":", within_span / iterations)
}


# END OF FILE