pragma solidity ^0.4.11;

import "./ConsensusX.sol";

contract Persona {
    address public Consensus;
    address public deployer;
    
    function Persona(address _Consensus){
        Consensus =  _Consensus;
        deployer = msg.sender;
    }
    
    /**
    * @notice call this function to send tokens 
    * @dev -calls ConsensusX 'canTransfer' which in turn calls Token 'transfer' function
    * @param _to address to send Tokens to
    * @param _value amount of tokens to be sent
    */
    function CallToTransfer(address _to, uint _value){
        ConsensusX(Consensus).callTransfer(_to, _value);
    }
    
    /**
    * @notice returns persona balance 
    */
    /*function returnPersonaBalance() constant returns (uint){
        return ConsensusX(Consensus).balances(this);
    }*/
    
    /**
    * @notice call this function to authorize address to spend maximum amount of tokens 
    * @dev -calls ConsensusX 'callApprove' which in turn calls Token 'approve' function
    * @param _spender contract address that is to be approved
    * @param _amount token value
    */
    function callApprove(address _spender, uint256 _amount) returns (bool success){
        if(ConsensusX(Consensus).callApprove(msg.sender, _spender, _amount)) return true;
        return false;
    }
    
    
    /**
    * @notice call this function to initially allocate all tokens to a contract address 
    * @dev -calls ConsensusX 'allocateTokensr' which in turn calls Token 'callApproveAndCall' function
    * @param _allocator address that tokens will be sent to
    */
    function allocateTokens(address _allocator) returns (bool){
        if(ConsensusX(Consensus).allocateTokens(_allocator)) return true;
        return false;
    }
    
    
    /**
    * @notice returns TokenWallet  balance 
    */
    function returnWalletBalance(address _wallet) constant returns(uint){
        return TokenWallet(_wallet).checkWalletBalance();
    }
    
    /**
    * @notice returns balance of address that deployed the contract
    */
    function returnDeployerBalance() constant returns (uint) {
        return deployer.balance;
    }
    
    /** 
    * @notice Checks if a Persona address is part of the list of permited addresses and if the  
    *   second address exists in the struct array.
    * @dev This function calls 'canCallConsX' function from ConsensusX contract
    * @param _personaDbAddress persona contract address 
    * @param _callerAddress contract address to be that's part of the struct of addresses
    */
    function checkPermitted(address _personaDbAddress, address _callerAddress) constant returns (bool){
        return ConsensusX(Consensus).canCallConsX(_personaDbAddress, _callerAddress);
    }
    
    /** 
    * @notice Adds a Persona address to the list of permited addresses and another 
    *   address to the struct array.
    * @dev This function calls 'permitPersona' function from ConsensusX contract
    * @param _personaDbAddress persona contract address to be added
    * @param _authCallerAddress contract address to be added to struct of addresses per Persona address
    */
    function permitAddress(address _personaDbAddress, address _authCallerAddress) returns (bool){
        return ConsensusX(Consensus).permitPersona(_personaDbAddress, _authCallerAddress);
    }
    
}