var ConsensusX = artifacts.require("ConsensusX");
var Persona = artifacts.require("Persona");
var TokenWallet = artifacts.require("TokenWallet");

//var consxInstance, personaAddr;

contract('Persona', function(){
	
	it("it should send total Tokens to a Persona Contract", function(){
		return TokenWallet.deployed().then(function(){
			return ConsensusX.deployed().then(function(instance){
				var consxInstance = instance;
				return Persona.deployed().then(function(instance){
					return consxInstance.allocateTokens.call(instance.address);
				}).then(function(bool){
					assert.equal(bool, true, "'true' value must be returned");
				})
			})
		})
	});

	/*it("it should send Tokens to a Token Wallet", function(){
		return TokenWallet.deployed().then(function(instance){
			var wallet = instance.address;
			return ConsensusX.deployed().then(function(instance){
				var consxInstance = instance;
				return Persona.deployed().then(function(instance){
					consxInstance.allocateTokens.call(instance.address);
					return instance.CallToTransfer.call(wallet, 100000);
				}).then(function(){
					assert.equal(bool, true, "Transaction must return true");
				});
			});
		});
	});*/
});