
var ConsensusX = artifacts.require("ConsensusX");
var Vesting = artifacts.require("Vesting");
// var DeployedAddresses = artifacts.require("DeployedAddresses");


contract('Vesting', function(accounts) {

    var consensusXAddr = accounts[0];
    var vestingInstance;


  //assign 2 schedules
  it("should assign 2 schedules correctly", function() {

     return Vesting.new(consensusXAddr).then(function(instance) {
          vestingInstance = instance;

        }).then(function() {
         vestingInstance.assignSchedule("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", "Wunmi", "10097400848139", "19097478848939", "19097438848939", "600", { from: consensusXAddr});
         vestingInstance.assignSchedule("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", "Wunmi", "10097400848150", "19097478848960", "19097438848955", "800", { from: consensusXAddr});

         return vestingInstance.getVestingScheduleCount("0xee370bbaf46ed8af654cd9987d64652dedf5f63e");

        }).then(function(scheduleLength) {

          assert.equal(scheduleLength.toNumber(), 2, "Length of schedules not equal. 2 Schedules not correctly assigned!");
       });
  });

    //check the values returned by the getChunkedVestingSchedule
    it("should return a multidimensional array whose value is equal to schedule array", function () {
            var schedule = [
                "Promise", 10097400848139, 19097478848939, 19097438848939, 600
            ];
            return vestingInstance.assignSchedule(accounts[1], "Promise", 10097400848139, 19097478848939, 19097438848939, 600, {
                from: consensusXAddr
            }).then(function () {
                return vestingInstance.getChunkedVestingSchedule.call(accounts[1], 0, {
                    from: consensusXAddr
                });
            }).then(function (chunkedVesting) {

                assert.equal(hex_to_ascii(chunkedVesting[0][0]).trim().replace(/\0/g, ''), schedule[0], "Argument 1, persona name, does not match, but should");
                assert.equal(chunkedVesting[1][0].c[0], schedule[1], "Argument 1, schedule start, not equal");
                assert.equal(chunkedVesting[2][0].c[0], schedule[2], "Argument 2, schedule end, not equal");
                assert.equal(chunkedVesting[3][0].c[0], schedule[3], "Argument 3, schedule cliff, not equal");
                assert.equal(chunkedVesting[4][0].c[0], schedule[4], "Argument 4, schedule value, not equal");

            });
     });


       //check consensusXAddr addr set properly
       it("should set consensusXAddr correctly", function() {

            var err = false;

           return vestingInstance.setConsensusXAddr(accounts[1], { from: consensusXAddr}).then(function() {

              return vestingInstance.getVestingScheduleCount.call("0xee370bbaf46ed8af654cd9987d64652dedf5f63e", { from: consensusXAddr});
            }).catch (function (error) {

               err = error.message.search('invalid opcode') >= 0;
              //  console.log("in catch, err-"+err);

          }).then(function(){
            // console.log("in then - b4 assert-"+err);
            assert.equal(err, true, "Expected invalid opcode for failure but not received!");
          });

      });

        function hex_to_ascii(str1)
         {
            var hex  = str1.toString();
            var str = '';
            for (var n = 0; n < hex.length; n += 2) {
                str += String.fromCharCode(parseInt(hex.substr(n, 2), 16));
            }
            return str;
         }

});
