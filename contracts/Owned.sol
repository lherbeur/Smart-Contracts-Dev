pragma solidity ^0.4.11;

contract Owned {

	address public owner;
	address public ownedAddr;

    function Owned() {

       //owner = msg.sender;
       ownedAddr = this;
    }

	function setOwner(address newOwner) public isOwner {
    	owner = newOwner;
	}

	modifier isOwner() {
	    require(msg.sender != owner);
	    _;
	}

}
