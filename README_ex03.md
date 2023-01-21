If you want to consult the values of the account that you deploy using the openzepellin wallet, we use 

````
cat ~/.starknet_accounts/starknet_open_zeppelin_accounts.json
````
and we are going to convert the address to felt using the utils.py file
 python -i utils.py
>>> hex_to_felt("0xf73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0")
436825831324740701796223173198747385234095829983035862738080431529599979456 <---value to use in the deploy

````
starknet-compile contracts/ERC721_exercise03.cairo --output contracts/artifacts/ERC721_exercise03.json --abi contracts/artifacts/abi/ERC721_exercise03.json
````

starknet declare --contract contracts/artifacts/ERC721_exercise03.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x7a97ff503657f92605da8c7dd45ed99a0b03accc5617ef6d274549789059d78
Transaction hash: 0x383efb51ba9ed52ac167c7dd7e5f99f9a6bab745637715029e87975de3b744d

starknet deploy --inputs 71804493054284 4279881 436825831324740701796223173198747385234095829983035862738080431529599979456 --network alpha-goerli --class_hash 0x7a97ff503657f92605da8c7dd45ed99a0b03accc5617ef6d274549789059d78

Sending the transaction with max_fee: 0.000003 ETH (2897580079381 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a <--- use it in voyager or CLI
Transaction hash: 0xc7a63ac4a9390874866036ee033b9872ec526cd5a51747a8808df877669450

Now that our contract is deployed, we can interact using voyager or StarkNet's CLI

Using Voyager if we want to execute the function declare_animal, this fail because we are not registered as a breeder.

To use the CLI, first let's set up some useful variable
export STARKNET_WALLET="starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount"
export CONTRACT_ADDRESS="0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a"
export STARKNET_NETWORK="alpha-goerli"

and run the following 

starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function declare_animal --inputs 2 2 2

This command also fails because we are not registeres as a breeder.

To add a breeder, we need to execute add_breeder function. You can choose if use voyager or CLI. The command using CLI is:

starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function add_breeder --inputs 436825831324740701796223173198747385234095829983035862738080431529599979456

The input of this command is the address as a felt that we obtain using utils.py

Sending the transaction with max_fee: 0.000001 ETH (1114855924301 WEI).
Invoke transaction was sent.
Contract address: 0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a
Transaction hash: 0x5fe263d491c081a4f5879fd514201a063bfdd97aab56ce6e2d2cf201cf7e76a <--- to use it in CLI

To verify the transaction status, we use the CLI command:

starknet tx_status --hash 0x5fe263d491c081a4f5879fd514201a063bfdd97aab56ce6e2d2cf201cf7e76a

We obtain:

{
    "block_hash": "0x15b602d08c98297b28b858cade9bbb67f8e098f93a696317a29e27cdd1f8e0f",
    "tx_status": "ACCEPTED_ON_L2"
}

To verify that the breeder was added correctly, we use get_is_breeder function

starknet call --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function get_is_breeder --inputs 436825831324740701796223173198747385234095829983035862738080431529599979456 

Note. Input is hex value obtained with utils.py

If result is equal to 1 (true), 0 (false)

Now that we are registered as a breeder, we can call declare_animal function again. 
starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function declare_animal --inputs 2 2 2

Sending the transaction with max_fee: 0.000003 ETH (2894617726616 WEI).
Invoke transaction was sent.
Contract address: 0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a
Transaction hash: 0x24e019b12e04d7e235f2ed02319abe84733e9dcb103137f6c047e6dbc48a637

To verify that NFT with token_id 1 was created correctly and has the provided characteristics, we use the get_animal_characteristics function. Just remember that token_id is a uint256 not a felt, so we need to put "1 0", because this is how the number 1 is represented.

starknet call --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function get_animal_characteristics --inputs 1 0

>>> 2 2 2 <---- it's correct....

To evaluate this exercise, the "Evaluator.cairo" contract will try to call the declare_animal function, so we add this contract as a breeder. Let's remember that we need to change the hex address of the evaluator to a felt representation, so again use the utils.py file 

python -i utils.py 
>>> hex_to_felt("0x2d15a378e131b0a9dc323d0eae882bfe8ecc59de0eb206266ca236f823e0a15")
1274519388635697963204543407605438159849675014318520616686163352039693617685 <---felt address

Run the command: 
starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function add_breeder --inputs 1274519388635697963204543407605438159849675014318520616686163352039693617685

Sending the transaction with max_fee: 0.000001 ETH (1480388594855 WEI).
Invoke transaction was sent.
Contract address: 0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a
Transaction hash: 0x12ee94bcd5cdc3fb31739fc5d2c2420c4800ca08ba7cd419769b22393de94f6

To keep our points in the same address and to use our argent wallet, we need to transfer the ownership of the contract. We call the function transferOwnership

starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise03.json --function transferOwnership --inputs 570996064690495235118339479854624184141230437508569589214736207591531188957 <--- argent wallet address as a felt, we obtain this value in exercise 1

Sending the transaction with max_fee: 0.000002 ETH (1508580571844 WEI).
Invoke transaction was sent.
Contract address: 0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a
Transaction hash: 0x10a39b66fb9e4b410cd6242b8dbfe6e94cc43074e77ddddc997f174eef1ff64

Let's go to voyager, use the evaluator address and we are going to call the function submit_exercise, the address that we need to use is the contrant address that we obtain after deploying the contract and that we declare using export.


export CONTRACT_ADDRESS="0x0754c2490bf3d76eeb72bb53ad0f8c9b888c646ebe139d08849780a65f3e0c2a" <--- This address

Next, call the function ex_declare_new_animal to earn the points. 