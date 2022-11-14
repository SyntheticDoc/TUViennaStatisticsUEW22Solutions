# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
urnVec <- c("r", "r", "r", "r", "r", "r", "r", "r", "b", "b")
red_ball_prob_vec <- c(8/10, 7/9, 6/8, 5/7, 4/6, 3/5, 2/4, 1/3, 0, 0)
string_divider <- "-----------------------------------------------"

do_game <- function(iterations) {
  cat(string_divider, "\nStart game with", iterations, "iterations for each run\n\n")
  
  for (ballNum in 1:10) {
    cat("Balls drawn:", ballNum, "\n")
    draws_with_min_one_black <- 0
    
    for(i in 1:iterations) {
      if(do_run(ballNum)) {
        draws_with_min_one_black <- draws_with_min_one_black + 1
      }
    }
    
    prob <- draws_with_min_one_black / iterations
    prob_calc <- get_probability(ballNum)
    difference_in_percent <- get_difference_in_percent(prob, prob_calc)
    cat("  Draws with at least one black ball:", draws_with_min_one_black, "\n")
    cat("  Probability for at least one black ball:", prob, "\n")
    cat("  Probability calculated:", prob_calc, "\n")
    cat("  Difference in percent:", sprintf("%1.5f%%", difference_in_percent), "\n\n")
  } 
  
  cat("Game finished.\n", string_divider, "\n\n")
}

do_run <- function(ballNum) {
  if("b" %in% sample(urnVec, ballNum, replace = FALSE)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

get_probability <- function(ballNum) {
  product <- 1
  
  for(i in 1:ballNum) {
    product <- product * red_ball_prob_vec[i]
  }
  
  return(1 - product)
}

get_difference_in_percent <- function(val1, val2) {
  return((abs(val1 - val2) / ((val1 + val2) / 2))*100)
}