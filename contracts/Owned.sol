pragma solidity ^0.4.11;

contract Owned {

	address owner;

    function Owned() {

       owner = msg.sender;
    }

	function setOwner(address newOwner) isOwner {
    	owner = newOwner;
	}

	modifier isOwner() {
	    require(msg.sender != owner);
	    _;
	}

}
