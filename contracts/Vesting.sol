/*
Copyright SuperDAO Prep May 2017
*/

pragma solidity ^0.4.11;


/** @title Vesting
* @author Charles
* @author Wunmi
* @author Tosin
* @author Michael
* @author Emmanuel
* @author Promise
*/
contract Vesting  {

    address public consensusXAddr;

    struct PersonaSchedule {
        bytes32 name;
        uint64 start;
        uint64 end;
        uint64 cliff;
        uint256 value;
        uint256 loggedBy;
    }

    mapping (address => PersonaSchedule[]) public personaSchedules;

    event Scheduled(bytes32 name, address addr, uint64 start, uint64 end, uint256 value, uint256 loggedBy);


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
        uint n = personaSchedules[_to].push(PersonaSchedule(
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
    * @notice Get vesting schedules of `_personaAddr` in chunks of 5
    * @dev gets chunked vesting schedules of a persona address
    * @param _personaAddr - persona address
    * @param _index - the pagination index
    * @return arrays of name, start date, end date, cliff, value and time
    */
    function getChunkedVestingSchedule (address _personaAddr, uint256 _index)
    onlyConsensusX
    returns (
        bytes32[5] name,
        uint64[5] start,
        uint64[5] end,
        uint64[5] cliff,
        uint256[5] value,
        uint256[5] loggedBy)
    {
        PersonaSchedule [] schedules = personaSchedules[_personaAddr];
        uint256 upperIndex = _index + 5;
        uint arrayIndex = 0;


        if (upperIndex > getVestingScheduleCount (_personaAddr) - 1)
        {
          upperIndex = getVestingScheduleCount (_personaAddr);
        }

        for (uint i=_index; i< upperIndex; i++)
        {
          name[arrayIndex] = schedules[i].name;
          start[arrayIndex] = schedules[i].start;
          end[arrayIndex] = schedules[i].end;
          cliff[arrayIndex] = schedules[i].cliff;
          value[arrayIndex] = schedules[i].value;
          loggedBy[arrayIndex] = schedules[i].loggedBy;

          ++arrayIndex;
        }

        return (name, start, end, cliff, value, loggedBy);
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
        return (personaSchedules[_personaAddr].length);
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
