# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
box1 <- c()
box2 <- c()
debug <- FALSE

do_test <- function() {
  do_game_problem1(10)
}

do_game_problem2 <- function(iterations) {
  cat("Starting simulation of problem b with", iterations, "iterations:\n")
  generate_start_boxes()
  box_is_wb_or_bw <- 0
  black_balls_received <- 0
  
  for(i in 1:iterations) {
    b1 <- box1
    b2 <- box2
    
    taken_from_b1 <- sample(b1, 2, replace = FALSE)
    b2 <- c(b2, taken_from_b1)
    
    if(sample(b2, 1, replace = FALSE)[1] == 1) {
      black_balls_received = black_balls_received + 1
      if((taken_from_b1[1] == 0 & taken_from_b1[2] == 1) | (taken_from_b1[1] == 1 & taken_from_b1[2] == 0)) {
        box_is_wb_or_bw <- box_is_wb_or_bw + 1
      }
    }
    
    if(debug) {
      cat("box1:\t", box1, "\n")
      cat("box2:\t", box2, "\n")
      cat("b1:\t", b1, "\n")
      cat("b2:\t", b2, "\n")
    }
  }
  
  box_prob <- box_is_wb_or_bw / iterations
  box_prob_total <- box_prob * (1 / (black_balls_received / iterations))
  
  cat("box_is_wb_or_bw:", box_is_wb_or_bw, "\n")
  cat("Probability for box to have been wb or bw on black ball:", box_prob, "\n")
  cat("Probability for box to have been wb or bw regardless of ball:", box_prob_total, "\n\n")
}

do_game_problem1 <- function(iterations) {
  cat("Starting simulation of problem a with", iterations, "iterations:\n")
  generate_start_boxes()
  white_balls_received <- 0
  
  for(i in 1:iterations) {
    b1 <- box1
    b2 <- box2
    
    taken_from_b1 <- sample(b1, 2, replace = FALSE)
    b2 <- c(b2, taken_from_b1)
    
    if(sample(b2, 1, replace = FALSE)[1] == 0) {
      white_balls_received <- white_balls_received + 1
    }
    
    if(debug) {
      cat("box1:\t", box1, "\n")
      cat("box2:\t", box2, "\n")
      cat("b1:\t", b1, "\n")
      cat("b2:\t", b2, "\n")
    }
  }
  
  cat("white_balls_received:", white_balls_received, "\n")
  cat("Probability for white ball:", white_balls_received / iterations, "\n\n")
}

generate_start_boxes <- function() {
  v1 <- c()
  v2 <- c()
  
  for(i in 1:15) {
    v1 <- c(v1, 0)
  }
  
  for(i in 1:12) {
    v1 <- c(v1, 1)
  }
  
  for(i in 1:14) {
    v2 <- c(v2, 0)
  }
  
  for(i in 1:18) {
    v2 <- c(v2, 1)
  }
  
  box1 <<- v1
  box2 <<- v2
}