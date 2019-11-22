const Project = artifacts.require("Project");
const Market = artifacts.require("Market");

Project.numberFormat = "String";


module.exports = function(deployer) {
  deployer.deploy(Project);
};

module.exports = function(deployer) {
  deployer.deploy(Market);
};

// Market.deployed().then((instance)=>{app = instance;Market.numberFormat = "String";})