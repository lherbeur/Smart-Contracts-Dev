//Abstraction for ConsensusX
/*var ConsensusX = artifacts.require("ConsensusX").
address;

contract('ConsensusX', function(){
	it("should find address", function(){
		return ConsensusX.deployed().then(function(instance){
			return instance.getContracts.call("tosin");
		}).then(function(address){
			assert.equal(address.valueOf(), 0x0, "null address must be returned");
		});
	});
});*/

var Token = artifacts.require("Token");
var ConsensusX = artifacts.require("ConsensusX");

contract('ConsensusX', function(){
	it("should find address", function(){
		return Token.deployed().then(function(address){
			return ConsensusX.deployed().then(function(instance){
				return instance.getContracts.call("tosin");
			}).then(function(address){
				assert.equal(address.valueOf(), 0x0, "null address must be returned");
			});
		});
	});

	it("it should add contract", function(){
		return Token.deployed().then(function(address){
			return ConsensusX.deployed().then(function(instance){
				return instance.addContract.call("tosin", "0x7ca8fb59a4959251798fd85718366da82b726087");
			}).then(function(bool){
				assert.equal(bool, true, "true value must be returned");
			});
		});
	});
});