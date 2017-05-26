pragma solidity ^0.4.11;

/*
 *ERC20 Token Standard
 *https://github.com/ethereum/EIPs/issues/20 
 */


 contract ERC20 {
 	/// tiggered when tokens are transfered
 	event Transfer(address indexed _from, address indexed _to, uint _value);

 	///fires when the 'approve' method is called
  	event Approval(address indexed _owner, address indexed _spender, uint _value);

  	///@notice Get the total token supply
 	function totalSupply() constant returns (uint);

 	///@notice Get the account balance of another account
 	///@param _owner - account address
  	function balanceOf(address _owner) constant returns (uint);

  	///@notice Returns the amount which _spender is still allowed to withdraw from _owner
  	///@param _owner address of token owner
  	///@param _spender address of spender
  	function allowance(address _owner, address _spender) constant returns (uint);

  	///@notice send amount to tokens to a particular address
  	function transfer(address to, uint _value) returns (bool success);

  	///@notice Send _value amount of tokens from one address to another. This function 
  	/// allows contracts that have been authorised to send tokens on your behalf
  	///@param _from address where token is sent from
  	///@param _to address where token is sent to
  	function transferFrom(address _from, address _to, uint _value) returns (bool success);

  	///@notice Allow _spender to withdraw from your account, multiple times, up to the _value amount.
  	///@param _spender address allowed to withdraw a maximum value of tokens
  	///@param _value total value of tokens a particular address is allowed to withdraw
  	function approve(address _spender, uint _value) returns (bool success);

 }