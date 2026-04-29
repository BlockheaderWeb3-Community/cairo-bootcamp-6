# Cairo Bootcamp 6 Assignment

This repo contains my Cairo assignment split into two versions:

- `V1`: the earlier simple Starknet counter contract and standalone arithmetic practice
- `V2`: the improved version where the Starknet contract imports reusable Cairo arithmetic logic and adds access control

## Assignment Summary

The assignment required the following:

- add a subtraction check so negative results throw an error
- write multiplication and division functions and handle their error cases
- add `only_owner` to state-changing functions
- make `increase_count` read the current storage value and add the incoming amount instead of overwriting storage
- import Cairo arithmetic logic into the Starknet contract for `increase_count` and `reduce_count`

## Project Structure

- `cairo_program/`: plain Cairo logic
- `starknet_contracts/`: Starknet contracts

## V1 Files

- Cairo arithmetic practice: [cairo_program/src/integer.cairo](cairo_program/src/integer.cairo)
- Simple Starknet contract: [starknet_contracts/src/counter_v1.cairo](starknet_contracts/src/counter_v1.cairo)

## V2 Files

- Reusable arithmetic logic: [cairo_program/src/arithmetic_v2.cairo](cairo_program/src/arithmetic_v2.cairo)
- Cairo library export: [cairo_program/src/lib.cairo](cairo_program/src/lib.cairo)
- Improved Starknet contract: [starknet_contracts/src/counter_v2.cairo](starknet_contracts/src/counter_v2.cairo)
- Starknet package entry: [starknet_contracts/src/lib.cairo](starknet_contracts/src/lib.cairo)

## What Was Implemented In V2

- `sub_num` checks for underflow and throws an error
- `mul_num` checks for overflow
- `div_num` checks for division by zero
- `increase_count` uses imported addition logic
- `reduce_count` uses imported subtraction logic
- `increase_count` reads the current count from storage before updating it
- `only_owner` restricts state-changing functions

## Build Status

Both packages compile successfully:

- `cairo_program`
- `starknet_contracts`

## Next Step

The next step after this PR is deployment of `CounterV2`, where the owner address will be passed into the constructor.
