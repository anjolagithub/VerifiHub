// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract VerifiHub is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant VERIFIER_ROLE = keccak256("VERIFIER_ROLE");

    struct IdentityData {
        bytes32 proof;         // Hash or ZK proof for identity verification
        string metadata;       // Optional metadata like email hash or role
        bool verified;
    }

    mapping(address => IdentityData) private identities;

    event IdentityStored(address indexed user, bytes32 proof);
    event IdentityVerified(address indexed user);
    event IdentityRevoked(address indexed user);

    constructor() {
        _grantRole(ADMIN_ROLE, msg.sender);
        _grantRole(VERIFIER_ROLE, msg.sender);
    }

    // Store identity with hashed proof; metadata optional
    function storeIdentityProof(address user, bytes32 proof, string memory metadata) 
        external 
        onlyRole(VERIFIER_ROLE) 
    {
        identities[user] = IdentityData(proof, metadata, false);
        emit IdentityStored(user, proof);
    }

    // Verify identity by matching proof, marking user as verified
    function verifyIdentity(address user, bytes32 proof) external onlyRole(VERIFIER_ROLE) {
        require(identities[user].proof == proof, "Proof mismatch");
        identities[user].verified = true;
        emit IdentityVerified(user);
    }

    // Allow admin to revoke identity
    function revokeIdentity(address user) external onlyRole(ADMIN_ROLE) {
        identities[user].verified = false;
        emit IdentityRevoked(user);
    }

    function isVerified(address user) external view returns (bool) {
        return identities[user].verified;
    }
}
