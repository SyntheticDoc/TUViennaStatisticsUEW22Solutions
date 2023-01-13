# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(2, 6)
cat("The problem: Boxplot\n")
cat("Two novel randomized algorithms (A and B) are to be compared regarding their running ")
cat("time. Both algorithms were executed n times. The running times (in seconds) are stored in ")
cat("the file algorithms.Rdata.\n\n")

cat("\ta) Set the working directory and load the data using load(). Create a boxplot ")
cat("to compare the running times. Color the boxes and add proper notations (axes ")
cat("notations, title etc.). More info via ?boxplot.\n\n")

cat("\tb) Comment on the following statements/questions only using the graphic\n")
cat("\t\t- The first quartile of the times in A was about?\n")
cat("\t\t- The interquartile range of the times in B is about trice the interquartile range of A.\n")
cat("\t\t- Is n = 100?\n")
cat("\t\t- More than half of the running times in B were faster than 3/4 of the running ")
cat("times in A.\n")
cat("\t\t- At least 50% in A were faster than the 25% slowest in B.\n")
cat("\t\t- At least 60% in A were faster than the 25% slowest in B.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Since this source file can only be executed if the working directory is already ")
cat("set, we can immediately start by loading the data. The data gets loaded into an ")
cat("environment variable with the name \"")
data_name <- load("algorithms.Rdata")
cat(data_name)
cat("\".\n\n")

cat("We can now start to generate the boxplot.")

# Rename the columns of runningtimes to something more aesthetically pleasing than "algoA" and "algoB"
names(runningtimes) <- c("Algorithm A", "Algorithm B")

title <- "Comparison of the sampled running times of two algorithms"
sum_algA <- capture.output(summary(runningtimes$`Algorithm A`))
sum_algB <- capture.output(summary(runningtimes$`Algorithm B`))
l_algA1 <- paste(sprintf("%22s: %s", "Statistics Algorithm A", sum_algA[1]))
l_algA2 <- paste(sprintf("%37s  %s", "", sum_algA[2]))
l_algB1 <- paste(sprintf("%22s: %s", "Statistics Algorithm B", sum_algB[1]))
l_algB2 <- paste(sprintf("%37s  %s", "", sum_algB[2]))
boxplot(runningtimes, main = title, ylab = "Running time in seconds", col = c("lightblue", "lightgreen"), las = 1)
#legend("topleft", legend = c(l_algA1, l_algA2, l_algB1, l_algB2))
grid(nx = NA, ny = NULL, col = "grey", lty = 3)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("We answer each of the questions individually:\n\n")

cat("\t(i) The first quartile of the times in A was about?\n")
cat("We immediately see that the first quartile equals about 20 seconds.\n\n")

cat("\t(ii) The interquartile range of the times in B is about trice the interquartile range of A.\n")
cat("It seems more like the IQR of B being only about twice the IQR of A.\n\n")

cat("\t(iii) Is n = 100?\n")
cat("This question cannot be answered from a boxplot alone.\n\n")

cat("\t(iv) More than half of the running times in B were faster than 3/4 of the running ")
cat("times in A.\n")
cat("Yes, we immediately see that the median of B is lower (= faster) than the ")
cat("first quartile (= lower 25%) of A.\n\n")

cat("\t(v) At least 50% in A were faster than the 25% slowest in B.\n")
cat("Yes, since the median of A is a bit lower than the third quartile (= 75%) of ")
cat("B, which means than 50% of A were faster than at least (100 - 75) = 25% of B.\n\n")

cat("\t(iv) At least 60% in A were faster than the 25% slowest in B.\n")
cat("Unknown, since it cannot be seen in a boxplot where the 60%-quantile of A exactly ")
cat("is.\n\n")

show_proofs <- TRUE

if(show_proofs) {
  A <- runningtimes$`Algorithm A`
  B <- runningtimes$`Algorithm B`
  cat("Summary of Algorithm A:\n")
  cat(sum_algA[1], "\n")
  cat(sum_algA[2], "\n\n")
  cat("Summary of Algorithm B:\n")
  cat(sum_algB[1], "\n")
  cat(sum_algB[2], "\n\n")
  cat("(i) First quartile of A:", quantile(A, 0.25), "\n")
  cat("(ii) IQR of A:", quantile(A, 0.75) - quantile(A, 0.25), "  IQR of B:", quantile(B, 0.75) - quantile(B, 0.25), "\n")
  cat("(iii) Can't be told from boxplot, but true nonetheless. Length of A:", length(A), "   Length of B:", length(B), "\n")
  cat("(iv) Fraction of runs of B faster than 75% of A:", length(B[B < quantile(A, 0.25)]) / length(B), "\n")
  cat("(v & vi) Fraction of runs of A faster than the slowest 25% of B:", length(A[A < quantile(B, 0.75)]) / length(B))
}

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE