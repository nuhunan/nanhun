// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.6 <0.9.0;

// erc20标准文档： https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// 定义 ERC20 标准接口（注意：接口里面定义的变量默认会生成get函数）
// abstract 表示抽象类
abstract contract ERC20Interface {
    // 合约币全名称
    string public name;
    // 合约币简称
    string public symbol;
    // 合约币精度
    uint8 public decimals;
    // 合约币初始数量
    uint256 public totalSupply;
    
    // virtual 表示抽象函数
    // 转账
    function transfer(address _to,uint256 _value) public virtual returns (bool success);
    // 转账（该函数一般用于抽取转移。就是用户授权了某个账户可以操控本账户，那么授权账户就可以调用该函数将本账户的合约币转走）
    function transferFrom(address _from,address _to,uint256 _value) public virtual returns (bool success);
    // 授权某个账户可以操控本账户金额（_spender=被授权地址，_value=可操控本账户金额（也就是被授权地址可转走本账户最大金额））
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    // 查询一个账户对某个账户的授权数量，就是可操控金额（_owner=被操控账户，_spender=授权账户）
    function allowance(address _owner, address _spender) public view virtual returns (uint256 remaining);
    // 转账事件（_from=转出地址,_to=收入地址,_value=转账数量）
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
