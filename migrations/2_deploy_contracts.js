let SubdomainRegistrar = artifacts.require("./SubdomainRegistrar.sol");
let PublicResolver = artifacts.require("./PublicResolver.sol");
let ENS = artifacts.require("ENSRegistry.sol");

const namehash = require('eth-ens-namehash');

function devDeploy(deployer, rootNode) {
  deployer.deploy(ENS)
    .then(() => {
      return deployer.deploy(PublicResolver, ENS.address);
    })
    .then(() => {
      return deployer.deploy(SubdomainRegistrar, ENS.address, namehash.hash(rootNode), PublicResolver.address)
    });
}

function prodDeploy(deployer) {
  // Don't deploy ENSRegistry or PublicResolver

  // const PUBLIC_RESOLVER_RINKEBY_CONTRACT_ADDRESS = "0x78eC43974a0dF993730c2c88398aA010783cE7C9"

}

module.exports = function(deployer, network) {

  let rootNode = 'decentpass.eth';

  if (network === 'dev') {
    devDeploy(deployer, rootNode);
  } else if (network === 'prod') {
    prodDeploy(deployer);
  }
};
