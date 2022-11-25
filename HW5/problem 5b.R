# Function repository for problem 5a
col_norm <- "red"
col_gamma <- "blue"
col_density <- "chocolate"
lty_density <- 1
lwd_density <- 3
lwd_others <- 2

attach_density_curve_to_histo <- function(x_min, x_max, res, dat, title, withLegend) {
  x <- seq(x_min, x_max, by = res)
  lines(density(dat), col = col_density, lwd = lwd_density, lty = lty_density)
  
  if(withLegend) {
    attach_legend_to_histo(title, col_density, lty_density)
  }
}

attach_legend_to_histo <- function(titles, colors, line_types) {
  legend("topright", legend = titles, col = colors, lty = line_types)
}

attach_curves_to_histo <- function(x_min, x_max, res, dat, mean_norm, sd_norm, draw_density, draw_normal, draw_gamma) {
  l_titles <- c()
  l_colors <- c()
  l_types <- c()
  
  x <- seq(x_min, x_max, by = res)
  
  if(draw_density) {
    attach_density_curve_to_histo(min(x), max(x), res, dat, "Density of samples", FALSE)
    l_titles <- c(l_titles, "Density of samples")
    l_colors <- c(l_colors, col_density)
    l_types <- c(l_types, lty_density)
  }
  
  if(draw_normal) {
    curve(dnorm(x, mean_norm, sd_norm), from = x_min, to = x_max, n = length(x), col = col_norm, type = "l", lwd = lwd_others, add = TRUE)
    l_titles <- c(l_titles, paste("pdf of N(", mean_exp_1, ",", sd_norm^2, ")"))
    l_colors <- c(l_colors, col_norm)
    l_types <- c(l_types, 1)
  }
  
  if(draw_gamma) {
    curve(Gamma_pdf(x), from = x_min, to = x_max, n = length(x), col = col_gamma, type = "l", lwd = lwd_others, add = TRUE)
    #curve(dgamma(x, 2, 2), from = x_min, to = x_max, n = length(x), col = col_gamma, type = "l", lwd = lwd_others, add = TRUE)
    l_titles <- c(l_titles, "pdf of Gamma(2, 2)")
    l_colors <- c(l_colors, col_gamma)
    l_types <- c(l_types, 1)
  }
  
  attach_legend_to_histo(l_titles, l_colors, l_types)
}

get_random_Gamma <- function(sampleSize, min_bound, max_bound) {
  result <- c()
  
  for(i in 1:sampleSize) {
    x <- min_bound - 1
    
    while(x < min_bound | x > max_bound) {
      x <- rgamma(1, 2, 2)
    }
    
    result <- c(result, x)
  }
  
  return(result)
}

Gamma_pdf <- function(x) {
  return(4 * x * exp(-(2*x)))
}

# Define a function to only get values bounded by the bounds of the first histogram
get_positive_rnorm <- function(sampleSize, m, s, min_bound, max_bound) {
  result <- c()
  
  for(i in 1:sampleSize) {
    x <- min_bound - 1
    
    while(x < min_bound | x > max_bound) {
      x <- rnorm(1, m, s)
    }
    
    result <- c(result, x)
  }
  
  return(result)
}

# END OF FILE