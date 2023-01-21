// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.5.0 (token/erc721/presets/ERC721MintableBurnable.cairo)

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.cairo.common.uint256 import Uint256, uint256_add, uint256_check, uint256_lt


from openzeppelin.access.ownable.library import Ownable
from openzeppelin.introspection.erc165.library import ERC165
from openzeppelin.token.erc721.library import ERC721

from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.token.erc721.enumerable.library import ERC721Enumerable
from starkware.cairo.common.math import split_felt, assert_not_zero, assert_nn

struct Animal{
    sex : felt,
    legs : felt,
    wings : felt,
}

@storage_var
func animals(token_id : Uint256) -> (animal: Animal) {
}


@storage_var
func last_token_id() -> (token_id: Uint256) {
}

@storage_var
func is_breeder(breeder_address : felt) -> (is_breeder: felt) {
}

//
// Constructor
//

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, symbol: felt, owner: felt
) {
    ERC721.initializer(name, symbol);
    Ownable.initializer(owner);
    token_id_initializer();
    return ();
}

func token_id_initializer{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let zero_as_uint256 : Uint256 = Uint256 (0,0);
    last_token_id.write(zero_as_uint256);
    return ();
}

//
// Getters
//

@view
func supportsInterface{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    interfaceId: felt
) -> (success: felt) {
    return ERC165.supports_interface(interfaceId);
}

@view
func name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    return ERC721.name();
}

@view
func symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    return ERC721.symbol();
}

@view
func balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(owner: felt) -> (
    balance: Uint256
) {
    return ERC721.balance_of(owner);
}

@view
func ownerOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(tokenId: Uint256) -> (
    owner: felt
) {
    return ERC721.owner_of(tokenId);
}

@view
func getApproved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256
) -> (approved: felt) {
    return ERC721.get_approved(tokenId);
}

@view
func isApprovedForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, operator: felt
) -> (isApproved: felt) {
    let (isApproved: felt) = ERC721.is_approved_for_all(owner, operator);
    return (isApproved=isApproved);
}

@view
func tokenURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    tokenId: Uint256
) -> (tokenURI: felt) {
    let (tokenURI: felt) = ERC721.token_uri(tokenId);
    return (tokenURI=tokenURI);
}

@view
func owner{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (owner: felt) {
    return Ownable.owner();
}

@view
func get_animal_characteristics{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256) -> (sex: felt, legs: felt, wings: felt) {

    with_attr error_message("The token_id is not a Uint256"){
        uint256_check(token_id);
    }
    
    let animal = animals.read(token_id);
    let animal_ptr = cast(&animal, Animal*); 
    return (sex=animal_ptr.sex, legs=animal_ptr.legs, wings=animal_ptr.wings);
}

@view
func get_is_breeder{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    address : felt) -> (is_true : felt){
    with_attr error_message("Address invalid, address is zero"){
        assert_not_zero(address);
    }    
    let (is_true : felt) = is_breeder.read(address);
    return (is_true,);
}

@view
func token_of_owner_by_index{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    account : felt, index : felt) -> (token_id : Uint256){

    with_attr error_message("Address invalid, address is zero"){
        assert_not_zero(account);
    }
    with_attr error_message("addres must be a positive integer"){
        assert_nn(index);
    }

    let (index_uint256) = felt_to_uint256(index);
    let (token_id) = ERC721Enumerable.token_of_owner_by_index(owner=account, index=index_uint256);
    return (token_id,);
}

func felt_to_uint256{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    felt_value : felt) -> (uint256_value : Uint256){
    let (high,low) = split_felt(felt_value);
    let uint256_value : Uint256 = Uint256(low, high);
    return (uint256_value,);    
}

//
// Externals
//

@external
func approve{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    to: felt, tokenId: Uint256
) {
    ERC721.approve(to, tokenId);
    return ();
}

@external
func setApprovalForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    operator: felt, approved: felt
) {
    ERC721.set_approval_for_all(operator, approved);
    return ();
}

@external
func transferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    from_: felt, to: felt, tokenId: Uint256
) {
    ERC721Enumerable.transfer_from(from_, to, tokenId);
    return ();
}

@external
func safeTransferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    from_: felt, to: felt, tokenId: Uint256, data_len: felt, data: felt*
) {
    ERC721Enumerable.safe_transfer_from(from_, to, tokenId, data_len, data);
    return ();
}

// @external
// func mint{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
//     to: felt, tokenId: Uint256
// ) {
//     Ownable.assert_only_owner();
//     ERC721._mint(to, tokenId);
//     return ();
// }

@external
func declare_dead_animal{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(token_id: Uint256) {
    ERC721.assert_only_token_owner(token_id);
    ERC721Enumerable._burn(token_id);
    return ();
}

@external
func setTokenURI{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    tokenId: Uint256, tokenURI: felt
) {
    Ownable.assert_only_owner();
    ERC721._set_token_uri(tokenId, tokenURI);
    return ();
}

@external
func transferOwnership{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    newOwner: felt
) {
    Ownable.transfer_ownership(newOwner);
    return ();
}

@external
func renounceOwnership{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    Ownable.renounce_ownership();
    return ();
}

@external
func declare_animal{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    sex : felt, legs : felt, wings : felt
) -> (token_id : Uint256){
    alloc_locals;
    assert_only_breeder();

    //To increment by 1 the token_id
    let current_token_id : Uint256 = last_token_id.read();
    let one_as_uint256 = Uint256(1,0);
    let (local new_token_id, _ ) = uint256_add(current_token_id,one_as_uint256);
    let (sender_address) = get_caller_address();
    
    //Mint NFT and update token_id
    ERC721Enumerable._mint(sender_address, new_token_id);
    animals.write(new_token_id, Animal(sex=sex, legs=legs, wings=wings));
    // updatig new token id
    last_token_id.write(new_token_id);
     return (token_id = new_token_id);
}

@external
func add_breeder{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    breeder_address : felt) {

    Ownable.assert_only_owner();
    with_attr error_message("Address invalid, address is zero"){
        assert_not_zero(breeder_address);
    }    
    is_breeder.write(breeder_address, 1);
    return ();
}

@external
func remove_breeder{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    breeder_address : felt) {

    Ownable.assert_only_owner();
    with_attr error_message("Address invalid, address is zero"){
        assert_not_zero(breeder_address);
    }    
    is_breeder.write(breeder_address, 0);
    return ();
}

func assert_only_breeder{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(){
    let (sender_address) = get_caller_address();
    let (is_true) = is_breeder.read(sender_address);
    with_attr error_message("This caller is not registered as a breeder"){
        assert is_true = 1;
    }
    return ();
}