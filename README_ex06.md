Open the Dummy ERC721 token contract using voyager and go to claim function, call this function using you argent wallet address.

Once the transaction finished, we use https://testnet.aspect.co/ connect our wallet and we can see our new minted NFT.

Now, we need the token_id of the generated NFT, again open the Dummy ERC721 token contract using voyager and call the next_token_id function. Remember that this is the value for the next NFT, the actual value to use is the value that we obtain minus 1, in my case is 58. 

To claim our points, go to evaluator contract using voyager and call the function ex6_claim_metadata_token using the token_id that we obtain in the Dummy ERC721 token contract