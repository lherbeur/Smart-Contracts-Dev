pragma solidity ^0.4.11;

import "./Owned.sol";
import "./ConsensusX.sol";

contract Persona is Owned {

    address public personaOwner;

    struct erc223Token {
        string name;
        bytes8 symbol;
        address tokenAddress;
        address senderAddress;
        address txOriginAddress;
        uint value;
        bytes data;
        bytes4 sig;
        /*mapping (address => bytes) data;
        mapping (address => bytes4) sig;*/
    }

    mapping (address => erc223Token) public supportedTokens;//maps d token contract address to token struct
    //mapping (bytes8 => Token) public tokenMapping;
    mapping (address => uint) public maxWithdrawal; //maximum amount of ether a contract can withdraw

    uint8[] public tokenKeys;

    event LogEtherSent(address recipient, uint amount, uint balance);
    event LogEtherReceived(address sender, uint amount, uint balance);
    event LogTokenReceived(address sender, uint amount, uint balance);

    function Persona(address ConsensusxAddr) {
        personaOwner = ConsensusxAddr;
    }

    /**
    * @notice function to add supported ERC23 tokens to mapping
    * @param tokenAddr token address
    * @param senderAddr sender address
    * @param txOriginAddr address that initiated transaction
    * @param value amount of tokens
    * @param data associated data with transaction
    */
    function addToken(
        address tokenAddr,
        address senderAddr,
        address txOriginAddr,
        uint value,
        bytes data
        ) returns (bool) {
            if(supportedTokens[tokenAddr].tokenExists == true) revert();
            erc223Token memory tkn;
            tkn.tokenAddress = tokenAddr;
            tkn.senderAddress = senderAddr;
            tkn.txOriginAddress = txOriginAddr;
            tkn.value = value;
            tkn.data = data;
            tkn.sig = getSignature(data);
            tkn.tokenExists = true;
            
            supportedTokens[msg.sender] = tkn;
            LogTokenReceived(msg.sender, value, value);
            return true;
    }
    
    /**
    * @notice function to remove supported ERC23 tokens from mapping 
    * @param tokenAddr token address
    */
    function removeToken(address tokenAddr) returns (bool) {
      delete supportedTokens[tokenAddr];
      return true;
    }
    
    /**
    * @notice function to modify supported ERC23 tokens that exists in a mapping
    * @param tokenAddr token address
    * @param senderAddr sender address
    * @param txOriginAddr address that initiated transaction
    * @param value amount of tokens
    * @param data associated data with transaction
    */
    function modifyToken(
        address tokenAddr,
        address senderAddr,
        address txOriginAddr,
        uint value,
        bytes data
        ) returns (bool) {
        if(supportedTokens[tokenAddr].tokenExists == false) revert();
        supportedTokens[tokenAddr].senderAddress = senderAddr;
        supportedTokens[tokenAddr].txOriginAddress = txOriginAddr;
        supportedTokens[tokenAddr].value += value;
        supportedTokens[tokenAddr].data = data;
        supportedTokens[tokenAddr].sig = getSignature(data);
        LogTokenReceived(msg.sender, value, supportedTokens[tokenAddr].value);
        return true;
    }

    /**
    * @notice function to check if token is supported
    * @param symbol token symbol
    */
    function doesTokenExist(address tokenAddr) returns (bool) {

      if (supportedTokens[tokenAddr].tokenAddress != 0x0)
        return true;
      else
        return false;
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
    * @notice function to buy tokens given a certain amount of wei
    * @dev msg.value is fixed instead of being dynamic. This will be adjusted as 
    *   project continues
    * @param tokenAddr token address
    * @param amount value of tokens
    */
    function buyToken(address tokenAddr, uint amount) {
        Token ercToken = Token(tokenAddr);
        ercToken.claimToken.value(amount)();
    }

    /**
    * @notice function that is called when a user or another contract wants to
    *   transfer funds with no data
    * @dev ERC23 version of transfer with no _data
    * @param _to address where token will be sent
    * @param _value amount of tokens
    */
    function transferToken(address tokenAddr, address _to, uint _value) returns (bool) {
        if(_to == getAddress()) {
            modifyToken(tokenAddr, _to, tx.origin, _value, msg.data);
        }
        Token ercToken = Token(tokenAddr);
        if(ercToken.transfer(_to, _value)) return true;
    }

    /**
    * @notice function that is called when a user or another contract wants to 
    *   transfer funds with _data
    * @dev ERC23 version of transfer where _data is supplied
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    */
    function transferToken(address tokenAddr, address _to, uint _value, bytes _data) returns (bool) {
        if(_to == getAddress()) {
            modifyToken(tokenAddr, _to, tx.origin, _value, msg.data);
        }
        Token ercToken = Token(tokenAddr);
        if(ercToken.transfer(_to, _value, msg.data)) return true;
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
    function transferToken(address tokenAddr, address _to, uint _value, bytes _data, string _custom_fallback) returns (bool) {
        if(_to == getAddress()) {
            modifyToken(tokenAddr, _to, tx.origin, _value, msg.data);
        }
        Token ercToken = Token(tokenAddr);
        if(ercToken.transfer(_to, _value, msg.data, _custom_fallback)) return true;
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

    /**
    * @notice function to obtain function signature
    */
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

    /**
    * @dev fallback function to be called (ERC223 standard)
    * @param _from address of token sender
    * @param _value amount of Tokens sent
    * @param _data data sent with transaction
    */
    function tokenFallback(address _from, uint _value, bytes _data){
        //check if token is supported or exists in record
        //call addTokens if it does not, modifyTokens if it does.

        if (doesTokenExist(msg.sender))
        {
            modifyToken(msg.sender, _from, tx.origin, _value, _data);
          //supportedTokens[msg.sender].value += _value;
        }
        else
        {
            //Token memory tkn;
            /*tkn.name = "name";
            tkn.symbol = "Symbol";*/
            /*tkn.tokenAddress = msg.sender;
            tkn.senderAddress = _from;
            tkn.txOriginAddress = tx.origin;
            tkn.value = _value;
            tkn.data = _data;
            tkn.sig = getSignature(_data);*/
          
            addToken(msg.sender, _from, tx.origin, _value, _data);
            //supportedTokens[msg.sender] = tkn;
        }

        //i guess we basically need addr and val to b in d storage...we might, as well, just strip d token struct of oda elements
    }

    function() payable {
        LogEtherReceived(msg.sender, msg.value, this.balance);
    }

}
