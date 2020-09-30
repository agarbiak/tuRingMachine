# User selected binary input to perform addition ---------------------------------
input <- 111

# TM instructions ---------------------------------------------------------
state0 <- data.frame(
  current_state = rep("0", 3),
  tape_symbol = c("_","0","1"),
  next_state = c("1", "0", "0"),
  print_symbol = c("_","0","1"),
  move_tape = c("L","R","R")
)

state1 <- data.frame(
  current_state = rep("1", 3),
  tape_symbol = c("_","0","1"),
  next_state = c("H", "H", "1"),
  print_symbol = c("1","1","0"),
  move_tape = c("L","R","L")
)

instruction_set <- rbind(state0, state1)
rm(state0, state1)

initial_state <- "0"
final_state <- "H" 


# Run library function binary_add_one with given inputs -------------------
source("R/add_one.R")
output <- binary_add_one(
  input = input,
  blank_symbol = "_",
  instruction_set = instruction_set,
  initial_state = initial_state,
  final_state = final_state
)

# Output final tape -------------------------------------------------------
if (output$status == "Accepted") {
  print(paste0(
        "We started with ",
        output$input,
        ", and ended with ",
        output$output,
        " and it took ",
        output$moves,
        " moves to add (binary) 1 to our initial tape"
      ))
} else if (output$status == "Rejected") {
  print(
    paste0(
      "Turing machine halted prematurely after ",
      output$moves,
      " moves with the given input: ",
      output$input
    )
  )
} else {
  "The machine broke down"
}