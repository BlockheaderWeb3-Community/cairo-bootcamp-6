pub mod counter;

use core::result::Result;

pub fn add_num(x: u8, y: u8) -> u8 {
    x + y
}

pub fn sub_num(x: u8, y: u8) -> Result<u8, felt252> {
    if y > x {
        Result::Err('result would be negative')
    } else {
        Result::Ok(x - y)
    }
}

pub fn mul_num(x: u8, y: u8) -> u8 {
    x * y
}

pub fn div_num(x: u8, y: u8) -> Result<u8, felt252> {
    if y != 0 {
        Result::Ok(x / y)
    } else {
        Result::Err('not divisible by zero')
    }
}