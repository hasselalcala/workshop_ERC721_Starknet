To solve this exercise, we use voyager and the Evaluator.cair contract. Connect Argent's wallet, run the function ex2a_get_animal_rank and to know which characteristics were assign randomly, call the function 

assigned_legs_number
assigned_sex_number
assigned_wings_number 

using your Argent Wallet Address

In our case, I obtain 3 for legs, 1 for sex and 2 for wings. 
````
starknet-compile contracts/ERC721_exercise02.cairo --output contracts/artifacts/ERC721_exercise02.json
````

````
starknet declare --contract contracts/artifacts/ERC721_exercise02.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x1c4d4fd5afe4340f6a04aed47f49bb7b5c48dc6fe8e8956317979f71502c07
Transaction hash: 0x605c108e78350cf2f8d88c0bf99615e43d8eb4bbb2f87d4b6adac39cdc8f14c

```

starknet deploy --inputs 71804493054284 4279881 570996064690495235118339479854624184141230437508569589214736207591531188957 --network alpha-goerli --class_hash 0x1c4d4fd5afe4340f6a04aed47f49bb7b5c48dc6fe8e8956317979f71502c07

Sending the transaction with max_fee: 0.000003 ETH (2897578031357 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x065dbb71e57e651b84694f58333f93021dca8823bd2a55af5c7894fdb138a621 <--- contract to interact and submit exercise
Transaction hash: 0x6f88d440d8c65b2c66f484b1e044ecd2b633e19833d015975542978630a1cda

To mint the nft, we use our contract address, go to voyager and interact with declare_ animal function, we add the values that we obtain previously and once the transaction is completed execute the function get_animal_characteristics to verify that the values are correct. 

Now, let's transfer the NFT to the evaluator smart contract using tranferFrom function, so we can submit our exercise in the evaluator contract. 

The arguments to tranferFrom function are:
from: your argent's address
to: evaluator contract address
token_id: 1

Also, we execute submit_exercise function using the ERC721 contract address.

To verify that the exercise is completed, call the function ex2b_test_declare_animal and we can obtain earn extra points, if the Evaluator was able to get the information about the NFT from our smart contract.  
