// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import { myToken } from "src/myToken.sol";

contract myTokenScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new myToken("DliteToken", "DTK", 18, 100, 1000);
        vm.stopBroadcast();
    }
}
