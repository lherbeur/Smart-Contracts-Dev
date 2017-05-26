pragma solidity ^0.4.11;

import "truffle/Assert.sol";
/*import "truffle/DeployedAddresses.sol";*/
import "../contracts/CallContract.sol";

contract TestCallContract {

    address not = new CallContract();

    function testcallNothing () {

        bool expected = true;
        /*require(not.call(bytes4(sha3("furtherNothing(bytes32)")), promise) == true);*/

        Assert.equal( not.call(bytes4(sha3("furtherNothing(bytes32)")), "promise"), expected, "Answer should be true" );
    }

}
