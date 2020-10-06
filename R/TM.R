
instruction_set <- read.csv("data/UN_EUC.csv")

final_row <- as.numeric(
  rownames(instruction_set[instruction_set$next_state == -1, ])
)

instruction_set$next_state[final_row] <- 0
instruction_set[final_row, "move_tape"] <- "STOP"

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

# Economies on encoding
# Delete 00 entries
# Replace 01{L, R, STOP} entries with 1
instruction_set_encoded <- gsub("00", "", instruction_set_encoded)
instruction_set_encoded <- gsub("01L", "1L", instruction_set_encoded)
instruction_set_encoded <- gsub("01R", "1R", instruction_set_encoded)
instruction_set_encoded <- gsub("01STOP", "1STOP", instruction_set_encoded)

# Encode as expanded binary
# 0 for 0
# 10 for 1
# 110 for R
# 1110 for L
# 11110 for STOP
instruction_set_encoded <- gsub("1", "10", instruction_set_encoded)
instruction_set_encoded <- gsub("R", "110", instruction_set_encoded)
instruction_set_encoded <- gsub("L", "1110", instruction_set_encoded)
instruction_set_encoded <- gsub("STOP", "11110", instruction_set_encoded)

# Further economies on encoding
# Remove first 110
instruction_set_encoded <- substring(instruction_set_encoded, 4)
# Remove last 110
instruction_set_encoded <- substring(
  instruction_set_encoded,
  1,
  nchar(instruction_set_encoded) - 3
)
 
## TO DO:
# Output as dernary
# May require large numbers: library(gmp) or library(Rmpfr)