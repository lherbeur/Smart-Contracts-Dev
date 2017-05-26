pragma solidity ^0.4.11;

import "./ConsensusX.sol";

contract Vesting {
    /* address consX;
    struct Schedule {
        uint64 cliffBegin;
        uint64 cliffEnd;
        uint256 tokenStake;
    }
    mapping (address => Schedule[]) public masterSchedule;
    event Scheduled(address addr, uint64 cliffBegin, uint64 cliffEnd, uint256 tokenStake);

    function Vesting() {

    }


    // @dev
    function assignSchedule(address _addr, uint64 _cliffBegin, uint64 _cliffEnd, uint256 _tokenStake) OnlyConsensusX returns (bool) {
        Schedule[] schedules = masterSchedule[_addr];// extract previous persona schedule(s)
        schedules.push(Schedule(_cliffBegin, _cliffEnd, _tokenStake));// push new schedule into schedules
        masterSchedule[_addr] = schedules;// save updated schedules

        Scheduled(_addr, _cliffBegin, _cliffEnd, _tokenStake);

        return (masterSchedule[_addr] == 0);
    }


    // @dev
    function setConsXAddress(address _consXAddr) returns (bool){
        if(consX != 0x0 && _consXAddr != consX){
            return false;
        }
        consX = _consXAddr;
        return true;
    }


    // @dev
    function isConsXEnabled() internal constant returns (bool) {
        if(consX != 0x0){
            address ca = new ConsensusX(consX);
            if (msg.sender == ca){
                return true;
            }
        }
        return false;
    }


    // @dev
    modifier OnlyConsensusX() {
        require(isConsXEnabled());
        _;
    }


    // Fallback
    function () {
        throw;
    } */
}
