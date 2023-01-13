# Function repository for problem 3

source("HW8_helper.R")

draw_hist <- function(dat, title, mu_0) {
  col_density <- "Red"
  col_mu_marker <- "Blue"
  col_mean_marker <- "Blue"
  col_sem <- "darkmagenta"
  
  S_hist <- calc_SEM(dat)
  
  hist(dat, breaks = 30, main = title, sub = sprintf("SEM = %.3f, mean ~= %.0f", S_hist, mean(dat)),
       las = 1, freq = FALSE, xlab = "Distance (in m)", xlim = c(0, 1200))
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray", lwd = 1)
  
  lines(density(dat), col = col_density, lwd = 2)
  
  legend("topright", legend = "Density of sample data", col = col_density, lwd = 2, lty = 1)
  abline(v = mu_0, col = col_mu_marker, lty = 3, lwd = 3)
  abline(v = mean(dat), col = col_mean_marker, lty = 2, lwd = 3)
  arrows(mean(dat) - S_hist, 0.001, mean(dat) + S_hist, 0.001, angle = 90, code = 3, 
         col = col_sem, lwd = 3, length = 0.1)
  text(mu_0 - 20, 0.00053, labels = "µ0", col = col_mu_marker, cex = 1.3)
  text(mean(dat) + 55, 0.00053, labels = "µ (mean)", col = col_mean_marker, cex = 1.3)
  text(mean(dat) + 35, 0.0013, labels = "SEM", col = col_sem, cex = 1.3)
}