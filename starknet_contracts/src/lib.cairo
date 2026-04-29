/// Interface representing `HelloContract`.
/// This interface allows modification and retrieval of the contract's storage count.
#[starknet::interface]
pub trait ICounter<T> {
    /// Increase count.
    fn increase_count(ref self: T, amount: u32);
    /// Retrieve count.
    fn get_count(self: @T) -> u32;
}

/// Simple contract for managing count.
#[starknet::contract]
mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use starknet::get_caller_address;

    #[storage]
    struct Storage {
        count: u32,
        owner: felt252,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.owner.write(get_caller_address().into());
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            // Only owner check
            assert(self.owner.read() == get_caller_address().into(), 'Caller is not the owner');
            
            assert(amount != 0, 'Amount cannot be 0');
            // Read current count and add the amount
            let current_count = self.count.read();
            self.count.write(current_count + amount);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
