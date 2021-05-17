// contracts/MonkeBonfire.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Naner.sol";

contract MonkeBonfire is Ownable {
    using SafeERC20 for ERC20;

    // Burn address
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    uint public constant BURN_RATIO = 1000;

    ERC20 monke_token;
    Naner banana_token;

    event Swap(address from, uint amount);

    constructor(address _monke_token, address _banana_token) {
        monke_token = ERC20(_monke_token);
        banana_token = Naner(_banana_token);
    }

    function swap(uint _amount) public {
        require(_amount >= BURN_RATIO, "Monke::bonfire: Not enough MONKE Tokens for burn. Must have at least enough to satisfy the burn ratio.");
        // 0.1% of transfer sent to recipient as BANANAS
        uint256 sendAmount = _amount / BURN_RATIO;//divides with integrated sol 0.8 safemath
        address _from = msg.sender;
        monke_token.safeTransferFrom(_from, BURN_ADDRESS, _amount);
        banana_token.mint(_from, sendAmount);
        emit Swap(_from, _amount);
    }

}