// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract RegularLinkedList {

    /**
     * @notice A node of the linked list.
     * @param value The value of the node.
     * @dev Use this to pass parameters to the insert function.
     */
    struct Node {
        uint256 value;
        uint256 nextId;
    }

    /// @notice The head of the linked list.
    uint256 private _head;
    /// @notice The tail of the linked list.
    uint256 private _tail;

    /** 
     * @notice Maps an Id to a node.
    */
    mapping(uint256 => Node) private _nodes;

    /// @notice The nonce for the linked list.
    uint256 private _id;

    /**
     * @notice Inserts a node into the linked list.
     * @param node_ The new node.
     * @param previousNodeId_ The slot of the previous node.
     */
    function insert(Node memory node_, uint256 previousNodeId_) public {
        uint256 currId_ = ++_id;

        _nodes[currId_] = node_;

        // If the node is not the last, set the next node.
        if (node_.nextId == 0) _tail = currId_;

        // If the node is not the first, set the previous node to point to the new node.
        if (previousNodeId_ != 0) _nodes[previousNodeId_].nextId = currId_;
        // If the node is the first, then it is the new head.
        else _head = currId_;
    }

    /**
     * @notice Removes a node from the linked list.
     * @dev Deleting the node will actually spend more gas, so we just leave it "as is".
     * @param previousNodeId_ The previous node.
     * @param nextNodeId_ The next node.
     */
    function remove(uint256 previousNodeId_, uint256 nextNodeId_) public {
        // If the next node is null, the previous node becomes the tail.
        if (nextNodeId_ == 0) _tail = previousNodeId_;

        // If the removed node is not the head, set the next node of the previous node to the next node.
        if (previousNodeId_ != 0) _nodes[previousNodeId_].nextId = nextNodeId_;
        // If the previous node is null, the current node is the head, so set the head as the next node.
        else _head = nextNodeId_;
    }

    /**
     * @notice Returns the head of the linked list.
     * @return The head of the linked list.
     */
    function getHead() external view returns(uint256) {
        return _head;
    }

    /**
     * @notice Returns the tail of the linked list.
     * @return The tail of the linked list.
     */
    function getTail() external view returns(uint256) {
        return _tail;
    }

    function getNode(uint256 id_) external view returns(Node memory) {
        return _nodes[id_];
    }
}