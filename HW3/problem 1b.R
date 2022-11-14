win_vec <- c(0, 1)
tom_p_vec <- c(1 - 0.8, 0.8)
john_p_vec <- c(1 - 0.85, 0.85)

plot_probabilities <- function(player) {
  if(player == "Tom") {
    p_vec = tom_p_vec
  } else if(player == "John") {
    p_vec = john_p_vec
  } else {
    stop("ERROR: Wrong name, could not generate plot for \"", player, "\"")
  }
  
  plot(dbinom(0:10, 10, p_vec[2]), main = paste(player, "victory probabilities"), type="b", xlab="No. of successes", ylab="Probability", xlim=c(0, 10), xaxp=c(0, 10, 10))
  #lines(dbinom(0:10, 10, p_vec[2]), col = "gray")
}

do_game <- function(iterations) {
  cat("Starting simulation with", iterations, "iterations:\n")
  tom_victories <- 0
  john_victories <- 0
  
  for(i in 1:iterations) {
    tom_result <- get_wins(tom_p_vec)
    john_result <- get_wins(john_p_vec)
    
    if(tom_result > john_result) {
      tom_victories <- tom_victories + 1
    } else if(john_result > tom_result) {
      john_victories <- john_victories + 1
    }
  }
  
  game_draws <- iterations - tom_victories - john_victories
  
  cat("  Tom victories:", tom_victories, "\n")
  cat("  John victories:", john_victories, "\n")
  cat("  Game draws:", game_draws, "\n")
  cat("  Tom victory probability:", tom_victories / iterations, "\n")
  cat("  John victory probability:", john_victories / iterations, "\n")
  cat("  Game draw probability:", game_draws / iterations, "\n")
}

get_wins <- function(p_vec) {
  counter <- 0
  
  for(i in 1:10) {
    if(sample(win_vec, 1, replace = TRUE, p_vec) == 1) {
      counter <- counter + 1
    }
  }
  
  return(counter)
}

get_n_successes_probability <- function(iterations, n) {
  cat("Starting simulation with", iterations, "iterations:\n")
  tom_victories <- 0
  john_victories <- 0
  
  for(i in 1:iterations) {
    tom_result <- get_wins(tom_p_vec)
    john_result <- get_wins(john_p_vec)
    
    if(tom_result == n) {
      tom_victories <- tom_victories + 1
    }
    
    if(john_result == n) {
      john_victories <- john_victories + 1
    }
  }
  
  cat("  Tom victories with", n, "throws:", tom_victories, "\n")
  cat("  John victories with", n, "throws:", john_victories, "\n")
  cat("  Tom victory probability for", n, "throws:", tom_victories / iterations, "\n")
  cat("  John victory probability", n, "throws:", john_victories / iterations, "\n")
}