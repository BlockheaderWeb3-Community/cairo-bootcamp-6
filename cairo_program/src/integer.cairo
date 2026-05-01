#[executable]
fn main() {
    let result: u32 = add_num(5, 6);
    println!("the sum of x & y is: {}", result);
    assert!(result == 11, "invalid add logic");

    let sub_result: u32 = sub_num(3, 5);
    println!("sub result is: {}", sub_result);
    assert!(sub_result == 5, "invalid sub logic");

    let mul_result: u8 = mul_num(5, 6);
    println!("mul result is: {}", mul_result);
    assert!(mul_result == 30, "invalid mul logic");

    let div_result: u8 = div_num(10, 5);
    println!("div result is: {}", div_result);
    assert!(div_result == 2, "invalid div logic");
}

// addition logic
pub fn add_num(x: u32, y: u32) -> u32 {
    x + y
}

// subtraction logic
pub fn sub_num(x: u32, y: u32) -> u32 {
    assert!(x >= y, "y should be less than or equal to x");
    return x - y;
}

// multiplication logic
pub fn mul_num(x: u8, y: u8) -> u8 {
    if (x == 0 || y == 0) {
        assert!(y != 0 && x != 0, "x or y should not be zero");
    }
    x * y
}

// division logic
pub fn div_num(x: u8, y: u8) -> u8 {
    if y == 0 || x == 0 {
        assert!(y != 0 && x != 0, "x or y should not be zero");
    }

    if (y > x) {
        assert!(y <= x, "y should be less than or equal to x");
    }
    x / y
}
