use core::result;
use core::panic_with_felt252;

#[executable]
fn main() {
    // Addition
    let addResult: u32 = add_num(20, 7);
    println!("the sum of x & y is: {}", addResult);

    // Subtraction
    let sub_result: Result<u32, felt252> = sub_num(16, 9);
    match sub_result {
        Result::Ok(value) => {
            println!("sub result is: {}", value);
            // assert(sub_result == 7, 'Invalid difference logic');            
        },
        Result::Err(err) => { panic_with_felt252(err); },
    }

    // Multiplication
    let multiplication_result: u32 = multiply_num(5, 6);
    println!("The multiplication of x and y is: {}", multiplication_result);

    // Division 
    let division_result = divide_num(0, 10);
    match division_result {
        Result::Ok(value) => { 
            println!("Dividing x and y will give you: {}", value); 
        },
        Result::Err(err) => { 
            panic_with_felt252(err);
        },
    }
}

#[derive(Drop)]
enum Result<T, E> {
    Ok: T,
    Err: E,
}

// addition logic
fn add_num(x: u32, y: u32) -> u32 {
    let result: u32 = x + y;
    return result;
}

// subtraction logic
fn sub_num(x: u32, y: u32) -> Result<u32, felt252> {
    if x < y {
        Result::Err('Subtraction error')
    } else {
        Result::Ok(x - y)
    }
}

// multiplication logic
fn multiply_num(x: u32, y: u32) -> u32 {
  x * y  
}

// division function
fn divide_num(x: u32, y: u32) -> Result<u32, felt252> {
  if y == 0 {
    Result::Err('Division by zero is not allowed')
  } else {
    Result::Ok(x / y)
  }
}


