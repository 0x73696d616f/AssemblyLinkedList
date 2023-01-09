// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LinkedList {
    /**
     * @notice The variables of a node.
     * @dev The order of the variables is important.
     */
    enum Variables { value, next }

    /**
     * @notice A node of the linked list.
     * @param value The value of the node.
     * @dev Use this to pass parameters to the insert function.
     */
    struct Node {
        uint256 value;
    }

    /// @notice The head of the linked list.
    bytes32 private _head;
    /// @notice The tail of the linked list.
    bytes32 private _tail;

    /** 
     * @notice The nonce for the linked list.
     * @dev This is used to generate a unique slot for each node.
     *      It could be computed off chain.
    */
    uint256 private _nonce;

    /**
     * @notice Inserts a node into the linked list.
     * @param node_ The new node.
     * @param previousNodeSlot_ The slot of the previous node.
     * @param nextNodeSlot_ The slot of the next node.
     */
    function insert(Node memory node_, bytes32 previousNodeSlot_, bytes32 nextNodeSlot_) public returns(bytes32 slot_){
        slot_ = keccak256(abi.encodePacked(++_nonce));
        // Set the new node value.
        _setUint256(slot_, Variables.value, node_.value);

        // If the node is not the last, set the next node.
        if (nextNodeSlot_ != bytes32(0)) _setBytes32(slot_, Variables.next, nextNodeSlot_);
        // If the node is the last, then it is the new tail.
        else _tail = slot_;

        // If the node is not the first, set the previous node to point to the new node.
        if (previousNodeSlot_ != bytes32(0)) _setBytes32(previousNodeSlot_, Variables.next, slot_);
        // If the node is the first, then it is the new head.
        else _head = slot_;
    }

    /**
     * @notice Removes a node from the linked list.
     * @dev Deleting the node will actually spend more gas, so we just leave it "as is".
     * @param previousNodeSlot_ The previous node.
     * @param nextNodeSlot_ The next node.
     */
    function remove(bytes32 previousNodeSlot_, bytes32 nextNodeSlot_) public {
        // If the next node is null, the previous node becomes the tail.
        if (nextNodeSlot_ == bytes32(0)) _tail = previousNodeSlot_;

        // If the removed node is not the head, set the next node of the previous node to the next node.
        if (previousNodeSlot_ != bytes32(0)) _setBytes32(previousNodeSlot_, Variables.next, nextNodeSlot_);
        // If the previous node is null, the current node is the head, so set the head as the next node.
        else _head = nextNodeSlot_;
    }

    /**
     * @notice Returns the head of the linked list.
     * @return The head of the linked list.
     */
    function getHead() external view returns(bytes32) {
        return _head;
    }

    /**
     * @notice Returns the tail of the linked list.
     * @return The tail of the linked list.
     */
    function getTail() external view returns(bytes32) {
        return _tail;
    }

    /**
     * @notice Sets a uint256 of a node.
     * @param slot_ The slot of the node.
     * @param var_ The variable of the node.
     * @param value_ The value.
     */
    function _setUint256(bytes32 slot_, Variables var_, uint256 value_) internal {
        assembly {
            sstore(add(slot_, var_), value_)
        }
    }

    /**
     * @notice Sets a bytes32 of a node.
     * @param slot_ The slot of the node.
     * @param var_ The variable of the node.
     * @param value_ The value.
     */
    function _setBytes32(bytes32 slot_, Variables var_, bytes32 value_) internal {
        assembly {
            sstore(add(slot_, var_), value_)
        }
    }

    /**
     * @notice Gets a uint256 of a node.
     * @param slot_ The slot of the node.
     * @param var_ The variable of the node.
     * @return value_ The value.
     */
    function getUint256(bytes32 slot_, Variables var_) public view returns(uint256 value_) {
        assembly {
            value_ := sload(add(slot_, var_))
        }
    }

    /**
     * @notice Gets a bytes32 of a node.
     * @param slot_ The slot of the node.
     * @param var_ The variable of the node.
     * @return value_ The value.
     */
    function getBytes32(bytes32 slot_, Variables var_) public view returns(bytes32 value_) {
        assembly {
            value_ := sload(add(slot_, var_))
        }
    }
}