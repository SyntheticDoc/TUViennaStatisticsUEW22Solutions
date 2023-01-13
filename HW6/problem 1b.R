# Function repository for problem 1a

# Simple algorithm to get arbitrary unique p-quantiles from sample data
get_quantile <- function(dat, quantile, suppress_console_output = FALSE) {
  quant_pos <- get_quant_pos(dat, quantile)
  
  if(is_whole_number(quant_pos)) {
    res <- (dat[quant_pos] + dat[quant_pos + 1]) / 2
    if(!suppress_console_output) {
      cat("\tUnique", number_to_string(quantile*100))
      cat("%-quantile:", number_to_string(res), "\n")
      cat("\tSince the position of the quantile is a whole number, all real values in ")
      cat("the following interval are also", number_to_string(quantile*100))
      cat("%-quantiles: [")
      cat(dat[quant_pos])
      cat(", ")
      cat(dat[quant_pos + 1])
      cat("]\n")
    }
  } else {
    res <- dat[ceiling(quant_pos)]
    if(!suppress_console_output) {
      cat("\tSince the position of the quantile is not a whole number, we round it up to", ceiling(quant_pos), "and ")
      cat("get as result:\n\t")
      cat(number_to_string(quantile*100))
      cat("%-quantile:", number_to_string(res), "\n")
    }
  }
  
  return(res)
}

number_to_string <- function(x) {
  if(is_whole_number(x)) {
    return(x)
  } else {
    return(sprintf("%.2f", x))
  }
}

get_quant_pos <- function(dat, quantile) {
  return(length(dat)*quantile)
}

is_whole_number <- function(x) {
  if(floor(x) == ceiling(x)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# END OF FILE