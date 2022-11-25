string_divider <- "-----------------------------------------------------"

file_header <- function(problem, homework) {
  clear_console()
  cat("Welcome to the file Problem", problem, "for the Homework", homework, "assignment of SyntheticDoc!\n\n")
}

clear_console <- function() {
  os <- tolower(Sys.info()['sysname'])
  
  if(os == "windows") {
    shell("cls")
  } else if(os == "darwin" | os == "linux") {
    shell("clear")
  } else {
    cat("WARNING: Can't identify operating system, not able to clear console!\n\n")
  }
}