To deploy this contract, we add a new input that is the address of the dummy token as a felt. Let's use our utils.py file again
python -i utils.py 
>>> hex_to_felt("0x52ec5de9a76623f18e38c400f763013ff0b3ff8491431d7dc0391b3478bf1f3")
2344204853301408646930413631119760318685682522206636282740794249760712946163

starknet-compile contracts/ERC721_exercise05.cairo --output contracts/artifacts/ERC721_exercise05.json --abi contracts/artifacts/abi/ERC721_exercise05.json

starknet declare --contract contracts/artifacts/ERC721_exercise05.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x2a63e060530a4b25d2f56e40bfde159cb5147827c16f8033a048dc192d8e1f3
Transaction hash: 0x46707c2b0b94ce4b75a50f1f729f217c7030c4c471e1a27d08de43b71156f74

export STARKNET_WALLET="starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount"
export STARKNET_NETWORK="alpha-goerli"

starknet deploy --inputs 71804493054284 4279881 436825831324740701796223173198747385234095829983035862738080431529599979456 2344204853301408646930413631119760318685682522206636282740794249760712946163 --network alpha-goerli --class_hash 0x2a63e060530a4b25d2f56e40bfde159cb5147827c16f8033a048dc192d8e1f3

Sending the transaction with max_fee: 0.000000 ETH (222452449089 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x05114838af7e450f42baf2ee5626be6c9d3e4a2f610bc99e352a57c10a565112
