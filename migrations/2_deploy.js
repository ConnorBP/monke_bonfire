// migrations/2_deploy.js
const Naner = artifacts.require("Naner");
const Monke = artifacts.require("Monke");
const MonkeBonfire = artifacts.require("MonkeBonfire");

module.exports = async function (deployer, network) {
    if (network == "maticmain") {
        await deployer.deploy(Naner).then(function() {
            return deployer.deploy(Monke).then(function() {
              return deployer.deploy(MonkeBonfire, "0x1A0373828B058E2c8D39c3Ddd1Df06DCc6201a32", Naner.address)
            })
        });
    } else {
        await deployer.deploy(Naner).then(function() {
            return deployer.deploy(Monke).then(function() {
              return deployer.deploy(MonkeBonfire, Monke.address, Naner.address)
            })
        });
    }
};