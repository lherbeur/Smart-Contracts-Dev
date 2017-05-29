pragma solidity ^0.4.11;

import "Owned.sol";


contract Vesting is Owned {


    function Vesting (address _consensusX) {
        consensusXAddr = _consensusX;
    }

    address public consensusXAddr;

    struct personaSchedule {
        bytes32 name;
        uint64 start;
        uint64 end;
        uint64 cliff;
        uint256 value;
        uint256 loggedBy;
    }

    mapping (address => personaSchedule[]) public schedules;

    event Scheduled(bytes32, address addr, uint64 start, uint64 end, uint256 value, uint256 loggedBy);

    modifier onlyConsensusX () {
        require(msg.sender == consensusXAddr);
        _;
    }

    modifier checkNewScheduleData (
        uint64 _start,
        uint64 _end,
        uint64 _cliff,
        uint64 _value) {
         require(
             _start < _end
             && _cliff > _start
             && _cliff < _end
             && _value > 0);
         _;
    }

    function assignSchedule (
        address _to,
        bytes32 _name,
        uint64 _start,
        uint64 _end,
        uint64 _cliff,
        uint64 _value)
        onlyConsensusX
        checkNewScheduleData(_start, _end, _cliff, _value)
        returns (uint) {
        uint n = schedules[_to].push(personaSchedule(
            _name,
            _start,
            _end,
            _cliff,
            _value,
            now
            ));
        require(n > 0);
        Scheduled(_name, _to, _start, _end, _value, now);
        return n;

    }

    function setConsensusXAddr (address _newConsensusXAddr) onlyConsensusX {
        consensusXAddr = _newConsensusXAddr;
    }

}
