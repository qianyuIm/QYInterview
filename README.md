### iOS面试题整理
#### Runloop
- [Runloop的概念与作用](docs/Runloop.md#Runloop的概念与作用)
- [Runloop与线程的关系](docs/Runloop.md#Runloop与线程的关系)
- [PerformSelector的实现原理](docs/Runloop.md#PerformSelector的实现原理)
- [Runloop有五种开启方法](docs/Runloop.md#Runloop有五种开启方法)
- [Runloop实际的应用](docs/Runloop.md#Runloop实际的应用)

#### UIKit相关
- NSNumber 和 NSValue

  <details open>
  <summary>NSNumber 和 NSValue 概念</summary>
  
  > NSNumber可以转换一系列的基础数字类型（char、int、float、long、bool等等），还提供了一个compare方法来将NSNumber对象进行数值排序。
  
  > NSNumber是NSValue的子类，NSValue除了能够包装NSNumber能够包装的基础数字类型外，还能够包装系统框架提供的CGRect/CGPoint/CGSize等数据结构，也可以是自己定义的struct。
  
  ```swift
typedef struct people{
    char *name;
    int age;
} People;  //定义了一个结构体
People me = {"lotheve",21};
//封装
NSValue *value = [[NSValue alloc]initWithBytes:&me objCType:@encode(People)];
People person;
//解封  
[value getValue:&person];  
  ```
  
 </details>



#### 消息传递的方式
- [1. KVC实现原理](docs/KVC.md)
- [2. KVO实现原理](docs/KVO.md)

### Block
* [Block的类型](docs/Block.md#Block的类型)

### 多线程
- [1. GCD简介](docs/Multithreaded.md#GCD简介)
- [2. NSOperation简介](docs/Multithreaded.md#NSOperation简介)


### 网络
- [1. HTTP](docs/HTTPS.md)
- [2. HTTPS和HTTP的区别](docs/HTTPS.md#HTTPS和HTTP的区别)

### 算法


### BugFix
- [webView导航条Bug](docs/BugFix.md)
