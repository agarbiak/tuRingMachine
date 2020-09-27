# User selected input to perform addition ---------------------------------
input <- 11111

# Enter user input onto the tape ------------------------------------------
input <- c(
  -2, # Pre-tape input
  as.numeric(
    strsplit(as.character(input), split="")[[1]]
  ),
  -1 # End of tape input
)
initial_input <- input

# TM instructions ---------------------------------------------------------
states <- c(0,0,0,0,1,1,1)
newstates <- c(0,0,0,1,2,1,2) # State 2 = Halt
head_values <- c(-2,0,1,-1,0,1,-2) # Head value of -2 = Pre-tape input, -1 = End of tape input
directions <- c(1,1,1,-1,-1,-1,1) # Right = 1, Left = -1
print_values <- c(-2,0,1,-1,1,0,1)

instruction_set <- data.frame(
  state = states, 
  tape_head = head_values, 
  direction = directions, 
  newstate = newstates,
  print_to_tape = print_values
)

# TM initialisation -------------------------------------------------------
tape_moves <- 100
current_state <- 0
tape_position <- 1

tape_log <- data.frame(
  moveNum = integer(),
  stateNum = integer(),
  tapeValue = character(),
  headValue = integer()
)

# Run the machine ---------------------------------------------------------
for(i in 1:tape_moves) {
  
  num_of_moves <- i
  
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

# Output final tape -------------------------------------------------------

if (tape_log[dim(tape_log)[1], "stateNum"] != 2) {
  print(
    paste0(
      "Turing machine halted prematurely after ",
      paste0(tape_moves, collapse = ""),
      " moves with the given input: ",
      paste0(tail(head(initial_input,-1), -1), collapse = "")
    )
  )
} else {

  tape_initial <- paste(
    tail(head(initial_input,-1),-1), collapse = ""
  )
  
  tape_final <- 
    if (head(input, 1) == -2) {
      paste(
        tail(head(input,-1), -1), collapse = ""
      )
    } else {
      paste(
        head(input,-1), collapse = ""
      ) 
    }
  
  print(paste0(
    "We started with ",
    tape_initial,
    ", and ended with ",
    tape_final,
    " and it took ",
    dim(tape_log)[1],
    " moves to add (binary) 1 to our initial tape"
  ))
  
}