# Source code for coin toss game for problem 2

# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
toss_event_vector_A <- c("a", "A")
toss_event_vector_B <- c("b", "B")
probability_for_head <- 0.5
prob_vector <- c((1 - probability_for_head), probability_for_head)

# Function to start random coin game from external script
do_game <- function() {
  random_coin_toss(toss_event_vector_A, toss_event_vector_B, FALSE)
}

do_game_iter <- function(iterations) {
  B_won <- 0
  cat("Running game with", iterations, "iterations, p(head) =", probability_for_head)
  
  for(i in 1:iterations) {
    if(random_coin_toss(toss_event_vector_A, toss_event_vector_B, TRUE) == 1) {
      B_won <- B_won + 1
    }
  }
  
  cat("\n  Games won by B:", B_won)
  cat("\n  B win probability:", B_won / iterations)
  B_win_prob_calc()
}

# Function to set new head probability from external script
new_head_prob <- function(head_prob) {
  probability_for_head <<- head_prob
  prob_vector <<- c((1 - head_prob), head_prob)
}

# Function for random coin tosses (core game)
random_coin_toss <- function(event_vector_A, event_vector_B, silent) {
  game_won <- FALSE
  is_As_turn <- TRUE
  counter <- 0
  game_vector <- c()
  
  while(!game_won) {
    counter <- counter + 1
    
    if(is_As_turn) {
      coin_toss <- sample(event_vector_A, 1, replace = FALSE, prob_vector)
      game_vector <- c(game_vector, coin_toss)
      
      if(does_coin_toss_win(coin_toss)) {
        game_won = TRUE
        game_winner <- "A"
        winner_num <- 0
      } else {
        is_As_turn = FALSE
      }
    } else {
      coin_toss <- sample(event_vector_B, 1, replace = FALSE, prob_vector)
      game_vector <- c(game_vector, coin_toss)
      
      if(does_coin_toss_win(coin_toss)) {
        game_won = TRUE
        game_winner <- "B"
        winner_num <- 1
      } else {
        is_As_turn = TRUE
      }
    }
  }
  
  if(!silent) {
    cat("The game ended after", counter, "iterations, the Winner was", game_winner, "\n")
    cat("Probability for head was:", prob_vector[2], "\n")
    cat("Game events:\n\t")
  
    for(val in game_vector) {
      cat(val)
    }
  }
  
  return(winner_num)
}

# Function to calculate of a coin toss wins
does_coin_toss_win <- function(coin_toss) {
  if(coin_toss == "A" | coin_toss == "B") {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

B_win_prob_calc <- function() {
  cat("\n  Calculated p for B:", (1 - 1/(2-probability_for_head)))
}