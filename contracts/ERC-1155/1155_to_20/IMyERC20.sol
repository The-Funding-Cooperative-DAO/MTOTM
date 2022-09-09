//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.7/contracts/token/ERC20/IERC20.sol";

interface IMyERC20 is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function uri() external view returns (string memory);
}
