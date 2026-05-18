use core::num::traits::OverflowingMul;

// addition logic
pub fn add_num(x: u32, y: u32) -> u32 {
    return x + y;
}

// subtraction logic
fn sub_num(x: u8, y: u8) -> u8 {
    assert!(!(y > x), "negative result not allowed");
    x - y
}

// multiplication logic
fn mul_num(x: u8, y: u8) -> u8 {
    let (result_, overflowed_) = x.overflowing_mul(y);

    assert!(!(overflowed_), "multiplication overflowed");

    result_
}

// division logic with division by zero check
fn div_num(x: u8, y: u8) -> u8 {
    assert!(!(y == 0), "Cannot be Zero");
    x / y
}

