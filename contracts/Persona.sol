pragma solidity ^0.4.11;

import "./ConsensusX.sol";

contract Persona {
    address Consensus;
    function Persona(address _Consensus){
        Consensus =  _Consensus;
    }
    
    function CallToTransfer(address _to, uint _value){
        ConsensusX(Consensus).callTransfer(_to, _value);
    }
    
    function returnPersonaBalance() constant returns (uint){
        return ConsensusX(Consensus).balances(this);
    }
	
}