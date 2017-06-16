var ConsensusX = artifacts.require("./ConsensusX.sol");
var Persona = artifacts.require("./Persona.sol");
var TokenWallet = artifacts.require("./library/TokenWallet.sol");
var FalseWallet = artifacts.require("./library/FalseWallet.sol");

module.exports = function(deployer) {
  deployer.deploy(TokenWallet);	
  deployer.deploy(FalseWallet);	
  deployer.deploy(ConsensusX, "Pokerium", 0.00010, "POK", "1.0", 3000000).then(function(){
  	return deployer.deploy(Persona, ConsensusX.address);
  });
};