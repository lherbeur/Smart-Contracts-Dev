var ConsensusX = artifacts.require("ConsensusX");
var Vesting = artifacts.require("Vesting");
// var DeployedAddresses = artifacts.require("DeployedAddresses");

var consensusXAddr = "";

contract('Vesting', function() { //consensusXAddr

  // it("should set ConsensusX addr", function() {

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

});
