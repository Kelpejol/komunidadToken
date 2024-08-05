// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KomToken is ERC20{

    uint128 private constant TOTAL_SUPPLY =  1_000_000_000e18;

    constructor() ERC20("KomToken", "KOM") {
       _mint(msg.sender, TOTAL_SUPPLY);
    }

}