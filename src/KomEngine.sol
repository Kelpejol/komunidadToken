// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {KomToken} from "./KomToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract KomEngine is Ownable {

    using SafeERC20 for IERC20;

    error KomEngine__NeedMoreThanZero();
    error KomEngine__InValidAddress();
    error KomEngine__InvalidSignature();

    



    event UserClaimed (address _user, uint256 _amount);

    IERC20 private immutable i_tokenAddress;
   
    constructor(IERC20 _tokenAddress) Ownable(msg.sender){
      i_tokenAddress = _tokenAddress;
   
    }

    modifier needMoreThanZero(uint256 _amount) {
        if(_amount <= 0) {
            revert KomEngine__NeedMoreThanZero();
        }
        _;
    }

    function claimToken(uint256 _amount, uint8 v, bytes32 r, bytes32 s) external needMoreThanZero(_amount){

        if(msg.sender == address(0)){
            revert KomEngine__InValidAddress();
        }
         bytes32 messageHash = getMessageHash(msg.sender, _amount);
        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);
        if(!_isValidSignature( ethSignedMessageHash, v, r, s)) {
            revert KomEngine__InvalidSignature();
        }
        emit UserClaimed(msg.sender, _amount);
        i_tokenAddress.safeTransfer(msg.sender, _amount);
    }

      function getMessageHash(
        address _to,
        uint256 _amount
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount));
    }

    //   function splitSignature(bytes memory sig)
    //     internal
    //     pure
    //     returns (uint8 v, bytes32 r, bytes32 s)
    // {
    //     require(sig.length == 65);

    //     assembly {
    //         // first 32 bytes, after the length prefix.
    //         r := mload(add(sig, 32))
    //         // second 32 bytes.
    //         s := mload(add(sig, 64))
    //         // final byte (first byte of the next 32 bytes).
    //         v := byte(0, mload(add(sig, 96)))
    //     }

    //     return (v, r, s);
    // }

      function _isValidSignature( bytes32 digest, uint8 v, bytes32 r, bytes32 s) internal view returns(bool) {
       (address actualSigner, , ) = ECDSA.tryRecover(digest, v, r, s);
       address owner = owner();
       return actualSigner == owner;
    }

     

    function getTokenAddress() external view returns(IERC20) {
        return i_tokenAddress;
    }

   
}