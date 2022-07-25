// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/structs/JBGroupedSplits.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/structs/JBSplit.sol';
import './IJBDirectory.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBProjects.sol';

interface IJBSplitsStore {
  event SetSplit(
    uint256 indexed projectId,
    uint256 indexed domain,
    uint256 indexed group,
    JBSplit split,
    address caller
  );

  function projects() external view returns (IJBProjects);

  function directory() external view returns (IJBDirectory);

  function splitsOf(
    uint256 _projectId,
    uint256 _domain,
    uint256 _group
  ) external view returns (JBSplit[] memory);

  function set(
    uint256 _projectId,
    uint256 _domain,
    JBGroupedSplits[] memory _groupedSplits
  ) external;
}
