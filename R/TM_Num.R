# write_tm function
# Given an instruction_set return its TM number 
#' @param data.frame
#' @return bigz (large integer)
write_tm <- function(instruction_set) {
  # Economies before encoding
  # Replace {0,0} entries with {,}
  # Replace {0,1} entries with {,1}
  instruction_set[
    (instruction_set$next_state == 0 
     & instruction_set$print_symbol == 0),
    c("next_state", "print_symbol")
    ] <- ""
  
  instruction_set$next_state[
    instruction_set$next_state == 0 & instruction_set$print_symbol == 1
    ] <- ""
  
  # Start encoding
  instruction_set_encoded <- data.frame(
    next_state = character(),
    print_symbol = character(),
    move_tape = character()
  )
  
  instruction_length <- dim(instruction_set)[1]
  
  instruction_set_encoded <- paste0(
    instruction_set$next_state[1],
    instruction_set$print_symbol[1],
    instruction_set$move_tape[1]
  )
  
  for(i in 2:instruction_length) {
    instruction_set_encoded <- c(
      instruction_set_encoded,
      paste0(
        instruction_set$next_state[i],
        instruction_set$print_symbol[i],
        instruction_set$move_tape[i]
      )
    )
  }
  
  instruction_set_encoded <- paste0(
    instruction_set_encoded, collapse = ""
  )
  
  # Encode as expanded binary
  # 0 for 0
  # 10 for 1
  # 110 for R
  # 1110 for L
  # 11110 for H
  instruction_set_encoded <- gsub("1", "10", instruction_set_encoded)
  instruction_set_encoded <- gsub("R", "110", instruction_set_encoded)
  instruction_set_encoded <- gsub("L", "1110", instruction_set_encoded)
  instruction_set_encoded <- gsub("H", "11110", instruction_set_encoded)
  
  # Economies on expanded encoding
  # Remove first 110
  instruction_set_encoded <- substring(instruction_set_encoded, 4)
  # Remove last 110
  instruction_set_encoded <- substring(
    instruction_set_encoded,
    1,
    nchar(instruction_set_encoded) - 3
  )
  
  # Output as dernary
  instruction_set_split <- strsplit(instruction_set_encoded, split = "")[[1]]
  powers <- rev(seq(length(instruction_set_split))) - 1
  binaryNum <- as.integer(instruction_set_split) * gmp::as.bigz(2)^powers
  TM_number <- sum(binaryNum)
  TM_number
}

# read_tm function
# Given a TM number return its instruction_set 
#' @param bigz (large integer)
#' @return data.frame
# Limitations: 
#   R.utils::intToBin() only works to .Machine$integer.max
#   intToBits() only works to .Machine$integer.max
#   2,147,483,647
read_tm <- function(input) {
  # Convert decimal to binary
  if (input == 0) {
    # Add Penrose start and end input encoding
    input <- "110110"
  } else {
    input <- paste(
      as.integer(rev(intToBits(input))),
      collapse = ""
    )
    input <- strsplit(input, split = "")[[1]]
    input <- input[match("1", input):length(input)]
    # Add Penrose start and end input encoding
    input <- paste0(c("110", input, "110"), collapse = "")
  }
  
  # Decode Penrose schema
  input <- gsub("11110", "H", input)
  input <- gsub("1110", "L", input)
  input <- gsub("110", "R", input)
  input <- gsub("10", "1", input)
  
  # Create instruction set
  move_tape <- strsplit(gsub("0|1", "", input), split = "")[[1]]
  input_values <- strsplit(input, split = "L|R|H")[[1]]
  input_values <- gsub("^$", "0", input_values)
  print_symbol <- stringi::stri_sub(input_values, -1, -1)
  
  next_state <- ifelse(
    stringi::stri_length(input_values) == 1,
    "0",
    stringi::stri_sub(input_values, 1, -2)
  )
  
  # Even (0), odd (1) treatment 
  tape_type <- ifelse(length(move_tape) %% 2 == 0, 0, 1)
  
  if (tape_type == 0){
    
    tape_symbol <- rep(c("0","1"), length(move_tape) / 2)
    
    current_state <- R.utils::intToBin(
      0:(length(move_tape)/2 - 1)
    )
    current_state[1] <- "0"
    current_state <- gsub("^0+1", "1", current_state)
    current_state <- rep(current_state, each = 2)
  } else {
    
    tape_symbol <- rep(c("0","1"), length(move_tape) / 2)
    tape_symbol <- c(tape_symbol, "0")
    
    current_state <- R.utils::intToBin(
      0:(ceiling(length(move_tape)/2) - 1)
    )
    current_state[1] <- "0"
    current_state <- gsub("^0+1", "1", current_state)
    current_state <- rep(current_state, each = 2)
    current_state <- current_state[1:(length(current_state) - 1)]
  }
  
  instruction_set <- data.frame(
    current_state = current_state,
    tape_symbol = tape_symbol,
    next_state = next_state,
    print_symbol = print_symbol,
    move_tape = move_tape
  )
  instruction_set
}