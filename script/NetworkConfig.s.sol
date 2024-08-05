// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";

contract NetworkConfig is Script {

    uint256 private constant DEFAULT_ANVIL_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 private DEFAULT_POLYGON_KEY = vm.envUint("PRIVATE_KEY");
       uint256 public activeNetworkConfig;

    constructor() {
        if(block.chainid == 80002) {
             activeNetworkConfig = getPolygonAmoyConfig();
        }
        activeNetworkConfig = getOrCreateAnvilMaticConfig();
    }


    function getOrCreateAnvilMaticConfig() public pure returns(uint256) {
        return DEFAULT_ANVIL_KEY;
    }

    function getPolygonAmoyConfig() public view returns(uint256) {
      return DEFAULT_POLYGON_KEY;
    }



   
    

}