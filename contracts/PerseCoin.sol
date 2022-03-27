// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Import necessary functionality from OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/**
 *  This contract creates PerseCoin, a token that follows the ERC-20 standard
 *  PerseCoin is mintable and burnable
 */

// Inherit from libraries, ERC20, Ownable, ERCBurnable
contract PerseCoin is ERC20, Ownable, ERC20Burnable {
    // Events below allow us to log:
    //  Initially minted tokens, burned tokens, and additionally minted tokens
    event TokensMinted(address indexed owner, uint256 amount, string message);
    event TokensBurned(address indexed owner, uint256 amount, string message);
    event NewTokensMinted(
        address indexed owner,
        uint256 amount,
        string message
    );

    // Initialize name, ticker symbol, and initial supply as:
    //  PerseCoin, PSC, and 5000 initial tokens
    constructor() ERC20("PerseCoin", "PSC") {
        // Mint initial 5000 PerseCoins and transfer it to our wallet
        _mint(msg.sender, 5000 * 10**decimals());

        // Save log of TokensMinted to blockchain
        emit TokensMinted(
            msg.sender,
            5000 * 10**decimals(),
            "Minted initial supply of PerseCoin."
        );
    }

    // Mint new PerseCoins into existing supply
    // Only the contract owner can perform this action
    function mintTokens(address to, uint256 amount) public onlyOwner {
        // Mint an amount of PerseCoins and transfer to a wallet
        _mint(to, amount);

        // Log NewTokensMinted event
        emit NewTokensMinted(msg.sender, amount, "Minted new PerseCoin.");
    }

    // Burn PerseCoins from existing supply
    // Only the contract owner can perform this action
    function burnTokens(uint256 amount) public onlyOwner {
        // Burn an amount of PerseCoins from our wallet
        _burn(msg.sender, amount);

        // Log TokensBurned event
        emit TokensBurned(msg.sender, amount, "Burned PerseCoin.");
    }
}
