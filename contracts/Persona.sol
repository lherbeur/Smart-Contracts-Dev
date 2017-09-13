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
        mapping (address => bytes) data;
    } 

    mapping (bytes8 => address) public supportedTokens;//maps d SYM of d token & the token contract address
    //mapping (bytes8 => Token) public tokenMapping;

    uint8[] public tokenKeys;

    event LogEtherSent(address recipient, uint amount, uint balance);
    event LogEtherReceived(address sender, uint amount, uint balance);

    function Persona(address ConsensusxAddr) {

        personaOwner = ConsensusxAddr;
    }

    function addToken(address tokenAddr) returns (bool) {

    }

    function removeToken(address tokenAddr) returns (bool) {

    }

    function modifyToken(address tokenAddr) returns (bool) {


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

    /**
    * @dev fallback function to be called (ERC223 standard)
    * @param _from address of oken sender
    * @param _value amount of Tokens sent
    * @param _data data sent with transaction
    */
    function tokenFallback(address _from, uint _value, bytes _data){
        //check if token is supported or exists in record
        //call addTokens if it does not, modifyTokens if it does.
        Token tkn;
        tkn.value = _value;
        tkn.data[_from] = _data;
    }

    // constant getter functions
    function displayEthBalance() constant returns (uint) {

    }

    function displayTokenBalance(bytes32 symbol, address tokenAddress) constant returns (uint) {

    }

    function() payable {
        LogEtherReceived(msg.sender, msg.value, this.balance);
    }
}
