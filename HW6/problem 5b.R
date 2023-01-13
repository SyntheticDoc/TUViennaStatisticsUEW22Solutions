# Function repository for problem 5a

# USAGE: Save this file for example as "problem 5b.R". Than you can import this
# file into any other R-Source with source("problem 5b.R"). When imported, you can
# use start_random_compared_run() and start_random_run() directly in your file.
#
# FUNCTION PARAMETERS:
#   min: For generating a random sample vector, minimum value
#   max: For generating a random sample vector, maximum value
#   sample_size: For generating a random sample vector, number of elements
#   dat: If you don't want to generate a random sample vector, you can supply your
#        own custom sample vector here. If dat is not NULL/empty, min, max and 
#        sample_size are ignored
#   squared_mode: For single, non-compared runs. TRUE calculates squared distances,
#                 FALSE calculates absolute distances
#
# RETURN VALUE:
#   In both cases a list with the following components:
#   start_random_compared_run()
#      $data: The sample vector used
#      $data_summary: Calculated statistical data about the sample vector
#      $opt_pos_abs: Optimal position for absolute distances
#      $opt_dist_abs: Absolute distance sum for optimal absolute position
#      $opt_pos_squared: Optimal position for squared distances
#      $opt_dist_squared: Squared distance sum for optimal squared position
#
#   start_random_run()
#      $data: The sample vector used
#      $data_summary: Calculated statistical data about the sample vector
#      $squared_mode: Boolean value, FALSE if absolute distances were calculated,
#                     TRUE if squared distances were calculated
#      $opt_pos: Optimal position calculated
#      $opt_dist: Distance sum for optimal position
#
# WARNING:
# This algorithm calculates optimal positions only in integer steps and therefore
# only gets approximate values for the true optimal positions!
#
# USAGE EXAMPLES (copy this in a new source file to test):
# source("problem 5b.R")
# dat <- c(1, 1, 1, 30)
# d1 <- start_random_compared_run(0, 0, 0, dat)
# cat("\n\n")
# d2 <- start_random_compared_run(-30, 30, 10)
# cat("\n\n")
# d3 <- start_random_run(-10, 300, 75, TRUE, dat)
# cat("\n\n")
# d4 <- start_random_run(-10, 300, 75, TRUE)

# The following boolean variable controls if the results of each search step are
# printed to the console (debug = TRUE) or not (debug = FALSE).
debug <- FALSE

plot_data <- function(d) {
  sub_string <- "Data used:"
  
  for(dat_point in d$data) {
    dat_string <- paste(" ", dat_point)
    sub_string <- paste(sub_string, dat_point)
  }
  
  title <- sprintf("Plot of random positions of households (n = %d)", length(d$data))
  
  plot(d$data, y = rep(0, length(d$data)), ylim = c(-1, 1), las = 1, 
       main = title, type = "p", ylab = "y", 
       xlab = "Household positions", lwd = 3, sub = sub_string, cex.sub = 0.5)
  abline(v = median(d$data), col = "lightblue", lwd = 2)
  abline(v = d$opt_pos_abs, col = "blue", lwd = 2)
  abline(v = mean(d$data), col = "orange", lwd = 2)
  abline(v = d$opt_pos_squared, col = "red", lwd = 2)
  l1 <- paste("Optimal abs position =", d$opt_pos_abs)
  l2 <- paste("Median =", sprintf("%.2f", median(d$data)))
  l3 <- paste("Optimal squared position =", d$opt_pos_squared)
  l4 <- paste("Mean =", sprintf("%.2f", mean(d$data)))
  legend("topright", legend = c(l1, l2, l3, l4), 
         col = c("blue", "lightblue", "red", "orange"), lwd = c(2, 2, 2, 2))
}

