use core::num::traits::OverflowingMul;

#[executable]
fn main() {
    let add_result: u8 = add_num(5, 6);
    println!("the sum of x & y is: {}", add_result);
    assert(add_result == 11, 'invalid sum logic');

    let sub_result: u8 = sub_num(10, 5);
    println!("sub result is: {}", sub_result);
    assert(sub_result == 5, 'invalid sub logic');

        // Test subtraction that should panic (10 - 15 = negative)
    // sub_num(10, 15); // This would panic

    let mul_result: u8 = mul_num(255, 1);
    println!("mul result is: {}", mul_result);
    assert(mul_result == 255, 'invalid mul logic');

    let div_result: u8 = div_num(20, 0);
    println!("div result is: {}", div_result);
    assert(div_result == 5, 'invalid div logic');

    // Test division by zero - should panic
    // div_num(10, 0); // This would panic
}

// addition logic
fn add_num(x: u8, y: u8) -> u8 {
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

