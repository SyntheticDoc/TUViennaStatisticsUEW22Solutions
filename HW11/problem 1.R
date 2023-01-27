# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
source("globalFunctionRepository.R")

file_header(1, 11)
cat("The problem: Rolling die, part 1\n")
cat("A d-sided die with colored sides was rolled n times. The outcomes are stored ")
cat("in the file die.Rdata. (Each side appeared at least once.)\n\n")

cat("\ta) What is n? What is d?\n")
cat("\tb) Visualize the relative frequencies in a colored barplot and add the ")
cat("standard error of each frequency.\n")
cat("\tc) Given your graphic, what is your opinion on the assertion: ’the die is fair’?")

cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("Lets load the data first:\n\n")

cat(sprintf("\tData loaded successfully into \"%s\"!\n\n", load("die.Rdata")))

cat(sprintf("The die was rolled n times with n = %d\n", length(w)))
die_levels <- factor(w)
cat(sprintf("The die has d = %d sides with the following colors:\n", length(attr(die_levels, "levels"))))
cat("\t", attr(die_levels, "levels"), "\n")
cat("\t [\"naranja\" is spanish for \"orange\", while \"verte\" is french for \"green\"]")

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("Lets first calculate the absolute and relative frequencies prior to generating ")
cat("a barplot:\n\n")

n <- length(w)

# Absolute frequencies
blue_abs_f <- length(w[w == "blue"])
naranja_abs_f <- length(w[w == "naranja"])
rot_abs_f <- length(w[w == "rot"])
verte_abs_f <- length(w[w == "verte"])

# Relative frequencies
blue_rel_f <- blue_abs_f / n
naranja_rel_f <- naranja_abs_f / n
rot_rel_f <- rot_abs_f / n
verte_rel_f <- verte_abs_f / n
rel_f_vec <- c(blue_rel_f, naranja_rel_f, rot_rel_f, verte_rel_f)

# Standard errors
blue_se <- sqrt((blue_rel_f*(1 - blue_rel_f))/n)
naranja_se <- sqrt((naranja_rel_f*(1 - naranja_rel_f))/n)
rot_se <- sqrt((rot_rel_f*(1 - rot_rel_f))/n)
verte_se <- sqrt((verte_rel_f*(1 - verte_rel_f))/n)
se_vec <- c(blue_se, naranja_se, rot_se, verte_se)

cat(sprintf("              | %7s | %7s | %7s | %7s\n", "blue", "naranja", "rot", "verte"))
cat("--------------|---------|---------|---------|-----------\n")
cat(sprintf(" %12s | %7.3f | %7.3f | %7.3f | %7.3f\n", "abs. freq.",  blue_abs_f, naranja_abs_f, rot_abs_f, verte_abs_f))
cat(sprintf(" %12s | %7.3f | %7.3f | %7.3f | %7.3f\n", "rel. freq.",  blue_rel_f, naranja_rel_f, rot_rel_f, verte_rel_f))
cat(sprintf(" %12s | %7.3f | %7.3f | %7.3f | %7.3f\n\n", "std. err.",  blue_se, naranja_se, rot_se, verte_se))

cat("See the following code and the resulting plot for the barplot.")

bar_coords <- barplot(rel_f_vec, main="Die results", xlab="Rel. freq. for each colored side",
        names.arg=c("blue", "naranja", "rot", "verte"), col=c("blue", "orange", "red", "green"),
        ylim=c(0, (round(max(rel_f_vec), digits = 1)) + 0.05))

# Add error bars
for(i in 1:length(se_vec)) {
  arrows(x0=bar_coords[i], y0=rel_f_vec[i] - se_vec[i], y1=rel_f_vec[i] + se_vec[i],
         angle=90, code=3, lwd=2, length=0.1)
}

grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)


cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("For blue, rot and verte, all three error bars (nearly) cover each other, while ")
cat("the error bar for naranja is far away from the others. The relative frequency for ")
cat("naranja is also nearly twice as high as the second most frequent color, blue. ")
cat("Intuitively, we would assume that the die is not fair and that it seems to favor ")
cat("the naranja-side.")

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE