// spdx-licence-identifier: MIT
// pragma solidity ^0.8.9;
pragma solidity >=0.4.0 <0.9.0;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EduCoin is ERC20, ERC20Burnable, Pausable, Ownable {
    constructor () ERC20("EduCoin", "EDC") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}

// interface DERC20 {
// // required function for ERC20 standard

//     function totalSupply() external view returns (uint256);
//     function balanceOf(address account) external view returns (uint256);
//     function transfer(address recipient, uint amount) external returns (bool);
//     function allowance(address owner, address spender) external view returns (uint);
//     function approve(address spender, uint amount) external returns (bool);
//     function transferFrom(address sender,address recipient,uint amount) external returns (bool);

// // important event for ERC20 standard
//     event Transfer(address indexed _from, address indexed _to, uint256 _value);
//     event approval(address indexed _owner, address indexed _spender, uint256 _value);    
// }
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a - b;
        assert(c <= a);
        return c;
    }
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }
}
contract MyErcToken  {
    using SafeMath for uint256;
// main state variables
    uint constant decimals = 18;
    // uint256 public totalSupply = 10000 * 10 ** 18;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply = 1000000000 * 10 ** 18;
    string private _name;
    string private _symbol;
    uint256 public Counter = 0;

   address public admin;
   event Transfer(address indexed from, address indexed to,uint256 Id, uint256 value);
   event _Approve(address indexed owner, address spender, uint256 amount);

   constructor()  {
       mint(msg.sender, 10000 * 10 ** 18);
    
   }
   modifier onlyOwner() {
       require(msg.sender == admin);
      _;
   }
   function mint(address _to, uint256 _amount) public onlyOwner {
       require (msg.sender == admin, 'only for admin');
       mint(_to, _amount);
   }
   function burn(address account, uint amount) external onlyOwner {

   //    require (msg.sender == admin, 'only for admin');
   //   balanceOf[msg.sender] -= amount;
   //   totalSupply -= amount;
    //  emit Transfer(msg.sender, address(0), amount);
       require(amount != 0);
       require(amount <= balances[account]);
       _totalSupply = _totalSupply.sub(amount);
       balances[account] = balances[account].sub(amount);
       transfer(account, address(0), amount);
   }   
   function totalSupply() public virtual view returns (uint) {
       require(_totalSupply >= 0);
       return _totalSupply;
   }
   function balanceOf(address _owner) public virtual view returns (uint) {
       return balances[_owner];
   }
   function transfer(address _from, address _to, uint _value) public virtual returns (bool) {
       require (balances[msg.sender] >= _value, 'insufficient balance');
       require (_from != _to, 'cannot transfer to self');
       balances[msg.sender] -= _value;
       balances[_to] += _value;
       uint256 Id = Counter+1;
       emit Transfer(msg.sender, _to, Id, _value);
       return true;
   }

   function allowance(address owner, address spender, uint256 amount) public returns (bool) {
       require (balances[msg.sender] >= amount, 'insufficient balance');
       
       _allowances[owner][spender] >= amount;
       emit _Approve(msg.sender, spender, amount);
       return true;
   }   
   function approve(address owner, address spender) internal virtual returns (bool success) {
       require(msg.sender == owner);
       _allowances[owner][spender] = balances[owner];
       return true;
   }
}