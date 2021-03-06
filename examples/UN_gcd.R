# Background --------------------------------------------------------------
# TM Purpose: Calculate gcd(x, y) with x, y specified in the unary numeral system 
# Input requirement:
#' @param x An unary number.
#' @param y An unary number.
#' @return The gcd of \code{x} and \code{y}
# Source: The Emperor's New Mind, Roger Penrose, Chapter 2 "Algorithms and Turing Machines"

# User selected unary input -----------------------------------------------
unary_one <- 111111 # 6
unary_two <- 11111111 # 8

# TM instructions ---------------------------------------------------------
blank_symbol <- 0
input <- paste0(
  unary_one,
  blank_symbol, # separator
  unary_two
)
instruction_set <- read.csv("data/UN_EUC.csv")

# Run TM ------------------------------------------------------------------
source("R/UN_gcd.R")

# Determine gcd(6, 12)
output <- UN_gcd(
  input = input,
  blank_symbol = blank_symbol,
  instruction_set = instruction_set
)

# Log the TM internals
output_log <- UN_gcd_log(
  input = input,
  blank_symbol = blank_symbol,
  instruction_set = instruction_set
)

# Results -----------------------------------------------------------------
if (output$status == "Accepted") {
  print(paste0(
    "The gcd of (",
    unary_one,
    ", ",
    unary_two,
    ") is ",
    output$output,
    "."
  ))
  print(paste0(
    "The TM took ",
    output$moves,
    " moves to calculate this given its instructions."
  ))
} else if (output$status == "Rejected") {
  print(
    paste0(
      "The TM halted prematurely after ",
      output$moves,
      " moves with the given input tape: ",
      output$input
    )
  )
} else {
  "The machine broke down"
}
