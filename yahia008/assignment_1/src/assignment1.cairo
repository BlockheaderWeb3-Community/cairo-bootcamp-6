use core::num::traits::CheckedMul;
use core::num::traits::CheckedAdd;
use core::num::traits::CheckedSub;

#[derive(Drop)]
enum MathError {
    Overflow,
    DivisionByZero,
    Underflow,
}


#[executable]
fn main() {
    let add_result = add_number(10, 5);
    match add_result {
        Result::Ok(v) => {
            assert!(v==15, "assertion failed")
            println!("add value {}", v)
        },
        Result::Err(_) => println!("add error ", ),
    };

    let mul_result = multiply_number(10, 5);
    match mul_result {
        Result::Ok(v) => {
            assert!(v==50, "assertion failed")
            println!("mul value {}", v)
        },
        Result::Err(_) => println!("mul error"),
    };


    let div_result = divide(10, 2);
    match div_result {
        Result::Ok(v) => {
            assert!(v==5, "assertion failed")
            println!("div value {}", v)
        },
        Result::Err(_) => println!("div error", ),
    };

    let sub_result = sub_num(10, 7);
    match sub_result {
        Result::Ok(v) => {
             assert!(v==3, "assertion failed")
            println!("sub value {}", v)
        },
        Result::Err(_) => println!("sub error"),
    };
}



fn add_number(x: u128, y: u128) -> Result<u128, MathError> {
    x.checked_add(y).ok_or(MathError::Overflow)
}

fn multiply_number(x:u128, y:u128) -> Result<u128, MathError> {
    x.checked_mul(y).ok_or(MathError::Overflow)
}

fn divide(x: u128, y: u128) -> Result<u128, MathError>{
    if y == 0 {
        return Result::Err(MathError::DivisionByZero);
    }

    Result::Ok(x / y)
}

fn sub_num(x:u128, y:u128) -> Result<u128, MathError>{
      x.checked_sub(y).ok_or(MathError::Underflow)
}

