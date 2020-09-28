# Deterministic Turing Machines ("DTM") in R

## DTM specification

The **TuRingMachine** repo uses a single tape Turing machine ("_TM_") specified as a 7-tuple:

```
TM := <Q, L, b, S, d, q0, F>
```

_Where:_

- _Q_ is a finite, non-empty set of states;
- _L_ is a finite, non-empty set of tape alphabet symbols;
- _b_ (in _L_) is the blank symbol (the only symbol allowed to occur on the tape infinitely often at any step during the computation);
- _S_ is the set of input symbols that are allowed to appear in the initial tape contents, this excludes _b_;
- _q0_ (belonging to _Q_) is the initial state;
- _F_ (subset of _Q_) is the set of final states or accepting states. The initial tape contents is said to be accepted by _TM_ if it eventually halts in a state from _F_.
- _d_ is the transition function, which takes as inputs:

  - State _qx_ (in _Q_)
  - Alphabet symbol _l_ (in _L_)

  And outputs:

  - State _qy_ (in _Q_)
  - Alphabet symbol _l_ (in _L_)
  - A move direction:
    - "_L_" (i.e. move the tape head one position to the left), and
    - "_R_" (i.e. move right)

## DTM initialisation

All DTMs in this repo are initialised as:

```
function_name(input, instruction_set, inital_state, final_state, tape_moves = 100)
```

_Where:_

- _function_name_ is a **tuRingMachine** `function`
- _input_ is an `atomic vector`
- _instruction_set_ is a `data.frame` that has the following column entries:
  - _state_
  - _tape_head_
  - _direction_
  - _new_state_
  - _print_tape_

Here the _instruction_set_ is used by the _TM_ as the transition function.
