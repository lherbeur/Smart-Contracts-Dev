var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var ConsensusX = artifacts.require("./ConsensusX.sol");
//var Token = artifacts.require("./Token.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  //deployer.deploy(Token);
  deployer.link(ConvertLib, MetaCoin);
  //deployer.link(Token, ConsensusX);
  deployer.deploy(MetaCoin);
  deployer.deploy(ConsensusX);
};
