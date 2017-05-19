pragma solidity^0.4.10;

 import "Token";
 import "Owned";

contract ConsensusX is Owned
{
	mapping(bytes32 => address) contracts;
	Token token;
	mapping(address => PersonaAttributes) permittedPersonas;

	//other attrs would be filled in
       struct PersonaAttributes
       {
		uint reputation;
		//…
		//…
       }

function ConsensusX(address tokenAddress)
{
	token = Token(tokenAddress);
}

//add contract with contactAddress n contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
function addContract(bytes32 contractName, address contactAddress)
internal
{
//…
contracts [contractName] = contactAddress;
//…
}

//check the ‘contracts’ mapping and set val of contractName’s address to 0x0
function removeContract(bytes32 contractName)
internal
{
//…
contracts [contractName] = 0x0;
//…
}

//checks of calling persona is permitted to invoke fxns
function permitPersona(address personaAddress)
{
//…
permittedPersonas[personaAddress] = PersonaAttributes (1);
//...
}


//to check if calling contract is authd to perform action
modifier isPermittedPersona (address callingPersona)
{
	if  (permittedPersonas[callingPersona].reputation == 0) //or some agreed upon value
		throw;

	_;
}


}