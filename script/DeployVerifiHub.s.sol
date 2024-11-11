// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/VerifiHub.sol";

contract DeployVerifiHub is Script {
    function run() external {
        vm.startBroadcast();
        VerifiHub verifiHub = new VerifiHub();
        vm.stopBroadcast();
        console.log("VerifiHub deployed at:", address(verifiHub));
    }
}