start_random_compared_run <- function(min, max, sample_size, dat = NULL) {
  if(is.null(dat)) {
    dat <- get_pos_vector(min, max, sample_size)
  }
  
  dat <- sort(dat)
  
  dat_summary <- get_stat_summary(dat)
  cat("Algorithm initialized\n")
  cat("  Generated data:", dat, "\n\n")
  
  cat("Data summary:\n")
  cat(dat_summary$sum_header, "\n")
  cat(dat_summary$sum_data, "\n")
  cat(dat_summary$var, "\n")
  cat(dat_summary$sd, "\n\n")
  
  res1 <- seek_min_distance_pos(dat, squared_mode = FALSE)
  res2 <- seek_min_distance_pos(dat, squared_mode = TRUE)
  
  cat("Results for optimal postbox position:\n")
  cat("  Absolute, optimal position:", res1$min_pos)
  cat(", optimal distance:", res1$min_dist, "\n")
  cat("  Squared, optimal position:", res2$min_pos)
  cat(", optimal distance:", res2$min_dist)
  cat(" (sqrt(optimal distance)):", sqrt(res2$min_dist), "\n")
  
  return(list(data = dat, data_summary = dat_summary, opt_pos_abs = res1$min_pos, opt_dist_abs = res1$min_dist,
              opt_pos_squared = res2$min_pos, opt_dist_squared = res2$min_dist))
}

start_random_run <- function(min, max, sample_size, squared_mode = FALSE, dat = NULL) {
  if(is.null(dat)) {
    dat <- get_pos_vector(min, max, sample_size)
  }
  
  dat <- sort(dat)
  
  dat_summary <- get_stat_summary(dat)
  cat("Algorithm initialized\n")
  cat("  Generated data:", dat, "\n\n")
  
  cat("Data summary:\n")
  cat(dat_summary$sum_header, "\n")
  cat(dat_summary$sum_data, "\n")
  cat(dat_summary$var, "\n")
  cat(dat_summary$sd, "\n\n")
  
  res <- seek_min_distance_pos(dat, squared_mode)
  
  cat("Result for optimal postbox position:", res$min_pos)
  
  if(squared_mode) {
    cat(" (Sum of squared distances:", res$min_dist)
    cat(")")
  } else {
    cat(" (Sum of absolute distances:", res$min_dist)
    cat(")")
  }
  
  return(list(data = dat, data_summary = dat_summary, squared_mode = squared_mode,
              opt_pos = res$min_pos, opt_dist = res$min_dist))
}

seek_min_distance_pos <- function(dat, squared_mode) {
  p <- min(dat)
  cur_dist <- get_distances_to_point(dat, p, squared_mode)
  min_pos <- NULL
  min_dist <- NULL
  
  cat("Search algorithm started, mode: ")
  
  if(squared_mode) {
    cat("squared distances\n")
  } else {
    cat("absolute distances\n")
  }
  
  if(debug) {
    cat("\n")
  }
  
  repeat {
    cur_dist <- get_distances_to_point(dat, p, squared_mode)
    
    if(debug) {
      cat("Seeking min distance... current min_dist:", min_dist)
      cat(", current min_pos:", min_pos, "\n")
      cat("   current p:", p)
      cat(", current distance:", cur_dist, "\n")
    }
    
    if(is.null(min_pos)) {
      min_pos <- p
      min_dist <- cur_dist
    }
    
    if(cur_dist < min_dist) {
      min_pos <- p
      min_dist <- cur_dist
      
      if(debug) {
        cat("  cur_dist < min_dist! Updating min_dist and min_pos...\n")
      }
    }
    
    if(p < max(dat)) {
      p <- p + 1
    } else {
      break;
    }
  }
  
  cat("Search successfully finished!\n\n")
  
  return(list(min_dist = min_dist, min_pos = min_pos))
}

get_distances_to_point <- function(dat, p, squared_mode) {
  if(squared_mode) {
    return(get_squared_distances_to_point(dat, p))
  } else {
    return(get_absolute_distances_to_point(dat, p))
  }
}

get_absolute_distances_to_point <- function(dat, p) {
  sum <- 0
  
  for(i in 1:length(dat)) {
    sum <- sum + abs(dat[i] - p)
  }
  
  return(sum)
}

get_squared_distances_to_point <- function(dat, p) {
  sum <- 0
  
  for(i in 1:length(dat)) {
    sum <- sum + (dat[i] - p)^2
  }
  
  return(sum)
}

get_stat_summary <- function(dat) {
  var_string <- sprintf("Variance: %.2f", var(dat))
  sd_string <- sprintf("SD: %.2f", sd(dat))
  dat_summary <- capture.output(summary(dat))
  summary_list <- list(sum_header = dat_summary[1], sum_data = dat_summary[2], var = var_string, sd = sd_string)
  return(summary_list)
}

get_pos_vector <- function(min, max, sample_size) {
  return(sample(min:max, sample_size, replace = TRUE))
}

# END OF FILE