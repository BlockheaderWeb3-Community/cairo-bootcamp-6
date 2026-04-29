#[starknet::interface]
pub trait ICounterV2<T> {
    fn increase_count(ref self: T, amount: u32);
    fn reduce_count(ref self: T, amount: u32);
    fn get_count(self: @T) -> u32;
    fn get_owner(self: @T) -> starknet::ContractAddress;
}

#[starknet::contract]
pub mod CounterV2 {
    use cairo_6::arithmetic_v2::{add_num, sub_num};
    use starknet::get_caller_address;
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        owner: ContractAddress,
        count: u32,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    fn assert_only_owner(self: @ContractState) {
        let caller = get_caller_address();
        let owner = self.owner.read();
        assert(caller == owner, 'Only owner');
    }

    #[abi(embed_v0)]
    impl CounterV2Impl of super::ICounterV2<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            assert_only_owner(@self);
            assert(amount != 0, 'Amount cannot be 0');

            let current_count = self.count.read();
            let updated_count = add_num(current_count, amount);
            self.count.write(updated_count);
        }

        fn reduce_count(ref self: ContractState, amount: u32) {
            assert_only_owner(@self);
            assert(amount != 0, 'Amount cannot be 0');

            let current_count = self.count.read();
            let updated_count = sub_num(current_count, amount);
            self.count.write(updated_count);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }

        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
    }
}
