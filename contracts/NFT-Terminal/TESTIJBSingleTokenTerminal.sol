// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/structs/JBFundingCycle.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/structs/JBTokenAmount.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBDirectory.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBFundingCycleStore.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBPayDelegate.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBPrices.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBRedemptionDelegate.sol';
import 'https://github.com/jbx-protocol/juice-contracts-v2/blob/main/contracts/interfaces/IJBSingleTokenPaymentTerminal.sol';

  struct Param {
    address _holder;
    uint256 _projectId;
    uint256 _tokenCount;
    uint256 _totalSupply;
  }

interface IJBSingleTokenPaymentTerminalStore {
  function fundingCycleStore() external view returns (IJBFundingCycleStore);

  function directory() external view returns (IJBDirectory);

  function prices() external view returns (IJBPrices);

  function balanceOf(IJBSingleTokenPaymentTerminal _terminal, uint256 _projectId)
    external
    view
    returns (uint256);

  function usedDistributionLimitOf(
    IJBSingleTokenPaymentTerminal _terminal,
    uint256 _projectId,
    uint256 _fundingCycleNumber
  ) external view returns (uint256);

  function usedOverflowAllowanceOf(
    IJBSingleTokenPaymentTerminal _terminal,
    uint256 _projectId,
    uint256 _fundingCycleConfiguration
  ) external view returns (uint256);

  function currentOverflowOf(IJBSingleTokenPaymentTerminal _terminal, uint256 _projectId)
    external
    view
    returns (uint256);

  function currentTotalOverflowOf(
    uint256 _projectId,
    uint256 _decimals,
    uint256 _currency
  ) external view returns (uint256);

  function currentReclaimableOverflowOf(
    IJBSingleTokenPaymentTerminal _terminal,
    Param memory param,
    bool _useTotalOverflow
  ) external view returns (uint256);

  function currentReclaimableOverflowOf(
    Param memory param,
    uint256 _overflow
  ) external view returns (uint256);

  function recordPaymentFrom(
    address _payer,
    JBTokenAmount memory _amount,
    uint256 _projectId,
    uint256 _baseWeightCurrency,
    address _beneficiary,
    string calldata _memo,
    bytes calldata _metadata
  )
    external
    returns (
      JBFundingCycle memory fundingCycle,
      uint256 tokenCount,
      IJBPayDelegate delegate,
      string memory memo
    );

  function recordRedemptionFor(
    Param memory param,
    string calldata _memo,
    bytes calldata _metadata
  )
    external
    returns (
      JBFundingCycle memory fundingCycle,
      uint256 reclaimAmount,
      IJBRedemptionDelegate delegate,
      string memory memo
    );

  function recordDistributionFor(
    uint256 _projectId,
    uint256 _amount,
    uint256 _currency
  ) external returns (JBFundingCycle memory fundingCycle, uint256 distributedAmount);

  function recordUsedAllowanceOf(
    uint256 _projectId,
    uint256 _amount,
    uint256 _currency
  ) external returns (JBFundingCycle memory fundingCycle, uint256 withdrawnAmount);

  function recordAddedBalanceFor(uint256 _projectId, uint256 _amount) external;

  function recordMigration(uint256 _projectId) external returns (uint256 balance);
}
