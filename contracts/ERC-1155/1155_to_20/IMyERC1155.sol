//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.7/contracts/token/ERC1155/IERC1155.sol";
import "./IERC1155Views.sol";

interface IMyERC1155 is IERC1155, IERC1155Views { }
