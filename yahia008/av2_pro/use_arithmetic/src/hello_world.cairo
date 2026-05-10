use arithmetic_logic::mylogic;
#[executable]

fn main() {

    let add_result = mylogic::add_num(10, 5);
    assert!(add_result == 15, "result must be 15 ");

    let sub_result = mylogic::sub_num(10, 5);
    assert!(sub_result == 5, "result mudt be 5");

    let mul_result = mylogic::multiply_number(10, 5);
    match mul_result {
        Result::Ok(v) => {
            assert!(v==50, "assertion failed")
            println!("mul value {}", v)
        },
        Result::Err(_) => println!("mul error"),
    };


    let div_result = mylogic::divide(10, 2);
    match div_result {
        Result::Ok(v) => {
            assert!(v==5, "assertion failed")
            println!("div value {}", v)
        },
        Result::Err(_) => println!("div error", ),
    };

}
