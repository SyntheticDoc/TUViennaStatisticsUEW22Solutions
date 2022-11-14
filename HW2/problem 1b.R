die <- c(1, 2, 3, 4, 5, 6)

roll_die <- function(roll_times, iterations) {
  count_greater_than_six <- 0
  
  cat("Rolling die", roll_times, "times for", iterations, "iterations:\n")
  
  for(i in 1:iterations) {
    die_result <- 0
    
    for(r in 1:roll_times) {
      die_result <- die_result + sample(die, 1)
    }
    
    if(die_result > 6) {
      count_greater_than_six <- count_greater_than_six + 1
    }
  }
  
  cat("  Number of times result was greater than 6:", count_greater_than_six, "\n")
  cat("  Probability:", count_greater_than_six / iterations, "\n\n")
}

get_combinations_greater_six <- function(dice_num) {
  cat("Valid combinations with", dice_num, "dice with a sum greater than 6:\n")
  
  if(dice_num < 2) {
    cat("  []\n")
    cat("  Valid combinations: 0\n\n")
  } else if(dice_num == 2) {
    num_of_combinations <- 0
    
    for(d1 in 1:6) {
      for(d2 in 1:6) {
        if(d1 + d2 > 6) {
          v <- c(d1, d2)
          cat("[")
          cat(v)
          cat("], ")
          num_of_combinations <- num_of_combinations + 1
        }
      }
    }
    cat("\n  Valid combinations:", num_of_combinations, "\n")
    cat("  Probability:", num_of_combinations / (6*6), "\n\n")
  } else if(dice_num == 3) {
    num_of_combinations_2d <- 0
    num_of_combinations_3d <- 0
    
    for(d1 in 1:6) {
      for(d2 in 1:6) {
        if(d1 + d2 > 6) {
          v <- c(d1, d2)
          #cat("[")
          #cat(v)
          #cat("], ")
          num_of_combinations_2d <- num_of_combinations_2d + 1
          next
        }
        
        for(d3 in 1:6) {
          if(d1 + d2 + d3 > 6) {
            v <- c(d1, d2, d3)
            cat("[")
            cat(v)
            cat("], ")
            num_of_combinations_3d <- num_of_combinations_3d + 1
          }
        }
      }
    }
    comb_sum <- num_of_combinations_2d + num_of_combinations_3d
    
    cat("\n  Valid combinations with 2 dice:", num_of_combinations_2d, "\n")
    cat("  Valid combinations with 3 dice:", num_of_combinations_3d, "\n")
    cat("  Total valid combinations:", comb_sum, "\n")
    cat("  Probability for 2 dice:", num_of_combinations_2d / (6*6), "\n")
    cat("  Probability for 3 dice:", num_of_combinations_3d / (6*6*6), "\n")
    cat("  Total probability:", (comb_sum + (21*5)) / ((6*6*6)), "\n\n")
  }
}