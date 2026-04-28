/// Interface representing `Counter`.
/// This interface allows modification and retrieval of the contract's storage count.
#[starknet::interface]
pub trait ICounter<T> {
    /// Increase count.
    fn increase_count(ref self: T, amount: u32);
    /// Retrieve count.
    fn get_count(self: @T) -> u32;
    /// Retrieve owner.
    fn get_owner(self: @T) -> starknet::ContractAddress;
}

/// Simple contract for managing count with ownership and events.
#[starknet::contract]
mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use starknet::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        count: u32,
        owner: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    #[generate_trait]
    impl PrivateImpl of PrivateTrait {
        fn assert_only_owner(self: @ContractState) {
            assert(get_caller_address() == self.owner.read(), 'Caller is not owner');
        }
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            self.assert_only_owner();
            assert(amount != 0, 'Amount cannot be 0');
            let new_count = self.count.read() + amount;
            self.count.write(new_count);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }

        fn get_owner(self: @ContractState) -> starknet::ContractAddress {
            self.owner.read()
        }
    }
}
