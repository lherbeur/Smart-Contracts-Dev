var Owned = artifacts.require("./Owned.sol");
var Vesting = artifacts.require("./Vesting.sol");
var ConsensusX = artifacts.require("./ConsensusX.sol");
var Token = artifacts.require("./Token.sol");
var Persona = artifacts.require("./Persona.sol");
var Erc23 = artifacts.require("./ERC23.sol");
var TokenWallet = artifacts.require("./TokenWallet.sol");
var FalseWallet = artifacts.require("./FalseWallet.sol");

module.exports = function(deployer) {
  //deployer.deploy(TokenWallet);
  //deployer.deploy(FalseWallet);
  //deployer.deploy(Erc23);
  //deployer.deploy(Owned);
  deployer.deploy([TokenWallet,FalseWallet,Erc23,Owned]);
  deployer.link(Erc23,Token);
  deployer.link(Owned,[ConsensusX,Token]);
  deployer.deploy(Token);
  deployer.link(Token,ConsensusX);
  deployer.deploy(Vesting, "0xd9d1a7d11551a8c9665571914bbd43be11d6f99c");
  deployer.link(Vesting,ConsensusX);
  deployer.deploy(ConsensusX, "Pokerium", 0.00010, "POK", "1.0", 3000000).then(function(){
    deployer.link(ConsensusX,Persona);
  	return deployer.deploy(Persona, ConsensusX.address);
  });
};
