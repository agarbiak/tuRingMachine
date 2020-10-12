# Background --------------------------------------------------------------
# TM Purpose: Calculate x + 1 with x as a binary input
# Input requirement:
#' @param x A binary number.
#' @return x + 1
# Source: The Emperor's New Mind, Roger Penrose, Chapter 2 "Algorithms and Turing Machines"

# User selected binary input ----------------------------------------------
input <- 10100111 # = 167

# TM instructions ---------------------------------------------------------
blank_symbol <- 0
instruction_set <- read.csv("data/XN_AddOne.csv")

# Run TM ------------------------------------------------------------------
source("R/XN_addOne.R")

# Determine 167 + 1
output <- XN_addOne(
  input = input,
  blank_symbol = blank_symbol,
  instruction_set = instruction_set,
  tape_moves = 1000
)

# Log the TM internals
output_log <- XN_addOne_log(
  input = input,
  blank_symbol = blank_symbol,
  instruction_set = instruction_set,
  tape_moves = 1000
)

# Results -----------------------------------------------------------------
if (output$status == "Accepted") {
  print(paste0(
    input,
    " + 1 = ",
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
