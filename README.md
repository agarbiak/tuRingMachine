# Turing Machines in R

## Specification

The **TuRingMachine** repo uses a single tape Turing machine ("_TM_") specified as a 7-tuple:

```
TM := <Q, L, b, S, d, q(0), F>
```

_Where:_

- _Q_ is a finite, non-empty set of states;
- _L_ is the set of tape alphabet symbols: _{0, 1}_;
- _b_ (in _L_) is the blank symbol: _{0}_ (the only symbol allowed to occur on the tape infinitely often at any step during the computation);
- _S_ is the set of input symbols that are allowed to appear in the initial tape contents: _{0, 1}_;
- _q(0)_ (belonging to _Q_) is the initial state: _{0}_;
- _F_ (subset of _Q_) is the set of final states or accepting states. The initial tape contents is said to be accepted by _TM_ if it eventually halts in a state from _F_.
- _d_ is the transition function, which takes as inputs:

  - State _q(x)_ (in _Q_)
  - Alphabet symbol _l_ (in _L_)

  And outputs:

  - State _q(y)_ (in _Q_)
  - Alphabet symbol _l_ (in _L_)
  - A move direction:
    - "_L_" (i.e. move the tape head one position to the left), and
    - "_R_" (i.e. move right)

Specifically the Turing machine instructions are encoded using Penrose's schema:

- _0_ for `0`
- _10_ for `1`
- _110_ for `R`, move the tape right
- _1110_ for `L`, move the tape left
- _11110_ for `H`, the halting move 

## Initialisation

Any **TuRingMachine** in this repo is initialised as:

```
function_name(input, blank_symbol, instruction_set, tape_moves = 999)
```

_Where:_

- _function_name_ is a **tuRingMachine** `function` within [`/R`](https://github.com/agarbiak/tuRingMachine/tree/master/R)
- _input_ is an `atomic vector`
- _instruction_set_ is a `data.frame` that has the following column entries:
  - _current_state_
  - _tape_symbol_
  - _next_state_
  - _print_symbol_
  - _move_tape_

Here the _instruction_set_ is used by the _TM_ as the transition function.

## Output

There are two types of **tuRingMachine** functions for each type of operation:

1. The base function will output a `data.frame` with the following columns:

- _input_ as an `atomic vector`
- _output_ as an `atomic vector`
- _status_ providing a binary outcome `"Accepted"` or `"Rejected"`
- _moves_, as an `integer`, being the number of times the tape was moved by the _TM_

2. The equivalent function with `_log` appended to the function name will output a `data.frame` with the following columns:

- _input_ as an `atomic vector`
- _current_state_ for each tape move from the _instruction_set_
- _tape_symbol_ as the current tape symbol read by the _TM_ for each tape move
- _tape_position_ as the position along the _input_ that the _TM_ is for each tape move

This allows you to track the internals of the _TM_.

## Usage

Examples of using a **turRingMachine** `function` is given in [`/examples`](https://github.com/agarbiak/tuRingMachine/tree/master/examples).

Pre-configured instruction sets are given in [`/data`](https://github.com/agarbiak/tuRingMachine/tree/master/data).

Using Penrose's schema we find that the Turing machine that adds one in binary ("_XN + 1_") is represented by the 450,813,704,461,563,958,982,113,775,643,437,908th Turing machine, as shown in [`/examples/TuringMachines.R`](https://github.com/agarbiak/tuRingMachine/blob/master/examples/TuringMachines.R).

We also find that Turing machine 177,642 (under Penrose's encoding schema) corresponds to a machine that adds one to a unary input ("_UN + 1_"), again shown in [`/examples/TuringMachines.R`](https://github.com/agarbiak/tuRingMachine/blob/master/examples/TuringMachines.R).

## Acknowledgement

This repo is an `R` implementation of the Turing machines specified in Chapter 2 "_Algorithms and Turing Machines_" in Roger Penrose's book "[The Emperor's New Mind](https://en.wikipedia.org/wiki/The_Emperor%27s_New_Mind)".

## License

**tuRingMachine** is open source software [licensed as MIT](https://github.com/agarbiak/tuRingMachine/blob/master/LICENSE).
