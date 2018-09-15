pragma solidity ^0.4.0;

//import './IERC.sol';

contract RewardsCoin {
    
    uint public constant _totalSupply = 1000000;
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    
    string public constant name = "Token Name";
    string public constant symbol = "RRP";
    uint8 public constant decimals = 3;  // 18 is the most common number of decimal places
    
    modifier isValidTransaction(address tokenOwner, uint token) {
        require(balances[tokenOwner] >= token);
        _;
    }
    
    constructor () public {
        balances[msg.sender] = _totalSupply;
    }

    //Balances for each account
    mapping (address => uint256) balances;
    
    //Owner of the account transfers the amount
    mapping(address => mapping (address => uint256)) allowed;
    
    //totalSupply of tokens Function 1
    //function totalSupply() public constant returns (uint);
    function totalSupply() public pure returns (uint) {
        return _totalSupply;
    }
    
    //Get the balance of the owner 'tokenOwner' Function 2
    //function balanceOf(address tokenOwner) public constant returns (uint balance);
    function balanceof(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }
    
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }
    
    //transfer the balance of owner's token to another account Function 4
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    
    //function 5
    function approve (address spender, uint tokens) public returns (bool success) {
            allowed[msg.sender][spender] = tokens;
            emit Approval(msg.sender, spender, tokens);
            return true;
    }
    
    // Send `tokens` amount of tokens from address `from` to address `to`
    // with authorizations from the 'from' address owner to the sender
    function transferFrom (address from, address to, uint tokens) isValidTransaction(from, tokens) public returns (bool success) {
        balances[from] -= tokens;
        allowed[from][msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
    
    function retrieveTokens(address _token) view public returns (uint tokens){
       return balances[_token];
  }
  
    // Allow `spender` to withdraw from your account, multiple times, up to the `tokens` amount.
    // If this function is called again it overwrites the current allowance with _value.

}
