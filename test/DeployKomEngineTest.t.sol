// SPDX-License-Identifier: MIT
 pragma solidity 0.8.24;

// import {Test, console2} from "forge-std/Test.sol";
// import {DeployKomToken} from "../script/DeployKomToken.s.sol";
// import {KomToken} from "../src/KomToken.sol";
// import {KomEngine} from "../src/KomEngine.sol";
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


// contract DeployKomEngineTest is Test {

//     DeployKomToken deploy;
//     KomToken komToken;
//     KomEngine komEngine;

     
//      function setUp() external {
//         deploy = new DeployKomToken();
//         (komToken, komEngine) = deploy.run();
//      }


//      function testGetOwnerReturnsActualOwner() external view {
//         address actualOwner = 0x26aD21B833F4676f5F838A1A4cBa236e1a179745;
//         address expectedOwner = komEngine.owner();

//         assertEq(actualOwner, expectedOwner);
//      }

//      function testCanClaimToken() external {
//         address owner = komEngine.owner();
//         uint256 amount = 1000e18;
//         bytes32 message = komEngine.getMessage(owner, amount);
//         uint256 prevBalance = IERC20(komToken).balanceOf(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
//         (uint8 v, bytes32 r, bytes32 s) = vm.sign(0xdea24581ecace2e0bc39745db3e0c71b525c0eb3db7d1947eae8215d8d086018, message);
//         console2.log("v:",v);
//       //   console2.log("r:",r);
//       //   console2.log("s:",s);
//         vm.prank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
//         komEngine.claimToken(amount, v, r, s);
//         uint256 newBalance = IERC20(komToken).balanceOf(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
//         console2.log(prevBalance);
//         console2.log(newBalance);

//         assert(newBalance > prevBalance);
      
//      }
// }