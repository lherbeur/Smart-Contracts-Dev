pragma solidity^0.4.10;

contract Token  {
	//conforming to the ERC20 /223 standard

  	mapping(address => TokenAttributes) tokens;

	struct TokenAttributes {
	    address tokenOwner;
	    uint tokenValue;
	    uint amountOfTokens;
	    
	}
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value) //Transfer event
    
    function Token() {
		//...
    }
    
    function transferToAddress() { //Function to transfer token to address
    }
    
    function transferToContract() {     //Function to transfer token to contract
    }
    
    function checkTokenBalance() {      //Function to check balance of token in address
    }
    
    
}




