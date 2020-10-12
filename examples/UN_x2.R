# Background --------------------------------------------------------------
# TM Purpose: Calculate x * 2 with x specified in the unary numeral system 
# Input requirement:
#' @param x An unary number.
#' @return x * 2
# Source: The Emperor's New Mind, Roger Penrose, Chapter 2 "Algorithms and Turing Machines"

# User selected unary input -----------------------------------------------
input <- 1111 # 4

# TM instructions ---------------------------------------------------------
blank_symbol <- 0
instruction_set <- read.csv("data/UN_MultiplyTwo.csv")

# Run TM ------------------------------------------------------------------
source("R/UN_x2.R")

# Determine 4 * 2
output <- UN_x2(
  input = input,
  blank_symbol = 0,
  instruction_set = instruction_set,
  tape_moves = 1000
)

# Log the TM internals
output_log <- UN_x2_log(
  input = input,
  blank_symbol = 0,
  instruction_set = instruction_set,
  tape_moves = 1000
)

# Results -----------------------------------------------------------------
if (output$status == "Accepted") {
  print(paste0(
    input,
    " x 2 = ",
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