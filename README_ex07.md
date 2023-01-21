Open the Dummy ERC721 token contract using voyager and go to token_URI function, call this function using the token_id 1. Once the transaction finished, we obtain an array as follows:

[
[0]: https://gateway.pinata.cloud/ip, 
[1]: fs/QmWUB2TAYFrj1Uhvrgo69NDsycXf, 
[2]: bfznNURj1zVbzNTVZv/, 
[3]: 1, 
[4]: .json
]

concatenate this value and we use the URL to get the metadata of the NFT.
{
    "name": "Gan generated image 1", 
    "image": "https://gateway.pinata.cloud/ipfs/Qmd9PegtrP3c7r6uJMWTC3CMCQUTVTzqg8jtmZsxnuUAeD/1.jpeg"
}

Now we know that our contract have to return a tokenURI, we implement the contracts.

starknet-compile contracts/ERC721_exercise07.cairo --output contracts/artifacts/ERC721_exercise07.json --abi contracts/artifacts/abi/ERC721_exercise07.json

To deploy our contract, we need to check the constructor@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt,  <--- NFT name
    symbol: felt, <--- NFT symbol 
    owner: felt, <--- NFT owner argent wallet address
    base_token_uri_len: felt,  <---length array with felt values
    base_token_uri: felt*, <---  https://gateway.pinata.cloud/ipfs/QmWUB2TAYFrj1Uhvrgo69NDsycXfbfznNURj1zVbzNTVZv/
    token_uri_suffix: felt, <--- .json 
) {
    ERC721.initializer(name, symbol);
    ERC721_Metadata_initializer();
    Ownable.initializer(owner);
    ERC721_Metadata_setBaseTokenURI(base_token_uri_len, base_token_uri, token_uri_suffix);
    return ();
}

So, let's assign a name to the NFT "Hasseru NFT" with symbol "HNFT" and use the utils.py to change this strings to felt
python -i utils.py 
>>> str_to_felt("Hasseru NFT")
87502858251838267151238740
>>> str_to_felt("HNFT")
1213089364
>>> str_to_felt(".json")
199354445678
>>> hex_to_felt("0x01432C1d26d4b210A8cd7e3418F5aad4886FCA75b579da88D73c3C0902E192dD")
570996064690495235118339479854624184141230437508569589214736207591531188957

As we notice, the uri's length is more than 31 characters, so we use the array version to deal with this string.

str_to_felt_array("https://gateway.pinata.cloud/ipfs/QmWUB2TAYFrj1Uhvrgo69NDsycXfbfznNURj1zVbzNTVZv/") 
[184555836509371486644298270517380613565396767415278678887948391494588524912, 181013377130045435659890581909640190867353010602592517226438742938315085926, 2194400143691614193218323824727442803459257903]

starknet declare --contract contracts/artifacts/ERC721_exercise07.json --account=0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --network alpha-goerli --no_wallet --sender 0x00f73c129a71218c3909905f5b75ae76f1b5d2c4d1243d12986cbffc16944fc0 --max_fee 1

Declare transaction was sent.
Contract class hash: 0x7e516b38d10653848db8afac874fff126ca7b77fb37ab3170d000c3be37c7fd
Transaction hash: 0x31a468a29ce388732e5ec63dbd20d267910d63607ed4225fb393ea4a3e7b76d

export STARKNET_WALLET="starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount"
export STARKNET_NETWORK="alpha-goerli"

The inputs of our deploy command are:

name: 87502858251838267151238740
symbol: 1213089364
owner: 570996064690495235118339479854624184141230437508569589214736207591531188957
uri length: 3 
array uri: 184555836509371486644298270517380613565396767415278678887948391494588524912 181013377130045435659890581909640190867353010602592517226438742938315085926 2194400143691614193218323824727442803459257903
.json: 199354445678

To deploy our contract, run: 
starknet deploy --inputs 87502858251838267151238740 1213089364 570996064690495235118339479854624184141230437508569589214736207591531188957 3 184555836509371486644298270517380613565396767415278678887948391494588524912 181013377130045435659890581909640190867353010602592517226438742938315085926 2194400143691614193218323824727442803459257903 199354445678 --network alpha-goerli --class_hash 0x7e516b38d10653848db8afac874fff126ca7b77fb37ab3170d000c3be37c7fd

Sending the transaction with max_fee: 0.000002 ETH (1783100338790 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x06759b0cc44d04c93a4aed99a170b79f2edf395a16a3f7fb1e3da5685fa9e85d
Transaction hash: 0x743847e3a0a7119c625e11e8636cf87bcd2156d6cdf540915a0f1d5a6c7863b

Open voyager with the contract address and call the function mint using your agent wallet address and token_id 1 and when transaction finished, you can verify that the smart contract is returning the same token URI for token_id 1 using tokenURI function.

If we obtain the same URI as the Dummy ERC721 did, we can submit our exercise in the evaluator contract. 




