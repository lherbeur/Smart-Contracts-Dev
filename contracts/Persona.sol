pragma solidity ^0.4.11;

import "./ConsensusX.sol";

contract Persona {
    address public personaOwner;
    
    function Persona(address _Consensus){
        personaOwner = msg.sender;
   }     
}