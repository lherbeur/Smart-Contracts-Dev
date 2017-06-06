var ConsensusX = artifacts.require("./ConsensusX.sol");
var Persona = artifacts.require("./Persona.sol");

module.exports = function(deployer) {
  deployer.deploy(ConsensusX, "Pokerium", 0.00010, "POK", "1.0", 3000000).then(function(){
  	return deployer.deploy(Persona, ConsensusX.address);
  });
};