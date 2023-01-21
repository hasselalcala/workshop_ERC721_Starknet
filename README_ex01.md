# Solution exercise 1
CREATE AN ACCOUNT 
starknet new_account
Account address: 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0
Public key: 0x036e82e802ccef569fb34f3e3c8f3a4239f2b7630cbc1e395d48f7dcb9a0791d
Move the appropriate amount of funds to the account, and then deploy the account
by invoking the 'starknet deploy_account' command.

deploy_account
Sending the transaction with max_fee: 0.000061 ETH (61138264493465 WEI).
Sent deploy account contract transaction.

Contract address: 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0
Transaction hash: 0x1ffd269a5be5337e98eddb16f7f928738d5e8eecc409b909bdd2f98860b52a4


First we create a new contract in the contracts directory, "ERC721_exercise01.cairo" and copy the contract that provide in the link [here](https://github.com/OpenZeppelin/cairo-contracts/blob/release-v0.5.0/src/openzeppelin/token/erc721/presets/ERC721MintableBurnable.cairo)

We compile the contract as follows 

````
starknet-compile contracts/ERC721_exercise01.cairo --output contracts/artifacts/ERC721.json
````

If everything is ok, now we are going to check our contructor. This constructor expects 3 arguments
name, symbol and owner, this arguments are declared as felt type but we are going to define name and symbol arguments as a string. We use the "utils.py" file to transform string or hex to a felt and then use the correct values to send it to the constructor. 

Run the following:

python -i utils.py 
>>> str_to_felt("ANIMAL")
71804493054284  <--- argument 1
>>> str_to_felt("ANI")
4279881 <--- argument 2
>>> hex_to_felt("0x01432C1d26d4b210A8cd7e3418F5aad4886FCA75b579da88D73c3C0902E192dD") <---- we use the argent wallet address
570996064690495235118339479854624184141230437508569589214736207591531188957 <--- argument 3


With this arguments, we can declare and deploy our contract. 

starknet declare --contract contracts/artifacts/ERC721.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x4769fe9a34a934c169acbc3cb4d7e0a14c66545ca2eed0df9ab658c1015e596 <-- use this value to deploy the contract
Transaction hash: 0x2f5d5541776af32faf248458dd728e4c43e92d1b36ecfcd1acb733432782d96

starknet deploy --inputs 71804493054284 4279881 570996064690495235118339479854624184141230437508569589214736207591531188957 --network alpha-goerli --class_hash 0x4769fe9a34a934c169acbc3cb4d7e0a14c66545ca2eed0df9ab658c1015e596

Sending the transaction with max_fee: 0.000047 ETH (47144915646299 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x070f817332ad396a21104e5371a87a010a277b8f0276e7243444d0c8f14c1f67 <--- value to submit exercise
Transaction hash: 0x62b158213206414e93855485dedfd7a2c8cc886c8be0444f73a50f3566e96d1

Once the contract is deploy we going to the ERC721_exercise01.cairo contract and mint a new token, we use the address of the evaluator contract that is publish in the official repo and the token_id is 1. Once we mint, in the ERC721_exercise01.cairo, we use the ownerOf() function and verify that the owner is the evaluator, it it is correct, we go to the Evaluator.cairo contract and using the function submit_exercise, we use the contract address.

Once the transaction is processed, we use the function ex1_test_erc721 to verify and obtain the points. To verify that our Argent X account has gotten the points, run the pointer counter smart contract

