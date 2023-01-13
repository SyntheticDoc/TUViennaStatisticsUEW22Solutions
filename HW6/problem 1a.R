# This file is meant to be run without console echos active (ctrl+shift+s)!
# Run this file with the keyboard shortcut given above to print the fully formatted
# solution text to the console.
cpu_w_input <- c(25, 13, 7, 9, 44, 3, 2, 33)
cpu_w <- sort(cpu_w_input)

source("globalFunctionRepository.R")
source("problem 1b.R")

file_header(1, 6)
cat("The problem: CPU workload\n")
cat("The CPU workloads (in %) of a processor were observed eight times and gave\n\n")
cat("\t25, 13, 7, 9, 44, 3, 2, 33.\n")
cat("\t[Sorted sample: ")
cat(cpu_w)
cat("]\n\n")
cat("Find all\n\n")
cat("\ta) empirical medians,\n\n")
cat("\tb) empirical third quartiles,\n\n")
cat("\tc) empirical 1/3-quantiles,\n\n")
cat("\td) Lastly, compute the value for each previous part using R. How does ")
cat("it produce the exact value given?\n\n")
cat("\tHint: ?quantile.")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR a)\n")
cat("As given in the slides, the empirical median of a sample is a 50%-quantile ")
cat("and represents a value m, so that 50% of our sample values are <= m and the ")
cat("other 50% >= m.\n")
cat("Our sample consists of", length(cpu_w), "values, so that we easily can pick out ")
cat("our median:\n\n")

cat("The 1/2-quantile of our sample (calculated by a custom function created by me) is:\n\n")
get_quantile(cpu_w, 0.5)

cat("\n\nEND OF SOLUTION FOR a)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR b)\n")
cat("A \"quartile\" is a division of the sample in four parts of equal length. Therefore, ")
cat("the third quartile is a 75%-quantile, which can easily be calculated:\n\n")

cat("The 75%-quantile of our sample (calculated by a custom function created by me) is:\n\n")
get_quantile(cpu_w, 0.75)

cat("\n\nEND OF SOLUTION FOR b)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR c)\n")
cat("As in b), we can calculate the 1/3-quantile easily:\n\n")

cat("The 1/3-quantile of our sample (calculated by a custom function created by me) is:\n\n")
get_quantile(cpu_w, 1/3)
get_quantile(cpu_w, 2/3)

cat("\n\nEND OF SOLUTION FOR c)")
cat("\n\n", string_divider, "\n\n")
# -----------------------------------------------------------------------------#
cat("SOLUTION FOR d)\n")
cat("Lets compute the same values with R:\n\n")
cat("\tMedian:", quantile(cpu_w, 0.5), "\t\t[Our result:", get_quantile(cpu_w, 0.5, TRUE))
cat("]\n")
cat("\t75%-quantile:", quantile(cpu_w, 0.75), "\t[Our result:", get_quantile(cpu_w, 0.75, TRUE))
cat("]\n")
cat("\t1/3-quantile:", quantile(cpu_w, 1/3), "\t[Our result:", get_quantile(cpu_w, 1/3, TRUE))
cat("]\n\n")

cat("To calculate these results, R can use all nine algorithms from Hyndman and Fans ")
cat("list of algorithms used in estimating quantiles from a sample in computer programs.\n")
cat("These algorithms compute an estimate for the desired quantile from a sample of size N ")
cat("by computing an index. If h is an integer, the h-th smallest of the N values (= x_h) ")
cat("is the resulting estimate. If h is not an integer, the algorithms use different ")
cat("interpolations to calculate an estimate between floor(h) and ceiling(h).\n")
cat("The algorithms provided by R and Hyndman and Fan are:\n\n")

cat("\t-- R1 --\n")
cat("h = Np, quantile estimate: x_ceiling(h)\n")
cat("[Inverse of the empirical distribution function, which is defined as F(t) = (number of ")
cat("sample elements <= t)/sample_size][\n\n")

cat("\t-- R2 --\n")
cat("h = Np + 1/2, quantile estimate: (x_ceiling(h - 1/2) + x_floor(h + 1/2)) / 2\n")
cat("[As R1, but averages at discontinuous points]\n\n")

cat("\t-- R3 --\n")
cat("h = Np - 1/2, quantile estimate: x_round_special(h), with round_special(x) = round x to ")
cat("nearest integer, rounding to the next even number in case of a tie\n")
cat("[Chooses the index closest to Np]\n\n")

cat("\t-- R4 --\n")
cat("h = Np, quantile estimate: x_floor(h) + (h - floor(h)) * (x_ceiling(h) - x_floor(h))\n")
cat("[Linear interpolation between x_floor(h) and x_ceiling(h)]\n\n")

cat("\t-- R5 --\n")
cat("h = Np + 1/2, quantile estimate: as R4\n")
cat("[As R4]\n\n")

cat("\t-- R6 --\n")
cat("h = (N + 1) * p, quantile estimate: as R4\n")
cat("[As R4]\n\n")

cat("\t-- R7 --\n")
cat("h = (N - 1) * p + 1, quantile estimate: as R4\n")
cat("[As R4]\n\n")

cat("\t-- R8 --\n")
cat("h = (N + 1/3) * p + 1/3, quantile estimate: as R4\n")
cat("[As R4]\n\n")

cat("\t-- R9 --\n")
cat("h = (N + 1/4) * p + 3/8, quantile estimate: as R4\n")
cat("[As R4]\n\n")

cat("Of all these algorithms, Hyndman and Fan originally recommended R8, while most ")
cat("computer program default to R6 or R7. R itself defaults to R7\n\n")

cat("[Source for all informations regarding algorithms: https://en.wikipedia.org/wiki/Quantile#Estimating_quantiles_from_a_sample]\n\n")

cat("Lets have a look at the results of all those algorithms for our quantiles:\n\n")

cat("Data:", cpu_w, "\n\n")

for(i in 1:9) {
  cat("Algorithm R")
  cat(i)
  cat(":\n")
  cat("\tMedian:", quantile(cpu_w, 0.5, type = i), "\t\t[Our result:", get_quantile(cpu_w, 0.5, TRUE))
  cat("]\n")
  cat("\t75%-quantile:", quantile(cpu_w, 0.75, type = i), "\t[Our result:", get_quantile(cpu_w, 0.75, TRUE))
  cat("]\n")
  cat("\t1/3-quantile:", quantile(cpu_w, 1/3, type = i), "\t[Our result:", get_quantile(cpu_w, 1/3, TRUE))
  cat("]\n")
  cat("\t2/3-quantile:", quantile(cpu_w, 2/3, type = i), "\t[Our result:", get_quantile(cpu_w, 2/3, TRUE))
  cat("]\n\n")
}

cat("END OF SOLUTION FOR d)")
cat("\n\nEND OF SOLUTION FILE")

# END OF FILE