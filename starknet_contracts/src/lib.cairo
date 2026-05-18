/// Interface representing `HelloContract`.
/// This interface allows modification and retrieval of the contract's storage count.

mod arithmetic;
#[starknet::interface]
pub trait ICounter<T> {
    /// Increase count.
    fn increase_count(ref self: T, amount: u32);
    /// Retrieve count.
    fn get_count(self: @T) -> u32;
}

/// Simple contract for managing count.
#[starknet::contract]
pub mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use starknet::{ContractAddress, get_caller_address};
    use super::arithmetic::{add_num};

    #[storage]
    struct Storage {
        count: u32,
        owner: ContractAddress,    
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner); // no .into() needed    }
    }

    #[generate_trait]
    impl PrivateImpl of PrivateTrait {
        fn assert_only_owner(self: @ContractState ) {
            assert(get_caller_address() == self.owner.read(), 'Caller not the Owner');
        }
    }
   


    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {

            // Only owner 
            self.assert_only_owner();
            assert(amount != 0, 'Amount cannot be 0');

            // Read current count and add the amount
            let current_count = self.count.read();
            let new_count = add_num(current_count, amount);
            self.count.write(new_count);

            assert(new_count == current_count + amount, 'Count increase failed');
        }


        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
