
pub fn add(x: u32, y: u32) -> u32 {
    x + y
}

pub fn subtract(x: u32, y: u32) -> u32{
    assert(x > 0, 'x must be greater than 0');
    assert(x > y, 'y cant be greater than x');
    x - y
}

pub fn multiply(x: u32, y: u32) -> u32 {
    let x_u256: u256 = x.into();
    let y_u256: u256 = y.into();

    let result = x_u256 * y_u256;
    assert(result <= 255, 'Overflow');
    result.try_into().unwrap()
}

pub fn divisio(x: u32, y:u32) -> u32 {
    assert(y != 0, 'Undefined');
    let x_u256: u256 = x.into();
    let y_u256: u256 = y.into();

    let result = x_u256 / y_u256;
    assert(result <= 255, 'Overflow');
    result.try_into().unwrap()
}