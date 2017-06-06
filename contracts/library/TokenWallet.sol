pragma solidity ^0.4.11;

contract TokenWallet {
    struct TKN {
        address sender;
        uint value;
        bytes data;
    }
    
    TKN tkn; 
    
    /**  
    * @dev fallback function to be called from Token Contract 
    * @param _from address of oken sender
    * @param _value amount of Tokens sent
    * @param _data data sent with transaction
    */
    function tokenFallback(address _from, uint _value, bytes _data){
      tkn.sender = _from;
      tkn.value += _value;
      tkn.data = _data;
    }
    
    /**
    * @notice function to return amount of tokens in wallet
    */
    function checkWalletBalance() constant returns (uint){
        return tkn.value;
    }
}