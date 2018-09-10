// Import name hash
const namehash = require('eth-ens-namehash');

// Get subdomain reg instance
SubdomainRegistrar.deployed().then(inst => { regInst = inst });

// get accounts
ac0 = web3.eth.accounts[0];

// Get ENS instance
ENSRegistry.deployed().then(inst => { ensInst = inst })

subnode = namehash.hash('username')

// Register subnode: username
regInst.register(subnode, {from: ac0})

