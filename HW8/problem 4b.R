# Function repository for problem 4

draw_hist <- function(dat, plot_ci = FALSE, ci = NULL) {
  col_norm <- "Blue"
  col_density <- "Red"
  
  title <- "Histogram of transfer times for randomly chosen messages"
  hist(dat, breaks = 30, main = title, las = 1, freq = FALSE, xlab = "Transfer time (in s)")
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)
  
  if(plot_ci) {
    abline(v = mean(dat), col = "Blue", lwd = 3, lty = 2)
    arrows(ci[1], 0.3, ci[2], 0.3, angle = 90, code = 3, 
           col = "darkmagenta", lwd = 3, length = 0.1)
    legend("topright", legend = c(sprintf("Mean = %.2f", mean(dat)), "CI"), lwd = c(3, 3), 
           col = c("Blue", "darkmagenta"), lty = c(2, 1))
  } else {
    curve(dnorm(x, mean = mean(dat), sd = sd(dat)), col = col_norm, lwd = 2, add = TRUE)
    lines(density(dat), col = col_density, lwd = 2)
  
    norm_name <- sprintf("N(%.2f, %.2f^2)", mean(dat), sd(dat))
    legend("topright", legend = c(norm_name, "Density of distance"), 
           col = c(col_norm, col_density), lwd = c(2, 2), lty = c(1, 1))
  }
}