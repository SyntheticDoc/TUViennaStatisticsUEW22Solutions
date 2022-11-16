# Simulation functions for problem 2

simulate_shop_week <- function(mean_coffee, sd_coffee, min_coffee_limit, iterations) {
  cat("Starting weekly coffee sales simulation with", iterations, "iterations...\n")
  weeks_over_min_limit <- 0
  
  for(i in 1:iterations) {
    if(get_week_sample(mean_coffee, sd_coffee) >= min_coffee_limit) {
      weeks_over_min_limit <- weeks_over_min_limit + 1
    }
  }
  
  cat("Results:\n")
  cat("  Weeks with sales greater than or equal to ")
  cat(min_coffee_limit)
  cat(":", weeks_over_min_limit, "\n")
  cat("  Probability for weeks over limit:", weeks_over_min_limit / iterations)
}

simulate_shop_day_profit <- function(mean_coffee, sd_coffee, mean_donut, sd_donut, coffee_profit, donut_profit, min_total_profit, iterations) {
  cat("Starting daily sales profit simulation with", iterations, "iterations...\n")
  days_over_min_limit <- 0
  
  for(i in 1:iterations) {
    daily_coffee_profit <- get_day_sample(mean_coffee, sd_coffee) * coffee_profit
    daily_donut_profit <- get_day_sample(mean_donut, sd_donut) * donut_profit
    
    if((daily_coffee_profit + daily_donut_profit) > min_total_profit) {
      days_over_min_limit <- days_over_min_limit + 1
    }
  }
  
  cat("Results:\n")
  cat("  Days with profit greater than  ")
  cat(min_total_profit)
  cat(":", days_over_min_limit, "\n")
  cat("  Probability for weeks over limit:", days_over_min_limit / iterations)
}

get_week_sample <- function(mean, sd) {
  return(sum(rnorm(6, mean, sd)))
}

get_day_sample <- function(mean, sd) {
  return(rnorm(1, mean, sd))
}