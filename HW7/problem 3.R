# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.

source("globalFunctionRepository.R")

file_header(3, 7)
cat("The problem: Test power in the z-test\n")
cat("Let X_1, ... , X_n be i.i.d. random variables with X1 ~ N(mu, sigma^2), and H0 : mu = mu_0.\n\n")
cat("\ta) Compute the test power of the left-sided z-test. Express it through the cdf of the standard ")
cat("normal distribution, depending on mu_0, mu, sigma, n and the significance level alpha.\n")
cat("\tb) Comment on the impact of mu_0, mu, sigma, n and alpha on the test power.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("[Test power: 1 - beta <=> \"Chance of positive detection of an effect IF the effect actually exists\"]\n\n")


cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
grid_color <- "#c0c0c0"
#grid_color <- "#e0e0e0"
mu <- -2
mu_0 <- 0
sigma <- 2
n <- 50
z_a <- 0.2

draw_func2 <- FALSE

calc <- function(mu, mu_0, sigma, n, z_a) {
  return(pnorm(qnorm(z_a) - (((mu - mu_0)/(sigma)) * sqrt(n))))
}

calc3 <- function(mu, mu_0, sigma, n, z_a) {
  return(pnorm(1 - qnorm(1-z_a) - (((mu - mu_0)/(sigma)) * sqrt(n))))
}

calc2 <- function(mu, mu_0, sigma, n, z_a) {
  return(pnorm(qnorm(z_a) + (((mu - mu_0)/(sigma)) * sqrt(n))))
}

g_func <- function(x) {
  calc(x, mu_0, sigma, n, z_a)
}

g_func2 <- function(x) {
  calc2(x, mu_0, sigma, n, z_a)
}

cat("Test Var:\n")
cat("\t~:", calc(-1, 2, sigma, n, z_a), "\n")
cat("\t+:", calc(-1, 2+1, sigma, n, z_a), "\n")
cat("\t-:", calc(-1, 2-1, sigma, n, z_a), "\n")
cat("\n")

cat("Var mu_0:\n")
cat("\t~:", calc(mu, mu_0, sigma, n, z_a), "\n")
cat("\t+:", calc(mu, mu_0+1, sigma, n, z_a), "\n")
cat("\t-:", calc(mu, mu_0-1, sigma, n, z_a), "\n")
cat("\n")

cat("Var mu:\n")
cat("\t~:", calc(mu, mu_0, sigma, n, z_a), "\n")
cat("\t+:", calc(mu+1, mu_0, sigma, n, z_a), "\n")
cat("\t-:", calc(mu-1, mu_0, sigma, n, z_a), "\n")
cat("\n")

cat("Var sigma:\n")
cat("\t~:", calc(mu, mu_0, sigma, n, z_a), "\n")
cat("\t+:", calc(mu, mu_0, sigma+0.5, n, z_a), "\n")
cat("\t-:", calc(mu, mu_0, sigma-0.5, n, z_a), "\n")
cat("\n")

cat("Var n:\n")
cat("\t~:", calc(mu, mu_0, sigma, n, z_a), "\n")
cat("\t+:", calc(mu, mu_0, sigma, n+10, z_a), "\n")
cat("\t-:", calc(mu, mu_0, sigma, n-10, z_a), "\n")
cat("\n")

cat("Var z_a:\n")
cat("\t~:", calc(mu, mu_0, sigma, n, z_a), "\n")
cat("\t+:", calc(mu, mu_0, sigma, n, z_a+0.02), "\n")
cat("\t-:", calc(mu, mu_0, sigma, n, z_a-0.02), "\n")

x_seq <- seq(-3, 3, by = 0.01)

mu_0_mod <- 1
sigma_mod <- 1.5
n_mod <- 40
z_a_mod <- 0.15

draw_g <- function(mu, mu_0, sigma, n, z_a, mod) {
  if(mod == 1) {
    leg_text <- c(sprintf("µ0 - %.2f", mu_0_mod), sprintf("µ0 + %.2f", mu_0_mod))
  
    plot(x_seq, g_func(x_seq), type = "l", lwd = 2, main = "Plot of g(µ)", ylab = "g(µ)", xlab = "µ")
    grid(nx = NULL, ny = NULL, col = grid_color, lty = 3, lwd = 1)
    abline(v = mu_0, col = "Blue")
    lines(c(-4, mu_0), c(g_func(mu_0), g_func(mu_0)), col = "Red", lty = 2)
    text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
    text(-1.5, z_a + 0.03, label = "alpha", col = "Red")
    
    lines(x_seq, calc(x_seq, mu_0 - mu_0_mod, sigma, n, z_a), col = "Green", lwd = 2)
    lines(x_seq, calc(x_seq, mu_0 + mu_0_mod, sigma, n, z_a), col = "Orange", lwd = 2)
  } else if(mod == 2) {
    leg_text <- c(sprintf("sigma - %.2f", sigma_mod), sprintf("sigma + %.2f", sigma_mod))
    
    plot(x_seq, g_func(x_seq), type = "l", lwd = 2, main = "Plot of g(µ)", ylab = "g(µ)", xlab = "µ")
    grid(nx = NULL, ny = NULL, col = grid_color, lty = 3, lwd = 1)
    abline(v = mu_0, col = "Blue")
    lines(c(-4, mu_0), c(g_func(mu_0), g_func(mu_0)), col = "Red", lty = 2)
    text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
    text(-1.5, z_a + 0.03, label = "alpha", col = "Red")
    
    lines(x_seq, calc(x_seq, mu_0, sigma - sigma_mod, n, z_a), col = "Green", lwd = 2)
    lines(x_seq, calc(x_seq, mu_0, sigma + sigma_mod, n, z_a), col = "Orange", lwd = 2)
  } else if(mod == 3) {
    leg_text <- c(sprintf("n - %d", n_mod), sprintf("n + %d", n_mod))
    
    plot(x_seq, g_func(x_seq), type = "l", lwd = 2, main = "Plot of g(µ)", ylab = "g(µ)", xlab = "µ")
    grid(nx = NULL, ny = NULL, col = grid_color, lty = 3, lwd = 1)
    abline(v = mu_0, col = "Blue")
    lines(c(-4, mu_0), c(g_func(mu_0), g_func(mu_0)), col = "Red", lty = 2)
    text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
    text(-1.5, z_a + 0.03, label = "alpha", col = "Red")
    
    lines(x_seq, calc(x_seq, mu_0, sigma, n - n_mod, z_a), col = "Green", lwd = 2)
    lines(x_seq, calc(x_seq, mu_0, sigma, n + n_mod, z_a), col = "Orange", lwd = 2)
  } else if(mod == 4) {
    leg_text <- c(sprintf("z_a - %.3f", z_a_mod), sprintf("z_a + %.3f", z_a_mod))
    
    plot(x_seq, g_func(x_seq), type = "l", lwd = 2, main = "Plot of g(µ)", ylab = "g(µ)", xlab = "µ")
    grid(nx = NULL, ny = NULL, col = grid_color, lty = 3, lwd = 1)
    abline(v = mu_0, col = "Blue")
    lines(c(-4, mu_0), c(g_func(mu_0), g_func(mu_0)), col = "Red", lty = 2)
    text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
    text(-1.5, z_a + 0.03, label = "alpha", col = "Red")
    
    lines(x_seq, calc(x_seq, mu_0, sigma, n, z_a - z_a_mod), col = "Green", lwd = 2)
    lines(x_seq, calc(x_seq, mu_0, sigma, n, z_a + z_a_mod), col = "Orange", lwd = 2)
  }
  
  legend("topright", col = c("Green", "Orange"), lwd = c(2, 2), legend = leg_text)
}

plot(x_seq, g_func(x_seq), type = "l", lwd = 2, main = "Plot of g(µ)", ylab = "g(µ)", xlab = "µ")
grid(nx = NULL, ny = NULL, col = grid_color, lty = 3)
abline(v = mu_0, col = "Blue")
lines(c(-4, mu_0), c(g_func(mu_0), g_func(mu_0)), col = "Red", lty = 2)
text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
text(-1.5, z_a + 0.03, label = "alpha", col = "Red")

draw_g(mu, mu_0, sigma, n, z_a, 1)
draw_g(mu, mu_0, sigma, n, z_a, 2)
draw_g(mu, mu_0, sigma, n, z_a, 3)
draw_g(mu, mu_0, sigma, n, z_a, 4)

if(draw_func2) {
  plot(x_seq, g_func2(x_seq), type = "l", lwd = 2, main = "Plot of g2(µ)", ylab = "g2(µ)", xlab = "µ")
  abline(v = mu_0, col = "Blue")
  lines(c(-4, mu_0), c(g_func2(mu_0), g_func2(mu_0)), col = "Red", lty = 2)
  text(mu_0 + 0.1, 0.5, label = "µ0", col = "Blue")
  text(-1.5, z_a + 0.03, label = "alpha", col = "Red")
}

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE