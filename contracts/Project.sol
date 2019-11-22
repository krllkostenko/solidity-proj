pragma solidity >=0.4.21 <0.6.0;

contract Project{
    string name;
    string description;
    address payable wallet = msg.sender;
    uint256 public amountOfTokens;
    uint256 tokenPrice= 5000 wei;

    mapping (address => ProjectData) projectData;
    address[] public projectAddress;

    struct ProjectData{
        string name;
        string description;
        uint256 amountOfTokens;
    }

    constructor(
         string memory _name,
         string memory _description,
         uint256 _amountOfTokens
        ) public {
            name = _name;
            description = _description;
            amountOfTokens = _amountOfTokens;
            setProjectData(_name,_description,amountOfTokens);
    }

    function setProjectData(string memory _name, string memory _description, uint256 _amountOfTokens) internal {
        ProjectData memory data = projectData[wallet];
        data.name = _name;
        data.description = _description;
        data.amountOfTokens = _amountOfTokens;
        projectAddress.push(wallet);
    }

    function setAmountOfTokens(uint256 newAmount) external {
        amountOfTokens = newAmount;
    }

    function getProjectInfo() external view returns(string memory, string memory, uint256){
        return(projectData[wallet].name, projectData[wallet].description, projectData[wallet].amountOfTokens);
    }

    function getTokenPrice() external view returns(uint256){
        return tokenPrice;
    }

    function getName() public view returns(string memory){
        return name;
    }

    function getDescription() public view returns(string memory){
        return description;
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
}