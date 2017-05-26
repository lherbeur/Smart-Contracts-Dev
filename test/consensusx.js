//Abstraction for ConsensusX
var ConsensusX = artifacts.require("ConsensusX").
address;

contract('ConsensusX', function(){
	it("should find address", function(){
		return ConsensusX.deployed().then(function(instance){
			return instance.getContracts.call("tosin");
		}).then(function(address){
			assert.equal(address.valueOf(), 0x0, "null address must be returned");
		});
	});
});