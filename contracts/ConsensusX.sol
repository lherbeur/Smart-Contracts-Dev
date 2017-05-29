/*
Copyright SuperDAO Prep May 2017
*/

pragma solidity ^0.4.11;

 import "./Token.sol";
 import "./Owned.sol";



/** @title ConsensusX
* @author Charles
* @author Wunmi
* @author Tosin
* @author Michael
* @author Emmanuel
* @author Promise
*/
contract ConsensusX is Owned {

    Token token;

    mapping(bytes32 => address) contracts; // Contract names to contract addresses database mapping
    mapping(address => AuthCaller[]) permittedPersonasPerDb; // List of Permitted personas
    event EventAddedContract(bytes32, bool);
    event DeleteContract(bytes32 name, bool success);

    struct AuthCaller {
        /*bytes32 name;
        bytes32 role;*/
        address addr;// authorized caller contract address
        uint reputation;
        //…
        //…
    }

    AuthCaller[] authCallers;

    /// @dev checks if calling contract is authorized to perform action
    modifier isPermittedPersona (uint reputation) {
        /*require(permittedPersonas[msg.sender].reputation > reputation); //or some agreed upon value*/
        _;
    }

    function getContracts(bytes32 contractName) constant returns (address){
        return contracts[contractName];
    }

    function ConsensusX(address tokenAddress) {
        token = Token(tokenAddress);
    }

    /**
    * @dev make low level function calls
    * @param contractSig - function signature
    * @param argument - function argument
    */
	function callContractFunction(
        address _personaDbAddress,
        bytes32 contractName,
        bytes32 contractSig,
        bytes32 [] arguments)
        returns (bool) {
        require(canCallConsX(_personaDbAddress, msg.sender) == true);
        return contracts[contractName].call(bytes4(sha3(contractSig)), arguments);
	}


    /** @notice Add `_contractName` with address: `_contractAddress` to the contracts database.
    * @dev add contract with contactAddress n _contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
    * @dev function returns `true` if address was successfully added, else it returns false
    * @param _contractName Name of contract to be added
    * @param _contractAddress address of contract to be added
    */
    function addContract(bytes32 _contractName, address _contractAddress) /* isOwner */ returns (bool) {
        if (contracts[_contractName] != 0x0)
            return false;
        contracts[_contractName] = _contractAddress;
        EventAddedContract(_contractName, true);
        return true;
    }


    /** @notice Remove `contractName` with address: `contracts[contractName]` from the contracts database.
    * @dev add contract with contactAddress n contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
    * @param contractName Name of contract to be added
    */
    function removeContract(bytes32 contractName) isOwner returns (bool result){ //isOwner modifier is inherited from the "Owned" contract
        if (contracts[contractName] == 0x0)
        return false;
        delete contracts[contractName];    //delete contract name from mapping
        DeleteContract(contractName, result);
        return true;
    }


    /// @dev checks if calling persona is permitted to invoke fxns
    function permitPersona(address _personaDbAddress, address _authCallerAddress) public returns(bool){
        if (!canCallConsX(_personaDbAddress, _authCallerAddress)) {
            authCallers.push(AuthCaller(_authCallerAddress, 1));
            permittedPersonasPerDb[_personaDbAddress] = authCallers;
            return true;
        }

        return false;
    }


    /// @dev Check the existence of an authorized caller address
    function canCallConsX(address _personaDbAddress, address _callerAddress) private returns(bool) {
        authCallers = permittedPersonasPerDb[_personaDbAddress];

        // check for existence of authorized caller address
        for (uint i = 0; i < authCallers.length; i++) {
            if (authCallers[i].addr == _callerAddress){
                return true;
            }
        }

        return false;
    }

    /// @dev fallback function
    function()
    {
        throw;
    }

}
