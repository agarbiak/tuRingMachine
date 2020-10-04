UN_gcd_full <- function(
  input, 
  blank_symbol,
  instruction_set, 
  initial_state, 
  final_state, 
  tape_moves = 999
) {

  initial_input <- input
  input <- strsplit(as.character(input), split="")[[1]]
  
  tape_position <- 1
  
  tape_log <- data.frame(
    input = paste0(input, collapse = ""),
    current_state = initial_state,
    tape_symbol = input[tape_position],
    tape_position = tape_position
  )
  
  current_state <- initial_state
  
  for (i in 1:tape_moves) {
    
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
    
    # Preprend more tape
    if (tape_position == 0) {
      input <- c(blank_symbol, input)
      tape_position <- 1
    }
    
    # Append more tape
    if (tape_position == length(input) + 1) {
      input <- c(input, blank_symbol)
    }
    
    # Halt on reaching final state
    if (current_state == final_state) {
      status <- "Accept"
      break
    }
    
    # Track TM internals
    tape_add <- data.frame(
      input = paste0(input, collapse = ""),
      current_state = current_state,
      tape_symbol = input[tape_position],
      tape_position = tape_position
    )
    
    tape_log <- rbind(
      tape_log,
      tape_add
    )
  }
  
  # Return accepted result
  if (exists("status")) {
    message("TM accepted input")
    return(tape_log)
  } else {
    # TM rejects input - did not halt  
    message("TM rejected input")
    return(tape_log)
  }
  
}

UN_gcd <- function(
  input, 
  blank_symbol, 
  instruction_set, 
  initial_state, 
  final_state, 
  tape_moves = 999
) {
  
  initial_input <- input
  input <- strsplit(as.character(input), split="")[[1]]
  tape_position <- 1
  current_state <- initial_state
  
  for (i in 1:tape_moves) {
    
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
    
    # Preprend more tape
    if (tape_position == 0) {
      input <- c(blank_symbol, input)
      tape_position <- 1
    }
    
    # Append more tape
    if (tape_position == length(input) + 1) {
      input <- c(input, blank_symbol)
    }
    
    # Halt on reaching final state
    if (current_state == final_state) {
      status <- "Accept"
      output <- as.numeric(
        paste(input[!input %in% blank_symbol], collapse = "")
      )
      tm_result <- data.frame(
        input = initial_input,
        output = output,
        status = "Accepted",
        moves = i
      )
      break
    }
  }

  # Return accepted result
  if (exists("status")) {
    message("TM accepted input")
    return(tm_result)
  } else {
    # TM rejects input - did not halt  
    output <- as.numeric(
      paste(input[!input %in% blank_symbol], collapse = "")
    )
    
    tm_result <- data.frame(
      input = initial_input,
      output = output,
      status = "Rejected",
      moves = tape_moves
    )
    message("TM rejected input")
    return(tm_result)
  }
}