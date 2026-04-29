#[executable]
fn main() {
    let result: u8 = add_num(5, 6);
    println!("the sum of x & y is: {}", result);
    assert(result == 11, 'invalid sum logic');

    let sub_result: u8 = sub_num(10, 5);
    println!("sub result is: {}", sub_result);
    assert(sub_result == 5, 'invalid sub logic');

    // Test subtraction that should panic (10 - 15 = negative)
    // sub_num(10, 15); // This would panic

    let mul_result: u8 = mul_num(3, 4);
    println!("mul result is: {}", mul_result);
    assert(mul_result == 12, 'invalid mul logic');

    let div_result: u8 = div_num(20, 4);
    println!("div result is: {}", div_result);
    assert(div_result == 5, 'invalid div logic');

    // Test division by zero - should panic
    // div_num(10, 0); // This would panic
}

// addition logic
fn add_num(x: u8, y: u8) -> u8 {
    x + y
}

// subtraction logic with negative check
fn sub_num(x: u8, y: u8) -> u8 {
    if (y > x) {
        panic_with_felt252('negative result not allowed');
    }
    return x - y;
}

// multiplication logic
fn mul_num(x: u8, y: u8) -> u8 {
    x * y
}

// division logic with division by zero check
fn div_num(x: u8, y: u8) -> u8 {
    if (y == 0) {
        panic_with_felt252('division by zero');
    }
    x / y
}
