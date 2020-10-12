# Background --------------------------------------------------------------
# We show the first 13 Turing machines as per the "Penrose schema"
# We also show, given an instruction set, which "Penrose" Turing machine this corresponds to
# Source: The Emperor's New Mind, Roger Penrose, Chapter 2 "Algorithms and Turing Machines"

# Load TM functions -------------------------------------------------------
source("R/TM_Num.R")

# Output the first 13 Penrose TMs -----------------------------------------
turing_machines <- 0:12
names(turing_machines) <- paste0("TM_", turing_machines)
# instruction_sets <- lapply(turing_machines, read_tm)

instruction_sets <- do.call(
  rbind.data.frame,
  lapply(turing_machines, read_tm)
)

instruction_sets$TM <- gsub("\\.\\d", "", rownames(instruction_sets))

# Output Penrose TMs with halting moves
halting_TMs <- unique(instruction_sets$TM[instruction_sets$move_tape == "H"])
paste0(
  "Of the first ",
  length(turing_machines),
  " Turing machines (under Penrose's schema), only ",
  length(halting_TMs),
  " of these have a halting move."
)

instruction_sets[instruction_sets$TM %in% halting_TMs, ]

# Determine the TM number for XN+1 ----------------------------------------
TM_XN_AddOne <- write_tm(instruction_set = read.csv("data/XN_AddOne.csv"))
paste0(
  "XN+1 is the ",
  prettyNum(TM_XN_AddOne, big.mark = ","),
  "th Turing machine under the Penrose schema."
)

# Verify TM 177,642 is UN+1 -----------------------------------------------
instruction_set <- read_tm(177642)