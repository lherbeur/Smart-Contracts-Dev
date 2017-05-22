/*
Copyright SuperDAO Prep May 2017
*/

pragma solidity^0.4.10;

 import "Token";
 import "Owned";



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
    event EventAddedContract(bytes, bool);
    event DeleteContract(bytes name, bool success);

    struct AuthCaller {
        /*bytes32 name;
        bytes32 role;*/
        address addr;// authorized caller contract address
        uint reputation;
        //…
        //…
    }

    /// @dev checks if calling contract is authorized to perform action
    modifier isPermittedPersona (uint reputation) {
        /*require(permittedPersonas[msg.sender].reputation > reputation); //or some agreed upon value*/
        _;
    }


    function ConsensusX(address tokenAddress) {
        token = Token(tokenAddress);
    }


    /** @notice Add `_contractName` with address: `_contractAddress` to the contracts database.
    * @dev add contract with contactAddress n _contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
    * @dev function returns `true` if address was successfully added, else it returns false
    * @param _contractName Name of contract to be added
    * @param _contractAddress address of contract to be added
    */
    function addContract(bytes32 _contractName, address _contractAddress) isOwner returns (bool) {
        if (contracts[_contractName] != 0x0)
            return false;
        contracts[_contractName] = _contractAddress;
        return true;
        EventAddedContract(_contractName, true);
    }


    /** @notice Remove `contractName` with address: `contracts[contractName]` from the contracts database.
    * @dev add contract with contactAddress n contractName to the ‘contracts’ mapping. for actions, actionsdb, tokendb…
    * @param contractName Name of contract to be added
    */
    function removeContract(bytes32 contractName) isOwner returns (bool result){ //isOwner modifier is inherited from the "Owned" contract
        if (contracts[contractName] == 0x0)
        return false;
        delete contracts[contractName];    //delete contract name from mapping
        return true;
        DeleteContract(contractName, result);
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
        AuthCaller[] authCallers = permittedPersonasPerDb[_personaDbAddress];

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
    }

}
