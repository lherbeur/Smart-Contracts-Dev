
var ConsensusX = artifacts.require("ConsensusX");
var Vesting = artifacts.require("Vesting");
// var DeployedAddresses = artifacts.require("DeployedAddresses");

var consensusXAddr = "";

contract('Vesting', function() {

  //assign schedule test
  it("should assignSchedule correctly", function() {

   var vestingInstance;
   var lengthOfSchedules;
   var schedulesCount;

   return ConsensusX.new().then(function(instance) {

       consensusXAddr = instance.address;
       //assert("", instance.address, "not empty address---"+instance.address);
   });

     return Vesting.new(consensusXAddr).then(function(instance) {
       vestingInstance = instance;
       return vestingInstance.assignSchedule
       ("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", "Wunmi", "10097400848139", "19097478848939", "4", "600", { from: consensusXAddr});
       //(_toAddress, _name, _start, _end, _cliff, _value);
     }).then(function(scheduleLength) {
       lengthOfSchedules = scheduleLength.toNumber();
       return vestingInstance.getVestingScheduleCount(_toAddress);
     }).then(function(scheduleCount) {
       schedulesCount = scheduleCount.toNumber();

       assert.equal(lengthOfSchedules, schedulesCount, "Length of schedules not equal. Schedules not correctly assigned!");
     });
   });



   //check consensusXAddr addr set properly
   it("should set consensusXAddr correctly", function() {

      var newConsensusXAddr = "";

      return ConsensusX.new().then(function(instance) {

          newConsensusXAddr = instance.address;
      });

      return Vesting.new(consensusXAddr).then(function(instance) {

          instance.setConsensusXAddr(newConsensusXAddr, { from: consensusXAddr}).then(function() {

          assert.equal(consensusXAddr, newConsensusXAddr, "consensusXAddr not properly set!");
        });
      })
    });


    // check the values returned by the getChunkedVestingSchedule
    contract("Vesting", function (accounts) {
        it("should return a multidimensional array whose value is equal to schedule array", function () {
            var meta,
            schedule = [
                "Promise", 10097400848139, 19097478848939, 19097438848939, 600
            ];

            return Vesting.new(accounts[0]).then(function (instance) {
                meta = instance;
                return instance.assignSchedule("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", "Promise", 10097400848139, 19097478848939, 19097438848939, 600, {
                    from: accounts[0]
                });
            }).then(function (scheduleLength) {
                return meta.getChunkedVestingSchedule.call("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", 0, {
                    from: accounts[0]
                });
            }).then(function (chunkedVesting) {
                // console.log(chunkedVesting);
                function hex_to_ascii(str1)
                 {
                	var hex  = str1.toString();
                	var str = '';
                	for (var n = 0; n < hex.length; n += 2) {
                		str += String.fromCharCode(parseInt(hex.substr(n, 2), 16));
                	}
                	return str;
                 }
                assert.equal(hex_to_ascii(chunkedVesting[0][0]).trim().replace(/\0/g, ''), schedule[0], "Argument 1, persona name, does not match, but should");
                assert.equal(chunkedVesting[1][0].c[0], schedule[1], "Argument 1, schedule start, not equal");
                assert.equal(chunkedVesting[2][0].c[0], schedule[2], "Argument 2, schedule end, not equal");
                assert.equal(chunkedVesting[3][0].c[0], schedule[3], "Argument 3, schedule cliff, not equal");
                assert.equal(chunkedVesting[4][0].c[0], schedule[4], "Argument 4, schedule value, not equal");
                // assert.equal(chunkedVesting[5][0].c[0], schedule[1], "Argument 5, schedule start, not equal");

            });
        });
    });


});
