// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/VerifiHub.sol";

contract VerifiHubTest is Test {
    VerifiHub public verifiHub;

    function setUp() public {
        verifiHub = new VerifiHub();
    }

    function testStoreIdentityProof() public {
        bytes32 proof = keccak256(abi.encodePacked("user123"));
        verifiHub.storeIdentityProof(address(this), proof, "metadata");
        // Check if event emitted and data stored correctly
    }

    function testVerifyIdentity() public {
        bytes32 proof = keccak256(abi.encodePacked("user123"));
        verifiHub.storeIdentityProof(address(this), proof, "metadata");
        verifiHub.verifyIdentity(address(this), proof);
        assertTrue(verifiHub.isVerified(address(this)));
    }

    function testRevokeIdentity() public {
        verifiHub.revokeIdentity(address(this));
        assertFalse(verifiHub.isVerified(address(this)));
    }
}
