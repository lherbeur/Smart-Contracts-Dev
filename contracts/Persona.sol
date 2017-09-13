pragma solidity ^0.4.11;

import "./Owned.sol";
import "./ConsensusX.sol";

contract Persona is Owned {

    address public personaOwner;
    /*struct Token {
        string name;
        string symbol;
        address tokenAddress;
        uint value;
    }*/

    mapping (bytes8 => address) public supportedTokens;//maps d SYM of d token & the token contract address
    //mapping (bytes8 => Token) public tokenMapping;

    uint8[] public tokenKeys;

    event LogEtherSent(address recipient, uint amount, uint balance);
    event LogEtherReceived(address sender, uint amount, uint balance);

    function Persona(address ConsensusxAddr) {

        personaOwner = ConsensusxAddr;
    }

    function addToken(bytes8 tokenSymbol, address tokenAddr) returns (bool) {

      supportedTokens[tokenSymbol] = tokenAddr;
      return true;
    }

    function removeToken(bytes32 tokenSymbol) returns (bool) {

      delete supportedTokens[tokenSymbol];
      return true;
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
