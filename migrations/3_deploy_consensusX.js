var Owned = artifacts.require("./Owned.sol");
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
  deployer.deploy(Token, "Pokerium", 0.00010, "POK", "1.0", 3000000).then(function(){
    deployer.link(Token,ConsensusX);
    return deployer.deploy(ConsensusX, Token.address).then(function(){
      deployer.link(ConsensusX,Persona);
      return deployer.deploy(Persona, ConsensusX.address);
    });
  });
};
