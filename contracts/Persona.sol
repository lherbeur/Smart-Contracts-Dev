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
    
    function Persona(address ConsensusxAddr) {
        personaOwner = ConsensusxAddr;
    }
    
    function addTokens(address tokenAddr) {
        
    }
    
    function removeTokens(address tokenAddr) {
        
    }
    
    function doesTokenExist(bytes8 symbol) {
        
    }

    function() {
        throw;
    }
}