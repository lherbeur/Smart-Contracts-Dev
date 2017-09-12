pragma solidity ^0.4.11;

import "./Owned.sol";
import "./ConsensusX.sol";

contract Persona is Owned {

    address public personaOwner;
    struct Token {
        string name;
        string symbol;
        address tokenAddress;
        uint value;
    } 
    
    mapping (bytes8 => Token) public tokenMapping;
    uint8[] public tokenKeys;
    
    event LogEtherSent(address recipient, uint amount, uint balance);
    event LogEtherReceived(address sender, uint amount, uint balance);
    
    function Persona(address ConsensusxAddr) {
        personaOwner = ConsensusxAddr;
    }
    
    function addTokens(address tokenAddr) returns (bool) {
        
    }
    
    function removeTokens(address tokenAddr) returns (bool) {
        
    }
    
    function doesTokenExist(bytes8 symbol) returns (bool) {
        
    }
    
    function sendEther(uint amount) returns (bool) {
        
    }
    
    function receiveEther(uint amount) payable returns (bool) {
        
    }
    
    function displayEthBalance() constant returns (uint) {
        
    }
    
    function displayTokenBalance(bytes32 symbol, address tokenAddress) constant returns (uint) {
        
    }

    function() {
        throw;
    }
}