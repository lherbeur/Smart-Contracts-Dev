var ConsensusX = artifacts.require("./ConsensusX"),
 Persona = artifacts.require("./Persona"),
 Token = artifacts.require("./Token"),
 TokenWallet = artifacts.require("./TokenWallet"),
 consxInstance, toknInstance, persona1;

//var consxInstance, personaAddr;

contract('All Tests', function(accounts){

  /*it("Should deploy all contracts", function(){
    return ConsensusX.deployed().then(function(instance){
      consxInstance = instance;
      console.log("ConsX deployed at: "+consxInstance.address);
      return Token.deployed().then(function(tinstance){
        toknInstance = tinstance;
        console.log("Token deployed at: "+tinstance.address);
        return Persona.deployed().then(function(pinstance){
          persona1 = pinstance;
          console.log("Persona 1 deployed at: "+persona1.address);
        });
      });
    });
  });*/

  it("Should deploy all contracts", function(){
    return Token.deployed().then(function(tinstance){
      toknInstance = tinstance;
      console.log("Token deployed at: "+tinstance.address);
      return ConsensusX.deployed().then(function(instance){
        consxInstance = instance;
        console.log("ConsX deployed at: "+consxInstance.address);
        return Persona.deployed().then(function(pinstance){
          persona1 = pinstance;
          console.log("Persona 1 deployed at: "+persona1.address);
        });
      });
    });
  });

  it("Should fetch Token total Supply", function(){
    return toknInstance.totalSupply.call()
    .then(function(a){
      console.log( "Total token supply:",Number(a));
    })
    /*.then(function(){
      return consxInstance.totalSupply.call()
      .then(function(a){
      console.log( "ConsX Total token supply:",Number(a));
      });
    });*/
  });

  /*
	it("it should send total Tokens to a Persona Contract", function(){
		return TokenWallet.deployed().then(function(){
			return ConsensusX.deployed().then(function(instance){
				var consxInstance = instance;
        console.success("ConsX deployed at: "+consxInstance);
				return Persona.deployed().then(function(pinstance){
          persona1 = pinstance;
          console.success("ConsX deployed at: "+consxInstance);
			})
		})
	});
  */

});
