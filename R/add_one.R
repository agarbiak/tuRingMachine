binary_add_one <- function(input, blank_symbol = "_", instruction_set, initial_state, final_state, tape_moves = 100) {

  initial_input <- input
  input <- c(
    blank_symbol, # Pre-tape input
    strsplit(as.character(input), split="")[[1]],
    blank_symbol # End of tape input
  )
  
  tape_position <- 2
  current_state <- initial_state
  
  for (i in 1:tape_moves) {
    
    num_of_moves <- i
    
    tape_symbol <- input[tape_position]
    
    next_state <- instruction_set$next_state[
      instruction_set$current_state == current_state &
        instruction_set$tape_symbol == tape_symbol
    ]
    
    print_symbol <- instruction_set$print_symbol[
      instruction_set$current_state == current_state &
        instruction_set$tape_symbol == tape_symbol
    ]
    
    move_type <- instruction_set$move_tape[
      instruction_set$current_state == current_state &
        instruction_set$tape_symbol == tape_symbol
    ]
    
    move_type <- if (move_type == "R") {
      1
    } else if (move_type == "L") {
      -1
    } else break
    
    input[tape_position] <- print_symbol
    tape_position <- tape_position + move_type
    current_state <- next_state
    
    if (current_state == final_state) {
      output <- as.numeric(
        paste(tail(head(input,-1),-1), collapse = "")
      )
      return(data.frame(
        input = initial_input,
        output = output,
        status = "Accepted",
        moves = num_of_moves
      ))
      return(output)
      break
    }
  }
  
  return(data.frame(
   input = initial_input,
   output = NULL,
   status = "Rejected",
   moves = num_of_moves
  ))
}