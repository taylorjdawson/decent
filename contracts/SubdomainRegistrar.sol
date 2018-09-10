pragma solidity ^0.4.0;

import './ENS.sol';
import './Resolver.sol';

/**
 * A registrar that allocates subdomains to the first person to claim them.
 */
contract SubdomainRegistrar {
  ENS ens;
  bytes32 rootNode;
  Resolver resolver; // Default resolver

  modifier only_owner(bytes32 subnode) {
    address currentOwner = ens.owner(keccak256(rootNode, subnode));
    require(currentOwner == 0 || currentOwner == msg.sender);
    _;
  }

  event NameRegistered(bytes32 indexed node, address owner);
  event NameDeregistered(bytes32 indexed node);

  /**
   * Constructor.
   * @param ensAddr The address of the ENS registry.
   * @param node The node that this registrar administers.
   * @param _resolver The default resolver where to point all subdomains
   */
  constructor(ENS ensAddr, bytes32 node, Resolver _resolver) public {
    resolver = _resolver;
    ens = ensAddr;
    rootNode = node;
  }

  /**
    * Checks to see if a name has been previously registered
    * @param subnode The hash of the label to register.
    */
  function nameExists(bytes32 subnode) public view returns (bool){
    return (ens.owner(keccak256(rootNode, subnode)) != 0);
  }

  /**
   * Register a name, or change the owner of an existing registration.
   * @param subnode The hash of the label to register.
   */
  function register(bytes32 subnode, bytes ipfsHash, bytes32 x, bytes32 y) public only_owner(subnode) {
    address owner = msg.sender;
    bytes32 node = keccak256(rootNode, subnode);

    ens.setResolver(keccak256(rootNode, subnode), resolver);

    // Sets this contract as the owner of the subdomain in order to apply attributes
    ens.setSubnodeOwner(rootNode, subnode, this);

    ens.setResolver(node, resolver);

    resolver.setMultihash(node, ipfsHash);

    resolver.setPubkey(node, x, y);

    // Pass ownership off to the msg.sender
    ens.setSubnodeOwner(rootNode, subnode, owner);

    emit NameRegistered(subnode, owner);
  }



  function deregister(bytes32 subnode) public only_owner(subnode) {
    ens.setSubnodeOwner(rootNode, subnode, 0);
    //CONSIDER: Reset resolver?
    emit NameDeregistered(subnode);
  }
}
