use arithmetic_logic::mylogic;
use starknet::{ContractAddress};
#[starknet::interface]
pub trait ICounter<T> {
    fn get_count(self: @T) -> u128;
    fn get_owner(self: @T) -> ContractAddress;
    fn transfer_ownership(ref self: T, new_owner: ContractAddress);
    fn increase_count(ref self: T, amount: u128);
    fn decrease_count (ref self:T, amount:u128);
    fn reset_count(ref self:T);    
}

#[starknet::contract]
mod CounterV2{
       
use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

       use super::ICounter;
       use starknet::ContractAddress;
       use starknet::get_caller_address;
       use super::mylogic;

        #[storage]
        struct Storage{
        count:u128,
        owner:ContractAddress
    }

    #[constructor]
    fn constructor(ref self:ContractState, initial_owner:ContractAddress){
        self.owner.write(initial_owner);
        self.count.write(0);
    }

     #[abi(embed_v0)]
     impl ICounterimpl of ICounter<ContractState> {

        fn get_count(self: @ContractState) -> u128 {
            self.count.read()
        }
        fn get_owner(self: @ContractState) -> ContractAddress{
            self.owner.read()
        }
        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress){
            let caller = get_caller_address();
            assert!(caller == self.owner.read(), "Only owner can transfer");
            self.owner.write(new_owner);
        }
        fn increase_count(ref self: ContractState, amount: u128){
            let caller:ContractAddress = get_caller_address();
             assert!(caller == self.owner.read(), "Only owner can change state");
             
            let current = self.count.read();
            let new:u128 = mylogic::add_num(current, amount);
            self.count.write(new);
        }
        fn decrease_count (ref self:ContractState, amount:u128){
            let caller:ContractAddress = get_caller_address();
             assert!(caller == self.owner.read(), "Only owner can change state");
             
            let current = self.count.read();
            let new:u128 = mylogic::sub_num(current, amount);
            self.count.write(new);
        }
        fn reset_count(ref self:ContractState){
            let caller = get_caller_address();
               assert!(caller == self.owner.read(), "Only owner can change state");
                let new:u128 = mylogic::reset_count();
                self.count.write(new);
        }
     }
}