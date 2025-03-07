// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Minimal implementation of ERC721 functionality
contract SimpleERC721 {
    string public name;
    string public symbol;
    
    // Mapping from token ID to owner address
    mapping(uint256 => address) public ownerOf;
    
    // Event to signal transfers (including minting)
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }
    
    // Internal mint function that assigns ownership and emits event
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "Cannot mint to zero address");
        require(ownerOf[tokenId] == address(0), "Token already minted");
        ownerOf[tokenId] = to;
        emit Transfer(address(0), to, tokenId);
    }
}

// FarmerLoan contract that extends our simple ERC721
contract FarmerLoan is SimpleERC721 {
    // Structure to hold loan details
    struct Loan {
        string farmerId; // Unique identifier for the farmer
        uint256 amount;  // The loan amount
    }
    
    // Mapping from token ID to its loan details
    mapping(uint256 => Loan) public loanDetails;
    
    // Event emitted when a new loan token is created
    event LoanCreated(
        uint256 indexed tokenId,
        address indexed to,
        string farmerId,
        uint256 amount
    );
    
    // Constructor forwards the name and symbol to the base contract
    constructor(string memory _name, string memory _symbol)
        SimpleERC721(_name, _symbol)
    {}
    
    /**
     * @dev Mint a new token representing a farmer loan.
     * @param to The recipient address for the token.
     * @param tokenId The unique identifier for the token.
     * @param farmerId The identifier for the farmer.
     * @param amount The loan amount.
     */
    function mintLoan(
        address to,
        uint256 tokenId,
        string memory farmerId,
        uint256 amount
    ) public {
        // Mint the token to the designated address.
        _mint(to, tokenId);
        // Save the loan details on-chain.
        loanDetails[tokenId] = Loan(farmerId, amount);
        // Emit an event to signal that a new loan token was created.
        emit LoanCreated(tokenId, to, farmerId, amount);
    }
}
