pragma solidity ^0.4.11;

import "./Owned.sol";
import "./library/token/ERC23.sol";
import "./library/TokenWallet.sol";
import "./library/SafeMath.sol";

contract Token is Owned(true), ERC23, SafeMath  {
    //conforming to the ERC20 /223 standard

    string public name;             //token name
    uint8 public decimals;          //number of decimals of the smallest unit
    string public symbol;           //token symbol
    string public version;          //version value according to an arbitrary scheme
    uint256 public totalSupply;
    address public tokenAddr;

    /// @notice mapping to track amount of tokens each address holds
    mapping (address => uint256) public balances;

    /**
    * @notice mapping to store contract addresses authorised to spend tokens
    * on behalf of an address anf maximun tokens they can spend
    */
    mapping (address => mapping(address => uint)) public allowed;

    /// @notice event triggered when new amounts are approved for contract addresses
    event Approval(address _sender, address _spender, uint _amount);

    /// @notice event triggered when tokens are transferred
    event Transfer(address indexed _from, address indexed _to, uint256 _value); //Transfer event
    event LogEtherReceived(address sender, uint amount, uint balance); //log ether deposit

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
        tokenAddr = this;
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

    // ERC20 Standard functions

    /**
    * @dev function to set amount of tokens approved to zero
    * @param _owner address of token owner
    * @param _spender contract address to spend tokens on behalf of owner
    */
    function approve(address _owner, address _spender) returns (bool success){
        allowed[_owner][_spender] = 0;
        Approval(_owner, _spender, 0);
        return true;
    }

    /**
    * @dev function to set amount of tokens approved to desired value
    * @param _owner address of token owner
    * @param _spender contract address to spend tokens on behalf of owner
    * @param _amount value of tokens approved to be spent on owner behalf
    */
    function approve(address _owner, address _spender, uint256 _amount) returns (bool success) {
        // To change the approve amount you first have to reduce the addresses´
        //  allowance to zero by calling `approve(_spender,0)` if it is not
        //  already 0 to mitigate the race condition described here:
        //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
        if (!approve(_owner, _spender)) throw;
        allowed[_owner][_spender] = _amount;
        Approval(_owner, _spender, _amount);
        return true;
    }


    // ERC223 standard functions

    /**
    * @notice function that is called when a user or another contract wants to transfer funds
    * @dev ERC23 version of transfer where callback to handle tokens is supplied
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    * @param _custom_fallback callback function
    */
    function transfer(address _to, uint _value, bytes _data, string _custom_fallback) returns (bool success) {

        if(isContract(_to)) {
            if (balanceOf(msg.sender) < _value) throw;
            balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
            balances[_to] = safeAdd(balanceOf(_to), _value);
            Persona receiver = Persona(_to);
            receiver.call.value(0)(bytes4(sha3(_custom_fallback)), msg.sender, _value, _data);
            Transfer(msg.sender, _to, _value, _data);
            return true;
        }
        else {
            return transferToAddress(_to, _value, _data);
        }
    }


    /**
    * @notice function that is called when a user or another contract wants to transfer funds
    * @dev ERC23 version of transfer
    * @param _to address where token will be sent
    * @param _value amount of tokens
    * @param _data - information that accompanies transactions
    */
    function transfer(address _to, uint _value, bytes _data) returns (bool success) {
        if(isContract(_to)) {
            transferToContract(_to, _value, _data);
        }
        else {
            transferToAddress(_to, _value, _data);
        }
        return true;
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
        bytes memory empty;
        if(isContract(_to)) {
            transferToContract(_to, _value, empty);
        }
        else {
            transferToAddress(_to, _value, empty);
        }
        return true;
    }

    /**
    * @dev function called when target address is a contract
    * @param _to - address where token will be sent to
    * @param _value token amount
    * @param _data code associated with transaction
    */
    function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
        if (balanceOf(msg.sender) < _value) throw;
        balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
        balances[_to] = safeAdd(balanceOf(_to), _value);
        Persona receiver = Persona(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        Transfer(msg.sender, _to, _value, _data);
        return true;
    }


    /**
    * @dev function that is called when target address is external
    * @param _to address of contract
    * @param _value maximum value of tokens
    * @param _data - information that accompanies transaction
    */
    function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {
        if (balanceOf(msg.sender) < _value) throw;
        balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
        balances[_to] = safeAdd(balanceOf(_to), _value);
        Transfer(msg.sender, _to, _value, _data);
        return true;
    }


    /**
    * @dev function that determines if given address belongs to a contract or
    * external address - this function assembles the given address bytecode, if the
    *  bytecode exists, then _addr is a contract.
    * @param _addr address of either a conract or external account
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
    * @notice function called to purchase tokens
    * @dev calculation of tokens given amount of wei and token value is done
    *   as proof of concept. The token value is fixed instead of dynamic. This 
    *   will be moved to the client side as the project progresses to save gas 
    *   costs and to make the inputs more dynamic
    */
   function claimToken() payable returns (uint tokensPurchased) {
        if(msg.value == 0) revert();
        uint precision = 3;
        var tokenValue = 2000000000000000000;
        var etherValue = msg.value;
        // caution, check safe-to-multiply here
        uint _numerator  = etherValue * 10 ** (precision+1);
        // with rounding of last digit
        tokensPurchased =  ((_numerator / tokenValue) + 5) / 10;
        if(isContract(msg.sender)){
            balances[msg.sender] = safeAdd(balanceOf(msg.sender), tokensPurchased);
            Persona receiver = Persona(msg.sender);
            receiver.tokenFallback(msg.sender, tokensPurchased, msg.data);
            LogEtherReceived(msg.sender, msg.value, this.balance);
        } else {
            balances[msg.sender] = safeAdd(balanceOf(msg.sender), tokensPurchased);
            LogEtherReceived(msg.sender, msg.value, this.balance);
        }
        
    }
}
