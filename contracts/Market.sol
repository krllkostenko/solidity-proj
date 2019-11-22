pragma solidity >=0.4.21 <0.6.0;
import "./Project.sol";


contract Market{
    Project[] projectMarket;
    mapping (address => Project) public projects;
    mapping(address => uint256) public balances;
    address payable wallet = msg.sender;

    function createProject(
        string memory projectName,
        string memory projectDescription,
        uint256 amountOfTokens
        ) public{
            projects[msg.sender] = new Project(projectName,projectDescription,amountOfTokens);
    }

    function getProjectInfo(address key) public view returns(string memory, string memory,string memory,string memory,string memory, uint256){
      return (
          "Project name: ", projects[key].getName(),
          "Project description: ", projects[key].getDescription(),
          "Amount of tokens: ",projects[key].amountOfTokens()
          );
    }

    function buyToken(address key,uint256 amount) public payable{
        require(amount > 0,"You can't buy 0 tokens");
        uint256 tokenPrice = projects[key].getTokenPrice();
        uint256 amountOfTokens = getAmountOfTokens(key);
        require(wallet.balance >= tokenPrice * amount,"Balance has to be greater or equal to token price");
        balances[wallet] += amount;
        wallet.send(tokenPrice * amount);
        amountOfTokens -= amount;
        setAmountOfTokens(key,amountOfTokens);
    }

    function sellToken(address key, uint256 amount) external payable{
        require(amount > 0,"You can't sell 0 tokens");
        uint256 tokenPrice = projects[key].getTokenPrice();
        uint256 amountOfTokens = getAmountOfTokens(key);
        balances[wallet] -= amount;
        wallet.send(tokenPrice * amount);
        amountOfTokens += amount;
        setAmountOfTokens(key,amountOfTokens);
    }
    
    function getAmountOfTokens(address key) public view returns(uint256){
       return projects[key].amountOfTokens();
    }
   
   function setAmountOfTokens(address key, uint256 amount) public {
       projects[key].setAmountOfTokens(amount);
   }
   
   function getTokenPrice(address key) public view returns(uint256){
       return projects[key].getTokenPrice();
   }

}