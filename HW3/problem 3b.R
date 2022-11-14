get_phi_from_table <- function(z, z2) {
  Z = z + z2
  return(pnorm(Z))
}

get_inverse_phi_from_table <- function(p) {
  Z <- 3.4
  
  while(pnorm(Z) > p) {
    Z <- Z - 0.01
  }
  
  return(Z)
}

get_milage_for_percentage <- function(iterations, mean_tires, sd_tires, percentage) {
  cat("Starting simulation with a sample size of", iterations, "\n")
  
  sorted_tires <- sort(get_random_tires(mean_tires, sd_tires, iterations))
  index_to_get <- iterations * percentage
  cat("  Resulting milage:", sorted_tires[index_to_get], "\n")
  return(sorted_tires[index_to_get])
}

get_interval_probability <- function(iterations, mean_tires, sd_tires, min_miles, max_miles) {
  random_tires <- get_random_tires(mean_tires, sd_tires, iterations)
  counter <- 0
  
  cat("Starting simulation with a sample size of", iterations, "\n")
  
  for(i in 1:iterations) {
    if(random_tires[i] >= min_miles & random_tires[i] <= max_miles) {
      counter <- counter + 1
    }
  }
  
  cat("  Probability for tires to be in the interval (", min_miles, ",", max_miles, "):", counter / iterations, "\n")
}

get_random_tires <- function(mean_tires, sd_tires, sample_size) {
  return(rnorm(sample_size, mean = mean_tires, sd = sd_tires))
}