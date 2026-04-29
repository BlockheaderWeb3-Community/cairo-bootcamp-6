#[executable]
fn main() {
    let add_result: u8 = add_num(5, 6);
    println!("the sum of x & y is: {}", add_result);
    assert(add_result == 11, 'invalid sum logic');

    let sub_result: u8 = sub_num(10, 5);
    println!("sub result is: {}", sub_result);
    assert(sub_result == 5, 'invalid sub logic');
}

// addition logic
fn add_num(x: u8, y: u8) -> u8 {
    return x + y;
}

// subtraction logic
fn sub_num(x: u8, y: u8) -> u8 {
    // logic for returning negatgive value
    if x > y{
        return 
    }
    return x - y;
}


