pragma solidity^0.4.10;

import "Owned.sol";
import "/library/token/ERC20.sol";

contract Token is Owned, ERC20  {
	//conforming to the ERC20 /223 standard

  	string public name; 			//token name
	uint public decimals;			//number of decimaals of the smallest unit
	string public symbol;			//token symbol
	string public version;			//version value according to an arbitrary scheme
    
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




