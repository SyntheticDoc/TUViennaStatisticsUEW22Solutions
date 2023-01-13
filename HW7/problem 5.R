# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(5, 7)
cat("The problem: Law of large numbers\n")
cat("Visualize the law of the large numbers assuming exponential distributed random variables. ")
cat("Let X_1, X_2, ... be i.i.d. random variables, with X1 ~ exp(lambda). ")
cat("For m = 1, 2, ... the mean of the first m random variables is given as\n\n")
cat("\tX_bar_m = 1/m * sum_from_i=1_to_m_of(X_i)\t[with m as natural number]\n\n")
cat("Further, for n as a natural number a sequence of means is given as X_bar_1, X_bar_2, ..., X_bar_n. ")
cat("Assume lambda = 0.5 and n = 200 and plot 20 realized sequences of means in one graph. ")
cat("Mark the expectation of X_1. Comment on the obtained result.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION\n")
cat("See the generated plot for the example graph.\n\n")

lambda <- 0.5
X1_expectation <- 1/lambda
n <- 200
seq_num <- 20
seq_matrix <- matrix(nrow = n, ncol = seq_num)
col_exp <- "Red"
col_mean <- "Blue"
lwd_exp <- 3
lwd_mean <- 3

get_X_bar_m <- function(x_vec) {
  sum <- 0
  
  for(v in x_vec) {
    sum <- sum + v
  }
  
  return(sum/length(x_vec))
}

get_mean_sequences <- function(sequence) {
  result <- c()
  
  if(n > length(sequence)) {
    stop("ERROR in get_mean_sequences: n was larger then the length of the sequence!")
  }
  
  for(m in 1:n) {
    result <- c(result, get_X_bar_m(sequence[1:m]))
  }
  
  return(result)
}

# Generate 20 realized sequences of means
for(i in 1:seq_num) {
  X_seq <- rexp(n, lambda)
  seq_matrix[,i] <- get_mean_sequences(X_seq)
}

# Prepare plot
plot(NULL, type = "l", main = sprintf("%d realized sequences of means", seq_num), ylab = "Mean", xlab = "x", xlim = c(0, n), ylim = c(min(seq_matrix), max(seq_matrix)))

for(i in 1:seq_num) {
  lines(seq_matrix[,i])
}

lines(rowMeans(seq_matrix), col = col_mean, lwd = lwd_mean)
abline(h = X1_expectation, col = col_exp, lwd = lwd_exp)

legend("topright", legend = c("Expectation of X1", "Mean of means"), col = c(col_exp, col_mean), lwd = c(lwd_exp, lwd_mean))

plot(rowMeans(seq_matrix), col = col_mean, lwd = lwd_mean, type = "l", xlab = "x", ylab = "Mean of means", main = sprintf("Mean of %d means", seq_num))
abline(h = X1_expectation, col = col_exp, lwd = lwd_exp)

cat("Comment:\n\n")
cat("As we can easily see, with increased n, the means of X1, ..., Xn converge towards ")
cat("the expectation of X1, just as the law of large numbers tells us.")

cat("\n\nEND OF SOLUTION")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE