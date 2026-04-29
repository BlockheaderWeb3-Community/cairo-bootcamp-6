/// Adds two numbers and returns the result.
pub fn add_num(x: u32, y: u32) -> u32 {
    x + y
}

/// Subtracts y from x. Returns an error felt if x < y.
pub fn sub_num(x: u32, y: u32) -> Result<u32, felt252> {
    if x < y {
        Result::Err('Subtraction error')
    } else {
        Result::Ok(x - y)
    }
}
