pragma solidity ^0.4.16;

import './Owned.sol';
import './ConsensusX.sol';

contract ContractBank {

    address public consensusXAddress;

    struct contractDetails {
        bytes32 byteCode;
        uint gasCost;
        address contractAddress;
        bytes32 contractInterface;
    }

    mapping (bytes32 => contractDetails) public contracts;
    bytes32[] contractKeys;

    event contractStored (bytes32, address);

    function ContractBank (address consensusXAddr) {
        consensusXAddress = consensusXAddr;
    }

    function storeContract (
        bytes32 _contractName,
        address _personalDbAddress,
        bytes32 _byteCode,
        uint _gasCost,
        address _contractAddress,
        bytes32 _contractInterface) {
        ConsensusX c = ConsensusX(consensusXAddress);
        require(c.canCallConsX(_personalDbAddress, msg.sender));
        contracts[_contractName] = contractDetails(_byteCode, _gasCost, _contractAddress, _contractInterface);
        contractKeys.push(_contractName);

        contractStored(_contractName, _contractAddress);
    }

}
