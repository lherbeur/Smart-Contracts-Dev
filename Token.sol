pragma solidity^0.4.10;

contract Token  //conforming to the ERC20 /223 standard
{
  mapping(address => TokenAttributes) tokens;

struct TokenAttributes
{
    address tokenOwner;
    uint tokenValue;
    uint amountOfTokens;
    
}

    function Token()
    {
//...
    }


}




