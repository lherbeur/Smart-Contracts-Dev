pragma solidity ^0.4.11;

/*
 *ERC23 Token Standard
 *https://github.com/ethereum/EIPs/issues/223
 */

contract ERC23 {

	/**
	* @dev - triggered when tokens are transfered
	*/
	event Transfer(address indexed _from, address indexed _to, uint256 _value, bytes _data);

	/// @dev - gets tonen's total supply
	function totalSupply() constant returns (uint256 totalSupply){}
	/// dev - gets name of token
	function name() constant returns (string _name){}
	/// dev - gets symbol of token
	function symbol() constant returns (string _symbol){}
	/// @dev - gets token's decimals
	function decimals() constant returns (uint8 _decimals){}
	/// @dev - gets the account balance of another account with address _owner
	function balanceOf(address _owner) constant returns (uint256 balance){}

	/**
	* @dev - funcion called when token is to be transferred. 
	* @param _to - address(conract or external) - transaction should fail, token transfer 
	*   should not occur if _to is a contract and tokenFallback is not implemented. 
	*   Transaction should complete if address is external without executing tokenFallback function
	* @param _value - amount of tokens
	* @param _data - code associated with token transaction
	*/
	function transfer(address _to, uint _value, bytes _data) returns (bool success){}

	/**
	* @dev Needed for backwards compatibility with ERC20 Standard where the transfer function 
	*  does not have bytes argument. Works similarly to transfer(address, uint, bytes) 
	*  but sends empty bytes array _data.
	* @param _to - reciever address
	* @param _value - token value
	*/
	function transfer(address _to, uint _value) returns (bool success){}

	/**
	* @dev - function to handle token transfers. This function is called form the 
	*  tokens contract. It must be implemented in reciever contract, else transaction fails
	* @param _from - token sender (equals contract address if the tokenFallback function)
	*  is called
	* @param _value - amount of incoming tokens
	* @param _data - code associated with transaction
	*/
	function tokenFallback(address _from, uint _value, bytes _data){}
}