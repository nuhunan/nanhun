/**
 * 基础语法相关
 */

// 标识编译该文件所使用的编译器版本
pragma solidity ^0.8.7;

// 创建一个合约名字叫Test
contract Test {
   
    // 定义个无符号的int类型成员变量（注意：无符号就是正整数）
    // 注意：int 默认是256个字节，如果要指定长度的话就是 int8 就是占8个字节
    uint a;

    bool b = true;
    bool c = false;
    // 一个成员变量，它的值是1的10次方
    int d = 1e10;
    // 字符串变量
    string e = "asdasdsa";
    // 数组变量

    // 该合约的构造函数
    constructor() public {

    }

    // 一个纯函数（注意：被 pure 修饰的函数，在函数里面不读取和修改成员变量）
    function aaa() public pure {

    }
    // 回退回调函数
    // 注意：被 payable 修饰的函数,是当合约接收币的时候就会被回调
    // 当调用合约里面的某个函数时，如果该函数不在合约里面，那么默认就会调用被payable修饰的函数
    function () public payable {

    }

    // 一个函数，它的返回值是一个uint类型（注意：被view修饰的函数，在函数体里面是不能修改成员变量的）
    function aint_len() public view returns (uint) {
        // 创建一个数组变量a，它的长度是10。数据存储在memory（内存）里面
        uint[] memory a = new uint[](10);
        // 创建一个二进制数组变量b，它的长度是10。数据存储在memory（内存）里面
        bytes memory b = new bytes(10);
        uint balance = 10;
        // 修改map变量balances的值（注意：msg.sender 是地址）
        balances[msg.sender] = balance;
        a.length;
        b.length;
        // 调用函数all_method传入参数a=10
        all_method(a:10);
        // 调用函数testhex获取到三个返回值
        (b1,b2,b3) = testhex();
        return aint[0];
    }

    // external 表示外部函数，代码内部无法调用，它是给web3调用的
    function test_e() external {

    }

    // internal 表示内部函数，只能在当前合约或继承合约中调用
    // 注意：internal比public修饰消耗的gas少，故在合约内部调用建议使用internal修饰函数）
    function test_e() internal {

    }

    // private 代表是私有函数
    function test_while() private {
        uint i = 0;
        while(true) {
            i++;
            if(i % 2 == 0) {
                i += 2;
                continue;
            }
            if(i > 100) {
                break;
            }
        }
    }

    // 内置全局变量相关使用（注意：public比internal修饰消耗的gas多）
    function all_method(uint a) public {
        // 获取当前交易发送者的地址
        address sender = msg.sender;
        // 获取当前交易金额
        uint val = msg.value;
        // 获取到当前块的地址
        address coinbase = block.coinbase;
        // 获取到当前块的难度
        uint difficulty = block.difficulty;
        // 获取到当前块的块号
        uint bun = block.number;
        // 获取到当前区块的时间戳
        uint time = block.timestamp;
        // 当前时间戳
        uint no = now
        // 当前区块交易价格
        uint gas = tx.gas;
        // 判断交易金额是否可以被2整除，否则整个交易失败（代码不会再往下执行）
        // 注意：该错误发送时，终止交易，不会扣gas费，所以该判断一般用于参数校验
        require(msg.value % 2 == 0);


        uint balbal = 1;

        // 判断balbal是否等于交易地址余额除以2，否则整个交易失败（代码不会再往下执行）
        // 注意：该错误发送时，终止交易，会扣gas费，所以该判断一般用于验证程序内部的逻辑错误
        assert（balbal == msg.value / 2);
    }
     
    
    // 一个函数，参数是无符号的int类型，可见性是public
    function setA(uint a) public {
        a = a;
        // 触发 set_a 事件（其实就是调用 set_a 函数）
        emit set_a(a);
    }
    // 一个函数，它的返回值是一个bool类型
    function getB() public returns (bool) {
        return b;
    }
    // 合约初始化函数
    function deposit() public payable {

    }

    // 一个函数，它的返回值是一个address(地址)类型
    // 注意：该函数是返回当前合约的余额
    function getBalance() public returns(uint) {
        //return this.balance;
        return 1;
    }
   
    // 一个函数，它的返回值是一个int类型
    function getNum() public returns (int) {
        int8 aa = 10;
        int16 bb = 12;
        return aa + bb;
    }
    // 一个函数多个返回值（注意：bytes是16进制类型。bytes2表示占2个字节大小的16进制）
    function testhex() public returns(bytes2,bytes1,bytes1) {
        bytes2 a = hex"abcd";
        return (a,a[0],a[1]);
    }
    // 一个函数，指定了过滤器 owner（就是调用该函数时会先执行 owner里面的代码）
    function ming() public owner {

    }

    // 定义一个事件监听器函数（其实就是当该事件被触发时，只要web3实现了这个函数，就是调用web3的这个函数）
    event set_a(uint a);

    // 定义一个数据结构（其实就是类）
    struct Pos {

        int lat;

        int lng;
    }
    // 定义个成员变量 ownerAddr 它的类型是 address（地址型）
    address public ownerAddr;

    // 定义一个函数修改器（函数过滤器）名字叫 owner ，就是在某个函数调用之前执行函数过滤器码(相当于过滤器代码)
    modifier owner() {
        // 判断 msg.sender会否等于 ownerAddr
        require(msg.sender == ownerAddr);
        // 调用实际函数
        _;
    }
}


// 合约Test2继承至Test（注意：继承通过is关键字）
contract Test2 is Test {

}
