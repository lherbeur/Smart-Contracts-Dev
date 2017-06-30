var ConsensusX = artifacts.require("ConsensusX");
var Persona = artifacts.require("Persona");
var TokenWallet = artifacts.require("TokenWallet");

//var consxInstance, personaAddr;

contract('Persona', function(accounts){
	
	it.skip("it should send total Tokens to a Persona Contract", function(){
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
		var personaAddr;
		var balance
		var wallet = TokenWallet.deployed();
			return ConsensusX.deployed().then(function(instance){
				var consxInstance = instance;
				return Persona.deployed().then(function(instance){
					personaAddr = instance;
					consxInstance.allocateTokens.call(personaAddr);
					return balance = personaAddr.returnPersonaBalance.call();
				}).then(function(balance){
					//console.log("From Persona, balance: " + balance);
					//assert.equal(bool, true, "Transaction must return true");
					//console.log(value);
					//assert.equal(value.valueOf(), 3000000, "value must exist");
				});
			});
	});*/

	/*it("it should send Tokens to a Token Wallet", function(){
		return TokenWallet.deployed().then(function(instance){
			var wallet = instance.address;
			return ConsensusX.deployed().then(function(instance){
				var consxInstance = instance;
				return Persona.deployed().then(function(instance){
					consxInstance.allocateTokens.call(instance.address);
					return instance.CallToTransfer.call(wallet, 100000, {from:accounts[0],gas:4500000});
				}).then(function(bool){
					assert.equal(bool, true, "Transaction must return true");
				});
			});
		});
	});*/
});