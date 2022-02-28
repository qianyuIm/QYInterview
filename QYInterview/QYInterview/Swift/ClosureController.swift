//
//  ClosureController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

import UIKit


class ClosureController: BaseViewController {
    var complitionHandler: ((Int)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
//            self.test()
//            self.test2()
//            self.test3()
            self.test4()
        }
        let string = """
    非逃逸闭包：一个接受闭包作为参数的函数，闭包是在这个函数结束前内被调用，即可以理解为闭包是在函数作用域结束前被调用;
        1、不会产生循环引用，因为闭包的作用域在函数作用域内，在函数执行完成后，就会释放闭包捕获的所有对象
        2、针对非逃逸闭包，编译器会做优化：省略内存管理调用
        3、非逃逸闭包捕获的上下文保存在栈上，而不是堆上（官方文档说明）。

    逃逸闭包：一个接受闭包作为参数的函数，逃逸闭包可能会在函数返回之后才被调用，即闭包逃离了函数的作用域;
        1、可能会产生循环引用，因为逃逸闭包中需要显式的引用self（猜测其原因是为了提醒开发者，这里可能会出现循环引用了），而self可能是持有闭包变量的（与OC中block的的循环引用类似）
        2、一般用于异步函数的返回，例如网络请求
    使用建议：如果没有特别需要，开发中使用非逃逸闭包是有利于内存优化的，所以苹果把闭包区分为两种，特殊情况时再使用逃逸闭包
    自动闭包:自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行,但过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
    """
        logDebug(string)
    }
    
    
}

extension ClosureController {
    func test4() {
        someFunctionThatTakesAClosure {
            logDebug("尾随闭包")
        }
        
    }
    func test11(){
        var age = 0
        var height = 0.0
        //将变量age用来初始化捕获列表中的常量age，即将0给了闭包中的age（值拷贝）
        let clourse = { [age] in
//            var age = age
//            age = 100
            print(age)
            print(height)
        }
        age = 10
        height = 1.85
        clourse()
    }

    func someFunctionThatTakesAClosure(closure: () -> Void) {
        logDebug("函数")
        closure()
    }
}
extension ClosureController {
    // 1. 闭包作为属性存储，在后面调用
    // 2. 延时调用
    func test3() {
        self.makeIncrementer(amount: 10) {
            logDebug("闭包 -> \($0)")
        }
        self.complitionHandler?(10)
    }
    func makeIncrementer(amount: Int, handler: @escaping (Int)->Void){
        logDebug("函数开始")
        var runningTotal = 0
        runningTotal += amount
        //赋值给属性
        complitionHandler = handler
        logDebug("函数结束")
    }
}

//<!--打印结果-->
//20
fileprivate class SimpleClass {
    var value: Int = 0
}
extension ClosureController {
    func test2() {
        // 引用类型
        let a = SimpleClass()
        let b = SimpleClass()
        // 值类型
        var c = 10
        var d = 20
        // [a] 「隐式」地声明了一个新的量，一个名为 a 的常量，它的作用域是闭包内。它的显式写法是：
        let closure0 = { [a] in
            logDebug("\(a.value) -> \(b.value)")
        }
        // 显示写法
        let closure1 = { [aCopy = a] in
            logDebug("\(aCopy.value) -> \(a.value) -> \(b.value)")
        }
        let closure2 = { [c, d] in
            logDebug("\(c) -> \(d)")
        }
        let closure3 = { [cCopy = c] in
            logDebug("\(cCopy) -> \(c) -> \(d)")
        }
        a.value = 10
        b.value = 20
        c = 30
        d = 40
        closure0()
        closure1()
        closure2()
        closure3()
    }
    
}
extension ClosureController {
    func test() {
        // 闭包和函数是一个引用类型 设置makeInc常量，
        let makeInc = self.makeIncrementer()
        logDebug(makeInc())
        logDebug(makeInc())
        logDebug(makeInc())
        let makeInc1 = makeInc
        logDebug(makeInc1())
    }
    func makeIncrementer() -> () -> Int{
        // 会在堆上开辟空间，存放了捕获的值
        var runningTotal = 10
        //内嵌函数，也是一个闭包
        func incrementer() -> Int{
            runningTotal += 1
            return runningTotal
        }
        return incrementer
    }
}
