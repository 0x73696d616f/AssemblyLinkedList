// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Test.sol";
import "../src/LinkedList.sol";

contract LinkedListTest is Test {
    LinkedList private _linkedList;

    function setUp() public {
        _linkedList = new LinkedList();
    }

    function testInsertAtTheTail() public {
        _insertAtTheTail(1); 
    }

    function testInsertAtTheHead() public {
        _insertAtTheHead(1); 
    }

    function testInsert() public {
        bytes32 slot1_ = _insertAtTheTail(1); 
        // 1.
        bytes32 slot2_ = _insertAtTheHead(2);
        // 2 1.
        bytes32 slot3_ = _insertAtTheTail(3); 
        // 2 1 3.
        bytes32 slot4_ = _insertAtTheHead(4); 
        // 4 2 1 3.
        bytes32 slot5_ = _insert(LinkedList.Node(5), slot2_, slot1_);
        // 4 2 5 1 3.

        assertEq(_linkedList.getBytes32(slot4_, LinkedList.Variables.next), slot2_);
        assertEq(_linkedList.getBytes32(slot2_, LinkedList.Variables.next), slot5_);
        assertEq(_linkedList.getBytes32(slot5_, LinkedList.Variables.next), slot1_);
        assertEq(_linkedList.getBytes32(slot1_, LinkedList.Variables.next), slot3_);
        assertEq(_linkedList.getBytes32(slot3_, LinkedList.Variables.next), bytes32(0));
    }

    function testRemove() public {
        _insertAtTheTail(1);
        _insertAtTheTail(2);
        _insertAtTheTail(3);   
        bytes32 previousNode_ = _linkedList.getHead();
        bytes32 node_ = _linkedList.getBytes32(previousNode_, LinkedList.Variables.next);
        bytes32 nextNode_ = _linkedList.getBytes32(node_, LinkedList.Variables.next);

        _linkedList.remove(previousNode_, nextNode_);
        assertEq(nextNode_, _linkedList.getBytes32(previousNode_, LinkedList.Variables.next));
    }

    function testLoopOverLinkedList() public {
        uint8[3] memory expectedValues = [1, 2, 3];
        uint8 idx = 0;
        _insertAtTheTail(expectedValues[0]);
        _insertAtTheTail(expectedValues[1]);
        _insertAtTheTail(expectedValues[2]);

        bytes32 slot_ = _linkedList.getHead();
        while (slot_ != bytes32(0)) {
            uint256 value_ = _linkedList.getUint256(slot_, LinkedList.Variables.value);
            assertEq(value_, expectedValues[idx]);
            ++idx;
            slot_ = _linkedList.getBytes32(slot_, LinkedList.Variables.next);
        }
    }

    function _insertAtTheTail(uint256 value_) internal returns(bytes32 slot_) {
        bytes32 previousNode_ = _linkedList.getTail();
        bytes32 nextNode_ = bytes32(0);
        slot_ = _insert(LinkedList.Node(value_), previousNode_, nextNode_);
        assertEq(_linkedList.getTail(), slot_);
    }

    function _insert(LinkedList.Node memory node_, bytes32 previousNode_, bytes32 nextNode_) internal returns(bytes32 slot_) {
        slot_ = _linkedList.insert(node_, previousNode_, nextNode_);
        assertEq(_linkedList.getUint256(slot_, LinkedList.Variables.value), node_.value);
        if (previousNode_ != bytes32(0)) 
            assertEq(_linkedList.getBytes32(previousNode_, LinkedList.Variables.next), slot_);
        assertEq(_linkedList.getBytes32(slot_, LinkedList.Variables.next), nextNode_);  
    }

    function _insertAtTheHead(uint256 value_) internal returns(bytes32 slot_) {
        bytes32 previousNode_ = bytes32(0);
        bytes32 nextNode_ = _linkedList.getHead(); 
        slot_ = _insert(LinkedList.Node(value_), previousNode_, nextNode_);
        assertEq(_linkedList.getHead(), slot_);
    }

    function _printLinkedList() internal view {
        console.log("Printing linked list: ");
        bytes32 slot_ = _linkedList.getHead();
        while (slot_ != bytes32(0)) {
            console.logBytes32(slot_);
            slot_ = _linkedList.getBytes32(slot_, LinkedList.Variables.next);
        }
    }
}