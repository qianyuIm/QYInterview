# 设计模式

## MVC
在iOS开发中MVC是构建iOS App的标准模式，在MVC下，所有的对象都被归类为一个Model,一个View，一个Controller。Model持有数据，View显示与用户交互的界面,而ViewController负责调解Model和View之间的交互。Controller可以直接与Model和View进行通信，而View不能和Controller直接通信。View与Controller通信需要利用代理协议的方式，当有数据更新时，Model也要与Controller进行通信，这个时候就要用Notification和KVO，这个方式就像一个广播一样，Model发信号，Controller设置监听接受信号，当有数据更新时就发信号给Controller，Model和View不能直接进行通信。是随着业务的增多，MVC不可避免的出现了几个问题：

*  1. 厚重的ViewController
*  2. 遗失的网络逻辑位置
*  3. 较差的可测试性

## MVVM
随着MVC的问题的严重，MVVM衍生出来了，MVVM主要是为了分离View和Model,将Controller中的展示逻辑抽离出来放入到`ViewModel`中，在MVVM中，view和viewController都不能直接引用model，而是引用ViewModel,viewModel是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他代码的地方。在MVVM中只能View引用ViewModel,ViewModel引用Model不能反过来。MVVM配合绑定机制会更好，如RAC，或者使用FBKVOController(KVO)配合使用

1. 正向绑定： `Model` ->  `View` 在`ViewModel`定义`block`，回调触发`View`的更新，请求数据通过block得到回调刷新UI
2. 反向绑定:  `view` -> `model` 在`ViewModel`中使用`KVO`或者`RAC`绑定，cell点击修改model 引起页面变化

优点： 

缺点: 

*  数据绑定使得bug很难被调试。你看见页面异常了，有可能是View的代码有Bug,也可能是Model的代码有问题
*  对于过大的项目，数据绑定需要花费更多的内存。