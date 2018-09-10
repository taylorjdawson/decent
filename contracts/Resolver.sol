pragma solidity ^0.4.18;

/**
 * A simple resolver anyone can use; only allows the owner of a node to set its
 * address.
 */
interface Resolver {

    event AddrChanged(bytes32 indexed node, address a);
    event ContentChanged(bytes32 indexed node, bytes32 hash);
    event NameChanged(bytes32 indexed node, string name);
    event ABIChanged(bytes32 indexed node, uint256 indexed contentType);
    event PubkeyChanged(bytes32 indexed node, bytes32 x, bytes32 y);
    event TextChanged(bytes32 indexed node, string indexedKey, string key);
    event MultihashChanged(bytes32 indexed node, bytes hash);

    function setAddr(bytes32 node, address addr) public;
    function setContent(bytes32 node, bytes32 hash) public;
    function setMultihash(bytes32 node, bytes hash) public;
    function setName(bytes32 node, string name) public;
    function setABI(bytes32 node, uint256 contentType, bytes data) public;
    function setPubkey(bytes32 node, bytes32 x, bytes32 y) public;
    function setText(bytes32 node, string key, string value) public;
    function text(bytes32 node, string key) public view returns (string);
    function pubkey(bytes32 node) public view returns (bytes32 x, bytes32 y);
    function ABI(bytes32 node, uint256 contentTypes) public view returns (uint256 contentType, bytes data);
    function name(bytes32 node) public view returns (string);
    function content(bytes32 node) public view returns (bytes32);
    function multihash(bytes32 node) public view returns (bytes);
    function addr(bytes32 node) public view returns (address);
    function supportsInterface(bytes4 interfaceID) public pure returns (bool);
}
