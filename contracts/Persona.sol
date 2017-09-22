pragma solidity ^0.4.11;

import "./Owned.sol";
import "./ConsensusX.sol";

contract Persona is Owned(true) {

    address public personaOwner;
    struct Token {
        string name;
        string symbol;
        address tokenAddress;
        address senderAddress;
        address txOriginAddress;
        uint value;
        mapping (address => bytes) data;
        mapping (address => bytes4) sig;
    }

    mapping (bytes8 => address) public supportedTokens;//maps d SYM of d token & the token contract address
    //mapping (bytes8 => Token) public tokenMapping;
    mapping (address => uint) public maxWithdrawal; //maximum amount of ether a contract can withdraw

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

    function removeToken(bytes8 tokenSymbol) returns (bool) {
      delete supportedTokens[tokenSymbol];
      return true;
    }

    function modifyToken(address tokenAddr) returns (bool) {

    }

    function doesTokenExist(bytes8 symbol) returns (bool) {

    }

     /**
    * @notice function to send ether to a normal address 
    * @dev function checks if address supplied is contract address, if yes, 
    *   it throws
    * @param addr address where ether will be sent
    * @param amount value of ether
    */
    function sendEther(uint amount, address addr) returns (bool) {
        if(isContract(addr) == true) throw;
        if(this.balance == 0) throw;
        if((this.balance - amount) < 0) throw;
        if(addr.send(amount) == true){
            LogEtherSent(addr, amount, this.balance);
            return true;
        } else {
            return false;
        }
    }

    /**
    * @notice function to send ether to a contract address 
    * @dev function implements withdrawal pattern to prevent attackers from 
    *   causing the contract, also prevent reentrancy
    */
    function withdraw() returns (bool) {
        uint amount = maxWithdrawal[msg.sender];
        maxWithdrawal[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    
    /**
    * @notice function to change maximum value a contract can withdraw to zero
    * @param addr contract address
    */
    function changeWithdrawal(address addr) returns (bool) {
        maxWithdrawal[addr] = 0;
    }
    
    /**
    * @notice function to change maximum value a contract can withdraw from
    *   zero to a given value
    * @param addr contract address
    * @param value maximum amount of ether that can be sent
    */
    function changeWithdrawal(address addr, uint value) returns (bool) {
        if(maxWithdrawal[addr] != 0) {
            changeWithdrawal(addr);
        }
        maxWithdrawal[addr] = value;
    }

    /**
    * @notice function that is called when a user or another contract wants to
    *   transfer funds with no data
    * @dev ERC23 version of transfer with no _data
    * @param _to address where token will be sent
    * @param _value amount of tokens
    */
    function transferToken(address _to, uint _value) returns (uint) {
        //get instance of token using the token address
        //run checks
        //make contract state changes
        //call token transfer function
    }

    /**
    * @notice function that is called when a user or another contract wants to
    *   transfer funds with _data
    * @dev ERC23 version of transfer where _data is supplied
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    */
    function transferToken(address _to, uint _value, bytes _data) returns (uint) {
        //get instance of token using the token address
        //run checks
        //make contract state changes
        //call token transfer function
    }

    /**
    * @notice function that is called when a user or another contract wants to
    *   transfer funds with _data and _callback
    * @dev ERC23 version of transfer where callback to handle tokens is supplied
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    * @param _custom_fallback callback function
    */
    function transferToken(address _to, uint _value, bytes _data, string _custom_fallback) returns (uint) {
        //get instance of token using the token address
        //run checks
        //make contract state changes
        //call token transfer function
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

    /**
    * @notice function to check if an address belongs to a contract 
    * @dev function uses assembly to check for a contract address
    */
    function isContract(address _addr) private returns (bool is_contract) {
        uint length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        if(length>0) {
            return true;
        }
        else {
            return false;
        }
    }

    function getSignature(bytes _data) returns (bytes4 sig) {
        uint32 u = uint32(_data[3]) + (uint32(_data[2]) << 8) +
            (uint32(_data[1]) << 16) + (uint32(_data[0]) << 24);
        sig = bytes4(u);
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
