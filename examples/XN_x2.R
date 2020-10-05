# Background --------------------------------------------------------------
# TM Purpose: Calculate x * 2 with x as a binary input
# Input requirement:
#' @param x A binary number.
#' @return x * 2
# Source: The Emperor's New Mind, Roger Penrose, Chapter 2 "Algorithms and Turing Machines", ISBN 0-19-286198-0

# User selected binary input ----------------------------------------------
input <- 1011 # 1x2^0 + 1*2^1 + 0*2^2 + 1*2^3 = 11

# TM instructions ---------------------------------------------------------
blank_symbol <- 0
instruction_set <- read.csv("data/XN_MultiplyTwo.csv")

# Run TM ------------------------------------------------------------------
source("R/XN_x2.R")

# Determine 11 * 2
output <- XN_x2(
  input = input,
  blank_symbol = 0,
  instruction_set = instruction_set,
  initial_state = 0,
  final_state = -1,
  tape_moves = 1000
)

# Log the TM internals
output_log <- XN_x2_log(
  input = input,
  blank_symbol = 0,
  instruction_set = instruction_set,
  initial_state = 0,
  final_state = -1,
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
