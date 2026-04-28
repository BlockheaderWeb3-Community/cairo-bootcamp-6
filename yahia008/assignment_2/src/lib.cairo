use starknet::{ContractAddress, get_caller_address};
#[starknet::interface]
pub trait ICounter<T> {
    fn increase_count(ref self: T, amount: u32);
    fn transfer_ownership(ref self: T, new_owner: ContractAddress);
    fn get_count(self: @T) -> u32;
    fn get_owner(self: @T) -> ContractAddress;
   
}

#[starknet::contract]
mod CounterV2{
       use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

       use super::ICounter;
       use starknet::ContractAddress;

        #[storage]
        struct Storage{
        count:u32,
        owner:ContractAddress
    }

    #[constructor]
    fn constructor(ref self:ContractState, initial_owner:ContractAddress){
        self.owner.write(initial_owner);
    }
}