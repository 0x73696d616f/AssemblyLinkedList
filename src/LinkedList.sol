// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LinkedList {

    /// @notice The head of the linked list.
    bytes32 private _head;

    /**
     * @notice The variables of a node.
     * @dev The order of the variables is important.
     */
    enum Variables { value, next }

    /**
     * Struct {
     *    uint256 value;
     *    bytes32 next;
     * }
     */

    /**
     * @notice Inserts a new node into the linked list.
     * @dev The new node will be the new head of the linked list.
     */
    function insert(uint256 value_) public {
        bytes32 head_ = _head;
        bytes32 slot_ = keccak256(abi.encodePacked(head_));
        _setUint256(slot_, Variables.value, value_);
        _setBytes32(slot_, Variables.next, head_);
        _head = slot_;
    }

    /**
     * @notice Returns the head of the linked list.
     * @return The head of the linked list.
     */
    function getHead() external view returns(bytes32) {
        return _head;
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