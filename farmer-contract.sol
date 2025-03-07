// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FireflyERC721WithData_FarmerLoan is ERC721URIStorage, Ownable {

    // Structure to hold loan details
    struct Loan {
        string farmerId; // Unique identifier for the farmer
        uint256 amount;  // The loan amount
    }

    // Mapping from token ID to loan details
    mapping(uint256 => Loan) public loanDetails;

    // Event emitted when a new loan token is minted
    event LoanCreated(
        uint256 indexed tokenId,
        address indexed to,
        string farmerId,
        uint256 amount
    );

    // Constructor sets the token name, symbol, and initial owner
    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
        Ownable(msg.sender)
    {}

    /**
     * @dev Mint a new token representing a farmer loan.
     * @param to The recipient address for the token.
     * @param tokenId The unique identifier for the token.
     * @param farmerId The identifier for the farmer.
     * @param amount The loan amount.
     * @param tokenURI The URI for off-chain metadata (optional).
     */
    function mintLoan(
        address to,
        uint256 tokenId,
        string memory farmerId,
        uint256 amount,
        string memory tokenURI
    ) public onlyOwner {
        // Mint the token to the designated address
        _mint(to, tokenId);
        // Optionally set a token URI for additional metadata
        _setTokenURI(tokenId, tokenURI);
        // Store the loan details on-chain
        loanDetails[tokenId] = Loan(farmerId, amount);
        // Emit an event to signal that a new loan token was created
        emit LoanCreated(tokenId, to, farmerId, amount);
    }
}
