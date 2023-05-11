// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.6 <0.9.0;
// 引入当前目录的 erc20-interface.sol 文件
import "./erc20-interface.sol";

// erc20标准代币合约示例（erc20标准文档： https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md）
// 定义合约 Hew 实现ERC20标准（注意：is 是继承的意思）
contract Hew is ERC20Interface {
    

    mapping(address => uint256) internal balanceMap;
    // 该变量记录合约里面的授权信息（key的类型是address，value的类型是 map）
    // internal 表示只能在当前合约或继承合约中调用
    mapping(address => mapping(address => uint256)) internal approved;
    
    // 合约构造器
    //  name = 合约币全名称，symbol = 合约币简称，initialSupply = 合约币初始数量，decimals = 合约币精度
    constructor() public {
        name = "Hew Token";
        symbol = "HEW";
        decimals = 0;
        totalSupply = 100000000;
        // msg.sender 是合约部署者的地址（也就是将合约初始币放到合约部署者的地址上）
        balanceMap[msg.sender] = totalSupply;
    }
    
    // override 表示重写
    // 获取合约里面某个地址的余额
    function balanceOf(address _owner) public override view returns (uint256 balance) {
        
        return balanceMap[_owner];
    }
    
    // 转账
    function transfer(address _to,uint256 _value) public override returns (bool success) {
        // 判断接收者地址不等于0
        require(_to != address(0));
        // 判断发起者地址的币是否大于等于转账数量（注意：require 错误发生时，终止交易，不会扣gas费，所以该判断一般用于参数校验）
        require(balanceMap[msg.sender] >= _value);
        // 判断接收者地址上的币加上转账数量是否大于等于当前接收者地址上的币
        // 注意：该判断的目的是保证uint256的值不会溢出，因为uint256的最大值是有限制的，如果到了最大值就不能加了
        require(balanceMap[_to] + _value >= balanceMap[_to]);
        // 扣除发起者地址上的币
        balanceMap[msg.sender] -= _value;
        // 增加接收者地址上的币
        balanceMap[_to] += _value;
        // 触发转账事件
        emit Transfer(msg.sender,_to,_value);
        success = true;
    }
    
    // 转账（该函数一般用于抽取转移。就是用户授权了某个账户可以操控本账户，那么授权账户就可以调用该函数将本账户的合约币转走）
    function transferFrom(address _from,address _to,uint256 _value) public override returns (bool success) {
        // 判断接收者地址不等于0
        require(_to != address(0));
        // 判断授权账户可操控的数量要大于等于转账数量
        require(approved[_from][msg.sender] >= _value);
        // 判断发送者地址的币是否大于等于转账数量（注意：require 错误发生时，终止交易，不会扣gas费，所以该判断一般用于参数校验）
        require(balanceMap[_from] >= _value);
        // 判断接收者地址上的币加上转账数量是否大于等于当前接收者地址上的币
        // 注意：该判断的目的是保证uint256的值不会溢出，因为uint256的最大值是有限制的，如果到了最大值就不能加了
        require(balanceMap[_to] + _value >= balanceMap[_to]);
        // 扣除发送者地址上的币
        balanceMap[_from] -= _value;
        // 增加接收者地址上的币
        balanceMap[_to] += _value;
        // 触发转账事件
        emit Transfer(_from,_to,_value);
        success = true;
    }
    
    // 授权某个账户可以操控本账户金额（_spender=被授权地址，_value=可操控本账户金额（也就是被授权地址可转走本账户最大金额））
    function approve(address _spender, uint256 _value) public override returns (bool success) {
        // 获取到本账户的授权集合Map，再给授权集合Map里面添加一条数据（key=被授权地址，value=可操控本账户金额）
        approved[msg.sender][_spender] = _value;
        // 触发授权事件
        emit Approval(msg.sender,_spender,_value);
        success = true;
    }
    
    // 查询一个账户对某个账户的授权数量，就是可操控金额（_owner=被操控账户，_spender=授权账户）
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
        // 获取到_owner账户的授权集合Map，再获取到对_spender账户的授权数量
        return approved[_owner][_spender];
    }
    
}
