// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 简单代币合约示例
// 定义合约 Hew
contract Hew {
    
    // 定义一个map变量，名字叫balances。key的类型是address，value的类型是uint256
    
    // 合约构造器（参数是合约初始币数量）
    constructor(uint256 initialSupply) public {
        // msg.sender 是合约部署发起者的地址（也就是将合约初始币放到合约部署发起者的地址上）
        balanceOf[msg.sender] = initialSupply;
    }
    
    // 转账
    function transfer(address _to,uint256 _value)  public {
        // 判断发起者地址的币是否大于等于转账数量（注意：require 错误发生时，终止交易，不会扣gas费，所以该判断一般用于参数校验）
        require(balanceOf[msg.sender] >= _value);
        // 判断接收者地址上的币加上转账数量是否大于等于当前接收者地址上的币
        // 注意：该判断
        // 扣除发起者地址上的币
        balanceOf[msg.sender] -= _value;
        // 增加接收者地址上的币
        balanceOf[_to] += _value;
    }
    
}
