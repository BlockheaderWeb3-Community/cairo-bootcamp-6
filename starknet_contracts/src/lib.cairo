/// Interface representing `HelloContract`.
/// This interface allows modification and retrieval of the contract's storage count.
#[starknet::interface]
pub trait ICounter<T> {
    /// Increase count.
    fn increase_count(ref self: T, amount: u32);
    fn decrease_count(ref self: T, amount: u32);
    /// Retrieve count.
    fn get_count(self: @T) -> u32;
}


/// Simple contract for managing count.
#[starknet::contract]
mod Counter {
    use cairo_6::integer::{add_num, sub_num};
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use starknet::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        count: u32,
        owner: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.count.write(0);
        self.owner.write(owner);
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            let caller = get_caller_address();
            assert!(caller == self.owner.read(), "Only owner can transfer");
            assert(amount != 0, 'Amount cannot be 0');

            let current_count = self.count.read();
            add_num(current_count, amount);
        }

        fn decrease_count(ref self: ContractState, amount: u32) {
            let caller = get_caller_address();
            assert!(caller == self.owner.read(), "Only owner can transfer");
            assert(amount != 0, 'Amount cannot be 0');

            let current_count = self.count.read();
            sub_num(current_count, amount);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
