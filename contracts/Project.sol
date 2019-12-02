pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract Proj is Context,ERC20,ERC20Detailed{
    uint256 public price;
    constructor(
        string memory _name,
        string memory _description,
        uint8 _decimals,
        uint256 _price)
        ERC20Detailed(_name, _description, _decimals) public payable{
            price = _price;
            _mint(_msgSender(), 10 ** uint256(decimals()));
            approve(tx.origin, 10 **uint256(decimals()));
    }
  
}