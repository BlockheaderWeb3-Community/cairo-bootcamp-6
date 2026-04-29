#[starknet::interface]
trait ICounter<TContractState> {
    fn get_count(self: @TContractState) -> u8;
    fn increase_count(ref self: TContractState, amount: u8);
    fn reduce_count(ref self: TContractState, amount: u8);
}

#[starknet::contract]
pub mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use crate::{add_num, sub_num};

    #[storage]
    struct Storage {
        owner: starknet::ContractAddress,
        count: u8,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CountIncreased: CountIncreased,
        CountDecreased: CountDecreased,
    }

    #[derive(Drop, starknet::Event)]
    struct CountIncreased { by: u8, new_value: u8 }

    #[derive(Drop, starknet::Event)]
    struct CountDecreased { by: u8, new_value: u8 }

    #[constructor]
fn constructor(ref self: ContractState, owner: starknet::ContractAddress, initial_count: u8) {
    self.owner.write(owner);
    self.count.write(initial_count);
}

    fn assert_only_owner(self: @ContractState) {
        assert(
            starknet::get_caller_address() == self.owner.read(),
            'Caller is not the owner'
        );
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {

        fn get_count(self: @ContractState) -> u8 {
            self.count.read()
        }

        fn increase_count(ref self: ContractState, amount: u8) {
            assert_only_owner(@self);
            let current = self.count.read();
            let new_value = add_num(current, amount);
            self.count.write(new_value);
            self.emit(CountIncreased { by: amount, new_value });
        }

        fn reduce_count(ref self: ContractState, amount: u8) {
            assert_only_owner(@self);
            let current = self.count.read();
            let new_value = match sub_num(current, amount) {
                Result::Ok(value) => value,
                Result::Err(err)  => panic!("{}", err),
            };
            self.count.write(new_value);
            self.emit(CountDecreased { by: amount, new_value });
        }
    }
}