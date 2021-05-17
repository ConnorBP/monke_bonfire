// contracts/Monke.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Monke is ERC20("Monke", "MONK"), Ownable  {
    // Burn address
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
        /// @dev overrides transfer function to meet tokenomics of Monke
    function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
        if (recipient == BURN_ADDRESS) {
            super._transfer(sender, recipient, amount);
        } else {
            // 1% of every transfer burnt
            uint256 burnAmount = amount / 100;
            // 99% of transfer sent to recipient
            uint256 sendAmount = amount - burnAmount;
            require(amount == sendAmount + burnAmount, "Monke::transfer: Burn value invalid");

            super._transfer(sender, BURN_ADDRESS, burnAmount);
            super._transfer(sender, recipient, sendAmount);
            amount = sendAmount;
        }
    }

}