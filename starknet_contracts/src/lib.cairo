mod arithmetic;

use arithmetic::{add, subtract};
use starknet::{ContractAddress, get_caller_address};

/// Interface representing `HelloContract`.
/// This interface allows modification and retrieval of the contract's storage count.
#[starknet::interface]
pub trait ICounter<T> {
    /// Increase count.
    fn increase_count(ref self: T, amount: u32);
    /// Retrieve count.
    fn get_count(self: @T) -> u32;
    fn only_owner(self: @T);
    fn reduce_count(ref self: T, amount: u32);
}

/// Simple contract for managing count.
#[starknet::contract]
mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use super::{add, subtract};
    use super::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        count: u32,
        owner: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }
    
    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        
        fn only_owner(self: @ContractState) {
            let caller = get_caller_address();
            assert(caller == self.owner.read(), 'Not owner');
        }

        fn increase_count(ref self: ContractState, amount: u32) {
            self.only_owner();
            assert(amount != 0, 'Amount cannot be 0');
            self.count.write(add(self.count.read(), amount));
        }

        fn reduce_count(ref self: ContractState, amount: u32) {
            self.only_owner();
            assert(amount != 0, 'Amount cannot be 0');
            self.count.write(subtract(self.count.read(), amount));
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
