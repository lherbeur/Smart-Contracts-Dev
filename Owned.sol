pragma solidity^0.4.10;

contract Owned {

	address owner;

    function Owned() {

       owner = msg.sender;
    }

	function setOwner(address newOwner) isOwner {
    	owner = newOwner;
	}

	modifier isOwner() {
	    if (msg.sender != owner)
	        throw;
	    _;
	}

}