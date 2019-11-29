pragma solidity >=0.4.21 <0.6.0;
import "./Project.sol";
import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";

contract Market{

    using SafeMath for uint256;
    mapping(string => Proj) public projectsMarket;

    function createProject(string memory _name,string memory _description,uint8 _decimals, uint _price)public{
        require(_decimals>0,"Project should have at least 1 token");
        require(_decimals>0,"Price cannot be 0");
        Proj project = new Proj(_name, _description, _decimals, _price);
        projectsMarket[_name] = project;
    }

    function getProjectInfo(string memory _name)
    public view returns(
        string memory,
        string memory,
        string memory,
        uint256,
        string memory,
        uint256){
        return (
            projectsMarket[_name].name(),
            projectsMarket[_name].symbol(),
            "Project price: ",
            getProjectPrice(_name),
            "Amount of shares: ",
            getAmountOfShares(_name)
            );
    }

    function getAmountOfShares(string memory _name)public view returns(uint256){
        return projectsMarket[_name].decimals();
    }

    function getProjectPrice(string memory _name)public view returns(uint256){
        return projectsMarket[_name].price();
    }

    function getBalance(string memory _name)public view returns(uint256){
        return projectsMarket[_name].totalSupply();
    }

    function sellTokens(string memory _name,address buyer,uint256 amount)public{
        require(amount>0,'Amount should be greater than 0');
        projectsMarket[_name].transfer(buyer, getProjectPrice(_name) * amount);
    }

    function buyTokens(string memory _name, address seller, uint256 amount)public{
        require(amount>0,'Amount should be greater than 0');
        projectsMarket[_name].transferFrom(seller, tx.origin, amount);
    }
}