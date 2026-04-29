use core::num::traits::CheckedAdd;
use core::num::traits::CheckedSub;



pub fn increase_count(current: u128, amount: u128) -> u128{
    current.checked_add(amount).expect('overflow')
}

pub fn decrease_count(current: u128, amount: u128) -> u128 {
    current.checked_sub(amount).expect('underflow')
}

pub fn reset_count() -> u128 {
    0
}