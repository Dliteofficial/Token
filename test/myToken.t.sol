//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/myToken.sol";

contract myTokenTest is Test {
    myToken MT;
    address owner;

    function setUp () public {
        MT = new myToken("DliteToken", "DTK", 18, 100, 1000);
        owner = MT.owner();
        emit log_named_address("Contract Deployer is: ", owner);
        emit log_named_uint("Initial Mint of Token is: ", MT.initialSupply());
    }

    function testTokenInfo () public {
        assertEq(MT.name(), "DliteToken");
        emit log_named_string("Token Name is: ", MT.name());
        assertEq(MT.symbol(), "DTK");
        emit log_named_string("Token Symbol is: ", MT.symbol());
        assertEq(MT.initialSupply(), 100);
        emit log_named_uint("Initial Supply of Token is: ", MT.initialSupply());
        assertEq(MT.supplyCap(), 1000);
        emit log_named_uint("Max Supply of Token is: ", MT.supplyCap());
    }

    function testMint () public {
        MT.mint(owner, 900);
        assertEq(MT.balanceOf(owner), 1000);
    }

    function testTransfer() public {
        MT.mint(owner, 900);
        MT.transfer(address(0), 100);
        assertEq(MT.balanceOf(owner), 900);
        assertEq(MT.balanceOf(address(0)), 100);
    }

    function testBurn () public {
        MT.burn(10);
        assertEq(MT.balanceOf(owner), 90);
        emit log_uint(MT.balanceOf(owner));
    }
}