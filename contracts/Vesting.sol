/*
Copyright SuperDAO Prep May 2017
*/

pragma solidity ^0.4.11;

import "Owned.sol";

/** @title Vesting
* @author Charles
* @author Wunmi
* @author Tosin
* @author Michael
* @author Emmanuel
* @author Promise
*/
contract Vesting is Owned {

    address public consensusXAddr;

    struct PersonaSchedule {
        bytes32 name;
        uint64 start;
        uint64 end;
        uint64 cliff;
        uint256 value;
        uint256 loggedBy;
    }

    mapping (address => PersonaSchedule[]) public schedules;

    event Scheduled(bytes32, address addr, uint64 start, uint64 end, uint256 value, uint256 loggedBy);


    function Vesting (address _consensusX) {
        consensusXAddr = _consensusX;
    }

    /**
    * @notice Add name = `_name`, value = `_value`, start/end date = `_start` / `_end`,  cliff = `_cliff` to `_to`
    * @dev assigns a vesting schedule to a persona address
    * @param _to - persona address
    * @param _name - name of schedule
    * @param _start - start date
    * @param _end - end date
    * @param _cliff - cliff
    * @param _value - amount of tokens
    * @return the length of schedules for persona
    */
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
        uint n = schedules[_to].push(PersonaSchedule(
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

    /**
    * @notice Get vesting schedule of `_personaAddr` at index `index`
    * @dev gets a vesting schedule, with specified index, of a persona address
    * @param _personaAddr - persona address
    * @param index - index of schedules to get
    * @return name, start date, end date, cliff, value and time schedule was added
    */
    function getVestingSchedulePerIndex (address _personaAddr, uint index)
    onlyConsensusX
    isValidIndex(index)
    constant
    returns (bytes32, uint64, uint64, uint64, uint256, uint256)
    {
        PersonaSchedule personaSchedule = schedules[_personaAddr][index];
        return(
        personaSchedule.name,
        personaSchedule.start,
        personaSchedule.end,
        personaSchedule.cliff,
        personaSchedule.value,
        personaSchedule.loggedBy
        );
    }

    /**
    * @notice Get number of schedules for `_personaAddr`
    * @dev gets the number of vesting schedules assigned to a persona
    * @param _personaAddr - persona address
    * @return  number of vesting schedules assigned to a persona
    */
    function getVestingScheduleCount (address _personaAddr)
    onlyConsensusX
    constant
    returns (uint256)
    {
        return schedules[_personaAddr].length;
    }

    /**
    * @notice Set  consensusXAddr to `_newConsensusXAddr`
    * @dev Sets consensusXAddr to a new address
    * @param _newConsensusXAddr - new address for consensusXAddr
    */
    function setConsensusXAddr (address _newConsensusXAddr) onlyConsensusX {
        consensusXAddr = _newConsensusXAddr;
    }


    modifier onlyConsensusX () {
        require(msg.sender == consensusXAddr);
        _;
    }

    modifier isValidIndex (uint index) {
        require(index >= 0);
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
    
    /// @dev fallback function
    function()
    {
        throw;
    }

}
