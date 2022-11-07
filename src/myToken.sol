//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract myToken {

    address public owner;

    string public name;
    string public symbol;
    uint public decimals;
    uint public initialSupply;
    uint public supplyCap;
    uint public tokenBalance;

    mapping(address => uint) balances;
    
    modifier onlyOwner () {
        require(owner == msg.sender);
        _;
    }
    constructor (string memory _name, string memory _symbol, uint _decimals, uint _initialSupply, uint _supplyCap) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        initialSupply = _initialSupply;
        supplyCap = _supplyCap;
        owner = msg.sender;
        mint(owner, _initialSupply);
    }

    function tokenName(string memory _name) internal onlyOwner{
        name = _name;
    }

    function tokenSymbol (string memory _symbol) public onlyOwner{
        symbol = _symbol;
    }

    function Decimal (uint _decimals) public onlyOwner{
        decimals = _decimals;
    } 

    function mint(address _to, uint amount) public onlyOwner{
        require(amount > 0 && tokenBalance + amount <= supplyCap);
        tokenBalance += amount;
        balances[_to] += amount;
    }

    function transfer(address _to, uint amount) public onlyOwner{
        require(amount <= balances[owner]);
        balances[owner] -= amount;
        balances[_to] += amount;
    }

    function transferFrom (address _to, uint amount) public {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        balances[_to] += amount;
    }
   
    function burn (uint amount) public onlyOwner{
        require(amount <= balances[owner]);
        balances[owner] -= amount;
    }

    function balanceOf (address _address) public view returns (uint) {
        return balances[_address];
    }
}