# Turing Machines in R

## Specification

The **TuRingMachine** repo uses a single tape Turing machine ("_TM_") specified as a 7-tuple:

```
TM := <Q, L, b, S, d, q(0), F>
```

_Where:_

- _Q_ is a finite, non-empty set of states;
- _L_ is a finite, non-empty set of tape alphabet symbols;
- _b_ (in _L_) is the blank symbol (the only symbol allowed to occur on the tape infinitely often at any step during the computation);
- _S_ is the set of input symbols that are allowed to appear in the initial tape contents, this excludes _b_;
- _q(0)_ (belonging to _Q_) is the initial state;
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

## Initialisation

Any **TuRingMachine** in this repo is initialised as:

```
function_name(input, blank_symbol, instruction_set, initial_state, final_state, tape_moves = 999)
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

## Acknowledgement

A number of the **turRingMachine** functions have instruction sets specified as per Chapter 2 "_Algorithms and Turing Machines_" in Roger Penrose's book "[The Emperor's New Mind](https://en.wikipedia.org/wiki/The_Emperor%27s_New_Mind)".

## License

**tuRingMachine** is open source software [licensed as MIT](https://github.com/agarbiak/tuRingMachine/blob/master/LICENSE).
