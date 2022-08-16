// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import '@openzeppelin/contracts/utils/introspection/ERC165.sol';
import './IJBSingleTokenPaymentTerminal.sol';

/**
  @notice
  Generic terminal managing all inflows of funds into the protocol ecosystem for one token.

  @dev
  Adheres to -
  IJBSingleTokenPaymentTerminals: General interface for the methods in this contract that interact with the blockchain's state according to the protocol's rules.

  @dev
  Inherits from -
  ERC165: Introspection on interface adherance. 
*/
abstract contract JBSingleTokenPaymentTerminal is ERC165, IJBSingleTokenPaymentTerminal {
  //*********************************************************************//
  // ---------------- public immutable stored properties --------------- //
  //*********************************************************************//

  /**
    @notice
    The token that this terminal accepts.
  */
  address[] public token;

  /**
    @notice
    The number of decimals the token fixed point amounts are expected to have.
  */
  uint256 public immutable override decimals;

  /**
    @notice
    The currency to use when resolving price feeds for this terminal.
  */
  uint256 public immutable override currency;

  //*********************************************************************//
  // ------------------------- external views -------------------------- //
  //*********************************************************************//


  function acceptsToken(address[] calldata _token, uint256 _projectId) external view override returns (bool result) {
    _projectId; // Prevents unused var compiler and natspec complaints.
    uint256 arrayLength = token.length;
    for(uint256 i; i < arrayLength; ) {
      if(token[i] == _token[i])
        result = true;
      unchecked { ++i; }
    }
  }

  /** 
    @notice
    The decimals that should be used in fixed number accounting for the specified token.

    @param _token The token to check for the decimals of.

    @return The number of decimals for the token.
  */
  function decimalsForToken(address _token) external view override returns (uint256) {
    _token; // Prevents unused var compiler and natspec complaints.

    return decimals;
  }

  /** 
    @notice
    The currency that should be used for the specified token.

    @param _token The token to check for the currency of.

    @return The currency index.
  */
  function currencyForToken(address _token) external view override returns (uint256) {
    _token; // Prevents unused var compiler and natspec complaints.

    return currency;
  }

  //*********************************************************************//
  // -------------------------- public views --------------------------- //
  //*********************************************************************//

  /**
    @notice
    Indicates if this contract adheres to the specified interface.

    @dev 
    See {IERC165-supportsInterface}.

    @param _interfaceId The ID of the interface to check for adherance to.
  */
  function supportsInterface(bytes4 _interfaceId)
    public
    view
    virtual
    override(ERC165, IERC165)
    returns (bool)
  {
    return
      _interfaceId == type(IJBPaymentTerminal).interfaceId ||
      _interfaceId == type(IJBSingleTokenPaymentTerminal).interfaceId ||
      super.supportsInterface(_interfaceId);
  }

  //*********************************************************************//
  // -------------------------- constructor ---------------------------- //
  //*********************************************************************//

  /**
    @param _token The token that this terminal manages.
    @param _decimals The number of decimals the token fixed point amounts are expected to have.
    @param _currency The currency that this terminal's token adheres to for price feeds.
  */
  constructor(
    address[] memory _token,
    uint256 _decimals,
    uint256 _currency
  ) {
    token = _token;
    decimals = _decimals;
    currency = _currency;
  }
}
