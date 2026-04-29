pub fn add_num(x: u32, y: u32) -> u32 {
    x + y
}

pub fn sub_num(x: u32, y: u32) -> u32 {
    if y > x {
        panic!("Sub underflow");
    }
    x - y
}

pub fn mul_num(x: u32, y: u32) -> u32 {
    let wide_x: u64 = x.into();
    let wide_y: u64 = y.into();
    let result = wide_x * wide_y;

    if result > 4294967295_u64 {
        panic!("Mul overflow");
    }

    result.try_into().unwrap()
}

pub fn div_num(x: u32, y: u32) -> u32 {
    if y == 0 {
        panic!("Cannot divide 0");
    }
    x / y
}
