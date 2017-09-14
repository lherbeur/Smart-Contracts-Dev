pragma solidity ^0.4.16;

import './Owned.sol';
import './ConsensusX.sol';

/** @title ContractBank
* @author Promise
* @author Michael
*/
contract ContractBank is Owned {

    address public consensusXAddress; // current consensusXAddress, used to retrieve function for checking allowed personas

    struct contractDetails {
        bytes32 byteCode; // contract bytecode
        uint gasCost; // contract gas cost
        address contractAddress; // contract address
        bytes32 contractInterface; // contract interface
    }

    mapping (bytes32 => contractDetails) public contracts; // contract name (identifier) to contract struct mapping
    bytes32[] contractKeys;

    event contractStored (bytes32, address); //event triggered when a contract is successfully stored in databases

    function ContractBank (address consensusXAddr) {
        consensusXAddress = consensusXAddr;
    }

    function setNewConsensusXAddress(address addr) isOwner{
        consensusXAddress = addr;
    }

    /**
    * @dev function to upload a new contract to database
    * @param contractName name of the contract being uploaded to database
    * @param personalDbAddress ....
    * @param _byteCode bytecode of the contract being uploaded to database
    * @param _gasCost gas cost for the contract being uploaded to database
    * @param _contractAddress address of the contract being uploaded to database
    * @param _contractInterface interface of the contract being uploaded to database
    */
    function storeContract (
        bytes32 _contractName,
        address _personalDbAddress,
        bytes32 _byteCode,
        uint _gasCost,
        address _contractAddress,
        bytes32 _contractInterface) {
        ConsensusX c = ConsensusX(consensusXAddress);  // retrieve consensusX bytecode
        require(c.canCallConsX(_personalDbAddress, msg.sender)); // check that transaction sender is an authorized persona
        contracts[_contractName] = contractDetails(_byteCode, _gasCost, _contractAddress, _contractInterface); // store contract
        contractKeys.push(_contractName); //store occupied contract keys

        contractStored(_contractName, _contractAddress);
    }

}
