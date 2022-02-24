//
//  TypeController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/24.
//

import UIKit
fileprivate class Persion {
    
}
fileprivate struct QYSize {
    var width: CGFloat
    var height: CGFloat
}
class TypeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.touchesBeganBlock = { [weak self] in
            self?.testAnyObject()
        }
        let string = """
                Any: 可以代表任意类型(枚举，结构体，类也包括函数类型);
                AnyObject: 可以标识任意类的类型;
                https://www.jianshu.com/p/e57ff751c825
                X.self: 是一个元类型（metadata）的指针，存放着类型相关的信息;
                x.self属于X.type类型;
                X.self 也是有自己的类型的，就是X.Type，就是元类型的类型;
                Self代表当前类型,一般作为函数的返回值使用，限定返回值跟调用者必须类型一致;
                https://blog.csdn.net/longshihua/article/details/74353273
                """
        logDebug(string)
    }
    func testAnyObject() {
        let persion = Persion()
        let size = QYSize(width: 10, height: 10)
        logDebug("\(persion) - \(size)")
        
    }
}
