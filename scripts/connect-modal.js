const Web3 = require('web3');
const web3 = new Web3('YOUR_ETHEREUM_NODE_URL'); // Replace with your Ethereum node URL

const contractAddress = 'YOUR_CONTRACT_ADDRESS';
const privateKey = 'YOUR_PRIVATE_KEY'; // The sender's private key
const playerMove = 1; // Replace with 0 for Rock, 1 for Scissors, 2 for Paper

const RockScissorsPaperContract = new web3.eth.Contract(ABI, contractAddress);

const sender = web3.eth.accounts.privateKeyToAccount(privateKey);
const gasPrice = web3.utils.toWei('10', 'gwei');

RockScissorsPaperContract.methods.play(playerMove).send({
    from: sender.address,
    value: web3.utils.toWei(BET_AMOUNT.toString(), 'ether'), // Convert BET_AMOUNT to ether
    gas: 200000, // Adjust gas limit as needed
    gasPrice: gasPrice
})
.then((receipt) => {
    console.log('Transaction receipt:', receipt);
})
.catch((error) => {
    console.error('Error:', error);
});