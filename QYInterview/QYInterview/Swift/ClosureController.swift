//
//  ClosureController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

import UIKit

var num1 = 1
var num2 = 2

class ClosureController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.touchesBeganBlock = { [weak self] in
            self?.test()
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

    

    // 打印结果 0   1.85
    var iStrong = {
        num1 += 1
        num2 += 1
    }
    var iCopy = { [num1, num2] in
        logDebug("copy -> \(num1) - \(num2)")
    }
    func test() {
        iStrong()
        logDebug("\(num1) - \(num2)")
        iCopy()
        logDebug("\(num1) - \(num2)")
    }

}
