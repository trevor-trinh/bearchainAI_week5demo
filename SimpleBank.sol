// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SimpleBank {
    mapping(address => uint) private balances;
    address public owner;
    
    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);
    
    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
    
    function checkBalance() public view returns (uint) {
        return balances[msg.sender];
    }
    
    function transfer(address to, uint amount) public payable {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(to != address(0), "Invalid recipient address");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
