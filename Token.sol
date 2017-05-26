pragma solidity ^0.4.11;

import "./Owned.sol";
import "./library/token/ERC23.sol";

contract Token is Owned, ERC23  {
	//conforming to the ERC20 /223 standard

  	string public name; 			//token name
	uint8 public decimals;			//number of decimals of the smallest unit
	string public symbol;			//token symbol
	string public version;			//version value according to an arbitrary scheme
	uint256 public totalSupply;

	/// @notice mapping to track amount of tokens each address holds
	mapping (address => uint256) public balances;

    /// @notice event triggered when tokens are transferred
    event Transfer(address indexed _from, address indexed _to, uint256 _value); //Transfer event

    function Token(
    	string tokenName,
    	uint8 decimalUnits,
    	string tokenSymbol,
    	string tokenVersion,
    	uint256 initialSupply
    	) {
		name = tokenName;
		decimals = decimalUnits;
		symbol = tokenSymbol;
		version = tokenVersion;
		totalSupply = initialSupply;
    }

    /// @notice function to access name of token .
    function name() constant returns (string _name) {
        return name;
    }

    /// @notice function to access symbol of token .
    function symbol() constant returns (string _symbol) {
        return symbol;
    }

    /// @notice function to access decimals of token .
    function decimals() constant returns (uint8 _decimals) {
        return decimals;
    }

    /// @notice function to access total supply of tokens .
    function totalSupply() constant returns (uint256 _totalSupply) {
        return totalSupply;
    }

    function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }


    /**
    * @notice function that is called when a user or another contract wants to transfer funds
    * @dev ERC23 version of transfer
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    */
    function transfer(address _to, uint _value, bytes _data) returns (bool success) {
        //.......checks
    	//.....and other lines of code
    }


    /**
    * @notice @notice function that is called when a user or another contract
    *  wants to transfer funds with no _data
    * @dev Standard function transfer similar to ERC20 transfer with no _data .
    *  added due to backwards compatibility reasons .
    * @param _to address where token will be sent
    * @param _value of tokens
    */
    function transfer(address _to, uint256 _value) returns (bool success) {
    	//.......checks
    	//.....and other lines of code

    }

    /**
    * @dev function called when target address is a contract
    * @param _to - address where token will be sent to
    * @param _value token amount
    * @param _data code associated with transaction
    */
    function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
    }


    /**
    * @dev function that is called when target address is external
    * @param _to address of contract
    * @param _value maximum value of tokens
    * @param _data - information that accompanies transaction
    */
    function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {
    }


    /**
    * @dev this function assembles the given address bytecode, if the
    *  bytecode exists, then _addr is a contract.
    * @param _addr address of either a conract or external account
    */
    function isContract(address _addr) private returns (bool is_contract) {
    }

}
