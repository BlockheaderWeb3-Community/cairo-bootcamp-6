use core::integer::u256;
use core::result::Result;

#[executable]
fn main() {
    let result: u8 = add_num(5, 6);
    println!("The sum of x & y is: {}", result);
    assert(result == 11, 'invalid sum logic');

    let sub_result: u8 = sub_num(10, 5);
    println!("Sub result is: {}", sub_result);
    assert(sub_result == 5, 'invalid sub');

    let mul_result: u8 = mul_num(5, 2);
    println!("Mul result of x & y is {}", mul_result);
    assert(mul_result == 10, 'invalid mul');

    let div_result = div_num(0, 10);
    match div_result {
        Result::Ok(value) => {
            println!("Div result of x & y is {}", value);
            assert(value == 1, 'invalid div');
        },
        Result::Err(err) => {
            println!("division failed: {}", err);
            assert(false, 'unexpected error in div_num');
        },
    }

    let input: felt252 = 200;
    let mutated = mutate_byte(input);
    match mutated {
        Result::Ok(value) => {
            println!("Mutated byte: {}", value);
            assert(value == 199, 'invalid mutate_byte result');
        },
        Result::Err(err) => {
            println!("mutation failed: {}", err);
            assert(false, 'unexpected error in mutate_byte');
        },
    }
}

// addition logic
fn add_num(x: u8, y: u8) -> u8 {
    x + y
}

// subtraction logic
fn sub_num(x: u8, y: u8) -> u8 {
    if x > y {
        x - y
    } else {
        0
    }
}

// multiplication logic
fn mul_num(x: u8, y: u8) -> u8 {
    x * y
}

// division logic
fn div_num(x:u8, y: u8) -> Result<u8, felt252> {
    if y != 0 {
        Result::Ok(x / y)
    } else {
        Result::Err('not divisible by zero')
    }
}
// Convert a felt252 input into a u8, returning an error if the value is too large.
fn parse_u8(input: felt252) -> Result<u8, felt252> {
    let input_u256: u256 = input.into();
    if input_u256 < 256 {
        Result::Ok(input.try_into().unwrap())
    } else {
        Result::Err('Invalid Integer')
    }
}

// Mutate the parsed byte, preserving failure semantics.
fn mutate_byte(input: felt252) -> Result<u8, felt252> {
    let input_to_u8 = match parse_u8(input) {
        Result::Ok(num) => num,
        Result::Err(err) => { return Result::Err(err); },
    };
    let res = input_to_u8 - 1;
    Result::Ok(res)
}
