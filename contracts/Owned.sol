pragma solidity ^0.4.11;

contract Owned {

	address public owner;
	address public ownedAddr;

    function Owned(bool s) {
        if (s) {
            owner = msg.sender;
        }
       ownedAddr = this;
    }

    /**
     * @dev function to change the owner of contract's address, must be called from current owners address
     * @param _owner the new owner's address
     */
	function setOwner(address _owner) internal isOwner {
    	owner = _owner;
	}

	modifier isOwner() {
	    if (owner != 0x0)
	    require(msg.sender == owner);
	    _;
	}

}
