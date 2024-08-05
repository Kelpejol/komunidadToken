// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {KomEngine} from "../src/KomEngine.sol";
import {KomToken} from "../src/KomToken.sol";
import {NetworkConfig} from "./NetworkConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployKomToken is Script {
 
 KomEngine private komEngine;
 KomToken private komToken;
 NetworkConfig private networkConfig;

 uint256 private constant AMOUNT_TO_TRANSFER = 1_000_000_000e18;


      function run() external returns(KomToken, KomEngine) {
         networkConfig = new NetworkConfig();
         uint256 deployerKey = networkConfig.activeNetworkConfig();
         vm.startBroadcast(0xdea24581ecace2e0bc39745db3e0c71b525c0eb3db7d1947eae8215d8d086018);
         komToken = new KomToken();
         komEngine = new KomEngine(komToken);
         IERC20(komToken).transfer(address(komEngine), AMOUNT_TO_TRANSFER);
         vm.stopBroadcast();
         return (komToken, komEngine);
      }

}