# Function repository for problem Xa
get_matrix <- function(L1_vec, L2_vec, L3_vec) {
  # Sample size for both assumptions
  n <- sum(L1_vec) + sum(L2_vec) + sum(L3_vec)
  
  dat <- matrix(nrow=4, ncol=4)
  dat[1,1:3] <- L1_vec
  dat[2,1:3] <- L2_vec
  dat[3,1:3] <- L3_vec
  
  # Calculate column/row frequencies
  dat[4,1:3] <- colSums(dat[1:3,1:3])
  dat[1:3,4] <- rowSums(dat[1:3,1:3])
  dat[4,4] <- n
  
  dimnames(dat)[[1]] <- c("calculus", "algebra", "probability", "x(.,k)")
  dimnames(dat)[[2]] <- c("Uni A", "Uni B", "Uni C", "x(j,.)")
  
  return(dat)
}

get_e_matrix <- function(dat) {
  # Calc row length
  row_length <- length(dat[1,]) - 1
  # Calc column length
  col_length <- length(dat[,1]) - 1
  
  result <- matrix(nrow=col_length, ncol=row_length)
  
  for(i in 1:col_length) {
    for(j in 1:row_length) {
      result[i, j] <- (dat[col_length+1, j] * dat[i, row_length+1])/dat[col_length+1, row_length+1]
    }
  }
  
  dimnames(result)[[1]] <- dimnames(dat)[[1]][1:col_length]
  dimnames(result)[[2]] <- dimnames(dat)[[2]][1:row_length]
  
  return(result)
}

get_chi_squared <- function(dat, dat_e) {
  chi_s <- 0
  #browser()
  # Calc row length
  row_length <- length(dat[1,])
  # Calc column length
  col_length <- length(dat[,1])
  
  for(i in 1:(col_length-1)) {
    for(j in 1:(row_length-1)) {
      chi_s <- chi_s + (((dat[i, j] - dat_e[i, j])^2)/dat_e[i, j])
    }
  }
  
  return(chi_s)
}

get_matrix_test <- function(L1_vec, L2_vec) {
  # Sample size for both assumptions
  n <- sum(L1_vec) + sum(L2_vec)
  
  dat <- matrix(nrow=3, ncol=5)
  dat[1,1:4] <- L1_vec
  dat[2,1:4] <- L2_vec
  
  # Calculate column/row frequencies
  dat[3,1:4] <- colSums(dat[1:2,1:4])
  dat[1:2,5] <- rowSums(dat[1:2,1:4])
  dat[3,5] <- n
  
  dimnames(dat)[[1]] <- c("hard", "soft", "x(.,k)")
  dimnames(dat)[[2]] <- c("red", "orange", "green", "blue", "x(j,.)")
  
  return(dat)
}

# END OF FILE