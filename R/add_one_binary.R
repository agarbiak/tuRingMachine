binary_add_one <- function(input, instruction_set, inital_state, final_state, tape_moves = 100) {
  tape_position <- 1
  blank_symbol <- "_"
  
  input <- c(
    blank_symbol, # Pre-tape input
    strsplit(as.character(input), split="")[[1]],
    blank_symbol # End of tape input
  )
  
  for (i in 1:tape_moves) {
  
  tape_head <- input[tape_position]
  
  move_type <- instruction_set$direction[
    instruction_set$state == current_state &
      instruction_set$tape_head == tape_head
  ]
  
  new_state <- instruction_set$newstate[
    instruction_set$state == current_state &
      instruction_set$tape_head == tape_head
  ]
  
  tape_print <- instruction_set$print_to_tape[
    instruction_set$state == current_state &
      instruction_set$tape_head == tape_head
  ]
  
  input[tape_position] <- tape_print
  tape_position <- tape_position + move_type
  current_state <- new_state
  
  add_to_log <- data.frame(
    moveNum = num_of_moves,
    stateNum = new_state,
    tapeValue = paste(input, collapse=""),
    headValue = tape_print
  )
  
  tape_log <- rbind(tape_log, add_to_log)
  
  if (current_state == 2) {
    return(input)
    break
  }
  
  }
}