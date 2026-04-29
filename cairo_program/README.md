# Cairo Program

This package contains the plain Cairo logic used in the assignment.

## Files

- `src/integer.cairo`: V1 arithmetic practice
- `src/arithmetic_v2.cairo`: V2 reusable arithmetic functions
- `src/lib.cairo`: exports the V2 arithmetic module for reuse by the Starknet contract package

## V2 Arithmetic

The reusable V2 module includes:

- `add_num`
- `sub_num`
- `mul_num`
- `div_num`

Error handling included:

- subtraction underflow protection
- multiplication overflow protection
- division-by-zero protection

This package is imported into the V2 Starknet contract so the contract can reuse the arithmetic logic instead of doing the arithmetic inline.
