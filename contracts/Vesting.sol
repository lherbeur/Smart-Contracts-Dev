/*
Copyright SuperDAO Prep May 2017
*/

pragma solidity ^0.4.11;

import "./ConsensusX.sol";


/** @title Vesting
* @author Charles
* @author Wunmi
* @author Tosin
* @author Michael
* @author Emmanuel
* @author Promise
*/
contract Vesting {
    /* address consX;
    struct Schedule {
        uint64 cliffBegin;
        uint64 cliffEnd;
        uint256 tokenStake;
        uint256 loggedBy;
    }
    mapping (address => Schedule[]) public masterSchedule;
    event Scheduled(address addr, uint64 cliffBegin, uint64 cliffEnd, uint256 tokenStake, uint256 loggedBy);

    function Vesting() {

    }


    /**
    * @dev assigns a vesting schedule to a persona address
    * @param _addr - persona address 
    * @param _cliffBegin - cliff start date
    * @param _cliffEnd - cliff end date 
    * @param _tokenStake - amount of tokens 
    */
    function assignSchedule(address _addr, uint64 _cliffBegin, uint64 _cliffEnd, uint256 _tokenStake) OnlyConsensusX returns (bool) {
        Schedule[] schedules = masterSchedule[_addr];// extract previous persona schedule(s)
        schedules.push(Schedule(_cliffBegin, _cliffEnd, _tokenStake));// push new schedule into schedules
        masterSchedule[_addr] = schedules;// save updated schedules

        Scheduled(_addr, _cliffBegin, _cliffEnd, _tokenStake, now);

        return (masterSchedule[_addr] == 0);
    }


    /**
    * @dev sets address of ConsensusX 
    * @param _consXAddr - address of ConsensusX
    */
    function setConsXAddress(address _consXAddr) returns (bool){
        if(consX != 0x0 && _consXAddr != consX){
            return false;
        }
        consX = _consXAddr;
        return true;
    }

    /**
    * @dev checks if caller is ConsensusX
    * @return true if the caller is ConsensusX 
    */
    function isConsXEnabled() internal constant returns (bool) {
        if(consX != 0x0){
            address ca = new ConsensusX(consX);
            if (msg.sender == ca){
                return true;
            }
        }
        return false;
    }

    modifier OnlyConsensusX() {
        require(isConsXEnabled());
        _;
    }


    // Fallback
    function () {
        throw;
    } */
}
