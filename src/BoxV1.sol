// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable@4.9.2/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable@4.9.2/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable@4.9.2/access/OwnableUpgradeable.sol";

// storage is stored in the proxy, NOT the implementation
// Proxy (borrowing funcs) -> implementation
// Proxy -> deploy implementation -> call some "initializer" function

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    // can not use constructor with proxy
    constructor() {
        _disableInitializers(); // dont call constructor
    }

    // initialize like constructor for Proxy
    function initialize() public initializer {
        __Ownable_init(); // sets owner to: owner = msg.sender
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
