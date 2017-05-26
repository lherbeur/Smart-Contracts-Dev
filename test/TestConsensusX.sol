pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Token.sol";
import "../contracts/ConsensusX.sol";

contract TestConsensusX {


	function testAddContract (){
		ConsensusX con = new ConsensusX(DeployedAddresses.Token());
		bool expected = true;
		address addr = 0x7ca8fb59a4959251798fd85718366da82b726087;

		Assert.equal(con.addContract("Tosin", addr), expected, "Function should return true");
	}

	function testgetContracts(){
		ConsensusX con = new ConsensusX(DeployedAddresses.Token()); 
		address expected = 0x0;

		Assert.equal(con.getContracts("tosin"), expected, "Function should return null address");
	}
}
