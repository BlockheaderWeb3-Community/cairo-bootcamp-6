use core::num::traits::CheckedAdd;
use core::num::traits::CheckedSub;
use core::num::traits::CheckedMul;

#[derive(Drop)]
enum MathError {
    Overflow,
    DivisionByZero,
    Underflow,
}


pub fn add_num(x: u128, y: u128) -> u128{
    if y == 0
    {
        return x;
    }
    x.checked_add(y).expect('overflow')
}

pub fn sub_num(x: u128, y: u128) -> u128 {
     if y == 0
    {
        return x;
    }
    x.checked_sub(y).expect('underflow')
}

pub fn multiply_number(x:u128, y:u128) -> Result<u128, MathError> {
    if x == 0 || y == 0 {
        return Result::Ok(0);
    } 
    x.checked_mul(y).ok_or(MathError::Overflow)
}

pub fn divide(x: u128, y: u128) -> Result<u128, MathError>{
    if y == 0 {
        return Result::Err(MathError::DivisionByZero);
    }

    Result::Ok(x / y)
}

pub fn reset_count() -> u128 {
    0
}