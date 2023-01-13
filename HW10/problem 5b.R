# Function repository for problem 5a

do_run <- function(iterations, n, p, alpha) {
  covering_cis <- 0
  h_vec <- vector("numeric" , iterations)
  
  cat(sprintf("Starting simulation with %d iterations, n = %d, p = %.2f, alpha = %.2f...\n", 
      iterations, n, p, alpha))
  
  for(i in 1:iterations) {
    y <- rbinom(n, 1, p)
    h <- length(y[y == 1])/n
    CI <- get_CI(h, n, alpha)
    if(p >= CI[1] & p <= CI[2]) {
      covering_cis <- covering_cis + 1
    }
    
    h_vec[i] <- h
  }
  
  cat(sprintf("\tOut of %d CIs, %d covered p.\n", iterations, covering_cis))
  cat(sprintf("\tThe coverage probability thus is: %.5f", covering_cis/iterations))
  
  result <- data.frame(h_v = h_vec, covprob = covering_cis/iterations)
  
  return(result)
}

get_CI <- function(h, n, alpha) {
  se_h <- get_se_h(h, n)
  I_lower <- h - qnorm(1-alpha/2) * se_h
  I_upper <- h + qnorm(1-alpha/2) * se_h
  return(c(I_lower, I_upper))
}

get_se_h <- function(h, n) {
  return(sqrt((h*(1-h))/n))
}

# END OF FILE