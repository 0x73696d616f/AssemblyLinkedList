// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Test.sol";
import "../src/LinkedList.sol";

contract LinkedListTest is Test {
    LinkedList private _linkedList;

    function setUp() public {
        _linkedList = new LinkedList();
    }

    function testInsert() public {
        _insert(1);
        _insert(2);
        _insert(3);   
    }

    function testLoopOverLinkedList() public {
        uint8[3] memory expectedValues = [1, 2, 3];
        uint8 idx = 0;
        _insert(expectedValues[2]);
        _insert(expectedValues[1]);
        _insert(expectedValues[0]);

        bytes32 slot_ = _linkedList.getHead();
        while (slot_ != bytes32(0)) {
            uint256 value_ = _linkedList.getUint256(slot_, LinkedList.Variables.value);
            assertEq(value_, expectedValues[idx]);
            ++idx;
            slot_ = _linkedList.getBytes32(slot_, LinkedList.Variables.next);
        }
    }

    function _insert(uint256 value_) internal {
        _linkedList.insert(value_);
        assertEq(_linkedList.getUint256(_linkedList.getHead(), LinkedList.Variables.value), value_);
    }
}