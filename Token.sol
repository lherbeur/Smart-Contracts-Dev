pragma solidity ^0.4.10;

import "Owned.sol";
import "/library/token/ERC20.sol";

contract Token is Owned, ERC20  {
	//conforming to the ERC20 /223 standard

  	string public name; 			//token name
	uint8 public decimals;			//number of decimals of the smallest unit
	string public symbol;			//token symbol
	string public version;			//version value according to an arbitrary scheme
	uint256 public totalSupply;

	///@notice mapping to track amount of tokens each address holds
	mapping (address => uint256) public balanceOf;

	///@notice mapping to track maximum amount of tokens each address can spend on behalf of owner
	mapping (address => uint256) public allowance; 
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value); //Transfer event
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    function Token(
    	string tokenName,
    	uint8 decimalUnits,
    	string tokenSymbol,
    	string tokenVersion,
    	uint256 initialSupply
    	) {
		//...
    }
    
    /* function transferToAddress() { //Function to transfer token to address
    }
    
    function transferToContract() {     //Function to transfer token to contract
    }
    
    function checkTokenBalance() {      //Function to check balance of token in address
    } */


    ///@dev calls internal function "doTransfer" after checks
    ///@param _to address where token will be sent
    ///@value value of tokens
    function transfer(address _to, uint256 _value) returns (bool success) {
    	//.......checks
    	//.....and other lines of code
    	doTransfer(address _from, address _to, uint _amount);
    }

    ///@dev calls internal function "doTransfer" after checks
    ///@param _from address where token will be sent from
    ///@param _to address where token will be sent to
    ///@value value of tokens
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    	//.......checks
    	//.....and other lines of code
    	doTransfer(address _from, address _to, uint _amount);
    }

    ///@dev adds address and the maximum amount of tokens they can spend on behalf of owner
    ///@param _spender address of contract 
    ///@param _value maximum value of tokens 
    function approve(address _spender, uint256 _value) returns (bool success){

    }

    ///@dev internal function where the token transfer logic resides, as well
    /// as various checks before transfer is done for security purposes.
    ///@param _from address of sender
    ///@param _from address of receiver
    function doTransfer(address _from, address _to, uint _amount) internal returns (bool) {

    }
    
}




