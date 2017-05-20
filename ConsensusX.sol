/*
    Copyright SuperDAO Prep May 2017
*/

pragma solidity^0.4.10;

 import "Token";
 import "Owned";


/** @title ConsensusX
 * @author SuperDAO
 */
contract ConsensusX is Owned {

	Token token;

	/// @dev Contract names to contract addresses database mapping
	mapping(bytes32 => address) contracts;

	/// @dev List of Permitted personas
	mapping(address => PersonaAttributes) permittedPersonas;

	/// @dev
  struct PersonaAttributes {
  	bytes32 name;
    bytes32 role;
	uint reputation;
	//…
	//…
  }


	function ConsensusX(address tokenAddress) {
		token = Token(tokenAddress);
	}


	/// @dev checks if calling contract is authorized to perform action
	modifier isPermittedPersona (uint reputation) {
		require(permittedPersonas[msg.sender].reputation > reputation); //or some agreed upon value
		_;
	}


   /** @notice Add `contractName` with address: `contractAddress` to the contracts database.
     * @dev add contract with contactAddress n contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
     * @param contractName Name of contract to be added
     * @param contractAddress address of contract to be added
     */
	function addContract(bytes32 contractName, address contractAddress) isOwner returns (bool) {
		if (contracts[contractName] != 0x0)
		    return false;
		contracts[contractName] = contractAddress;
		return true;
	}


	/** @notice Remove `contractName` with address: `contracts[contractName]` from the contracts database.
     * @dev add contract with contactAddress n contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
     * @param contractName Name of contract to be added
     */
	function removeContract(bytes32 contractName) isOwner returns (bool result){ //onlyOwner modifier is inherited from the "Owned" contract
		address cname = contracts[contractName];
		if (cname == 0x0)
		    return false;
		contracts[contractName] = 0x0;
		delete contracts[contractName];    //delete contract name from mapping
		return true;
		//event should be triggered to notify success   @mikedobor
	}


	//checks of calling persona is permitted to invoke fxns
	function permitPersona(address personaAddress) {
		//…
		permittedPersonas[personaAddress] = PersonaAttributes (1);
		//...
	}

}
