pragma solidity ^0.4.11;

/*import "./ConvertLib.sol";*/

contract CallContract {

    event nothingFired (bytes32);

    function furtherNothing (bytes32 promise){
        nothingFired(promise);

    }

}
