//
//  DeferViewController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

import UIKit

class DeferViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            self?.testDefer()
            self?.testDeferClosure({
                logDebug("我是闭包")
            })
            self?.testEscapingDeferClosure({
                logDebug("我是逃逸闭包闭包")
            })
        }
        logDebug("defer 语句块中的代码, 会在当前作用域结束前调用,无论函数是否会抛出错误。每当一个作用域结束就进行该作用域defer执行。 如果有多个 defer, 那么后加入的先执行.")
    }
    

    func testDefer() {
        logDebug("1");
        defer {
            logDebug("结束了1");
        }
        logDebug("2");
        defer {
            logDebug("结束了2");
        }
        logDebug("3");
        do {
            logDebug("结束了3");
        }
    }
    // 闭包 1 -> -> closure -> 函数结束
    func testDeferClosure(_ closure: () -> Void) {
        logDebug("1")
        defer { logDebug("函数结束") }
        closure()
    }
    // 逃逸闭包 1 -> 函数结束 -> closure
    func testEscapingDeferClosure(_ closure: @escaping () -> Void) {
        logDebug("1")
        defer { logDebug("函数结束") }
        DispatchQueue.main.async {
            closure()
        }
    }
}
