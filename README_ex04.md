
````
starknet-compile contracts/ERC721_exercise04.cairo --output contracts/artifacts/ERC721_exercise04.json --abi contracts/artifacts/abi/ERC721_exercise04.json
````

starknet declare --contract contracts/artifacts/ERC721_exercise04.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x2869bd087a9a5fea92df0cbed79aee585297c8bb6ef4c484148f0a1c4923fe5
Transaction hash: 0x5cc916d365a050a0656c1408498147212daab5a329675607dc07bdb571222bb

export STARKNET_WALLET="starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount"
export STARKNET_NETWORK="alpha-goerli"

starknet deploy --inputs 71804493054284 4279881 436825831324740701796223173198747385234095829983035862738080431529599979456 --network alpha-goerli --class_hash 0x2869bd087a9a5fea92df0cbed79aee585297c8bb6ef4c484148f0a1c4923fe5


Sending the transaction with max_fee: 0.000005 ETH (5426494295764 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x01192489d46824f84b2f187618e4413dc3a2c3f40eab4ee8945e11df759a7cd6
Transaction hash: 0x46271902ed48756c1ccbe0b9fb0919bf880e2a68cdd19a206ec210b52d10c4f

export CONTRACT_ADDRESS="0x01192489d46824f84b2f187618e4413dc3a2c3f40eab4ee8945e11df759a7cd6"

If we analize the Evaluator contract, we observe that ex4_declare_dead_animal expects an NFT to be assigned to the Evaluator. 

starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise04.json --function add_breeder --inputs 436825831324740701796223173198747385234095829983035862738080431529599979456

Sending the transaction with max_fee: 0.000002 ETH (1744101550013 WEI).
Invoke transaction was sent.
Contract address: 0x01192489d46824f84b2f187618e4413dc3a2c3f40eab4ee8945e11df759a7cd6
Transaction hash: 0x5740191b780e2b940d36e494334401fa1327a39b55cbbcf2b73de58a312a4a6

starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise04.json --function declare_animal --inputs 0 0 0

Sending the transaction with max_fee: 0.000005 ETH (4804151792000 WEI).
Invoke transaction was sent.
Contract address: 0x01192489d46824f84b2f187618e4413dc3a2c3f40eab4ee8945e11df759a7cd6
Transaction hash: 0x46ab26a4881875047a84a6d8bb6abd3c43d3ca90772320668270211b564f285

To transfer ownership from our address to the evaluator, use utils.py to change to felt the address evaluator contract.


starknet invoke --address ${CONTRACT_ADDRESS} --abi contracts/artifacts/abi/ERC721_exercise04.json --function transferFrom --inputs 436825831324740701796223173198747385234095829983035862738080431529599979456 1274519388635697963204543407605438159849675014318520616686163352039693617685 1 0

Sending the transaction with max_fee: 0.000004 ETH (4074754735428 WEI).
Invoke transaction was sent.
Contract address: 0x01192489d46824f84b2f187618e4413dc3a2c3f40eab4ee8945e11df759a7cd6
Transaction hash: 0x27bdfa946cf62c9b8936fe375bd620807f252c1b3fc18058f9ef652a251f8a8

