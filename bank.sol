// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    // Mapping to store account balances
    mapping (address => uint256) public balances;

    // Event to notify when a deposit is made
    event DepositMade(address indexed account, uint256 amount);

    // Function to deposit funds
    function deposit(uint256 amount) public {
        // Require a positive deposit amount
        require(amount > 0);

        // Add deposit to the account balance
        balances[msg.sender] += amount;

        // Emit the DepositMade event
        emit DepositMade(msg.sender, amount);
    }

    // Function to withdraw funds
    function withdraw(uint256 amount) public {
        // Require the withdrawal amount to be less than the account balance
        require(amount <= balances[msg.sender]);

        // Subtract withdrawal from the account balance
        balances[msg.sender] -= amount;
    }

    // Function to check account balance
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Function to transfer funds (can only be called by the contract owner)
    function transfer(address recipient, uint256 amount) public onlyOwner {
        // Require a positive transfer amount
        require(amount > 0);
        // Require the transfer amount to be less than the sender's account balance
        require(amount <= balances[msg.sender]);

        // Subtract transfer amount from the sender's account balance
        balances[msg.sender] -= amount;
        
        // Add transfer amount to the recipient's account balance
        balances[recipient] += amount;
    }

        // Struct to store account information
        struct Account {
        address owner;
        uint256 balance;
    }

        // Array to store all accounts
        Account[] public accounts;

        // Contract owner's address
        address public owner;

        // Constructor to initialize the contract
        constructor() public {
         owner = msg.sender;
    }
} 
