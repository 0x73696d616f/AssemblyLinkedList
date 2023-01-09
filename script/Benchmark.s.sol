// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Script.sol";
import "../src/LinkedList.sol";
import "../src/RegularLinkedList.sol";

contract Benchmark is Script {

    function run() public {
        vm.broadcast();
        LinkedList linkedList_ = new LinkedList();
        vm.stopBroadcast();

        vm.broadcast();
        RegularLinkedList regularLinkedList_ = new RegularLinkedList();
        vm.stopBroadcast();

        vm.broadcast();
        linkedList_.insert(LinkedList.Node(1), 0, 0);
        vm.stopBroadcast();

        vm.broadcast();
        regularLinkedList_.insert(RegularLinkedList.Node(1, 0), 0);
        vm.stopBroadcast();

        vm.broadcast();
        linkedList_.remove(0, 0);
        vm.stopBroadcast();

        vm.broadcast();
        regularLinkedList_.remove(0, 0);
        vm.stopBroadcast();
    }
}
