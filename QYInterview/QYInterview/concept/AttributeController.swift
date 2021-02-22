//
//  AttributeController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/18.
//  - 计算属性和存储属性
/// 属性包装器  讲首字母大写
@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.capitalized
        }
    }
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

fileprivate class AttributePersion {
    var age: Int?
    @Capitalized var name: String = ""
    var price: Double = 0.0 {
        willSet {
            logDebug("willSet = \(newValue)")
            logDebug("不能再willSet中赋值,因为会在didSet中被 newValue覆盖")
            if self.price < 30 {
                self.price = 20
            }
        }
        didSet {
            logDebug("didSet = \(price)")
            if self.price < 30 {
                self.price = 30
            }
            logDebug("在观察器内部设置属性不会触发额外的回调，上面的代码不会产生无限循环。")
        }
    }
}

import UIKit

class AttributeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let persion = AttributePersion()
        persion.price = 12
        persion.age = 13
        logDebug("persion.price = \(persion.price)")
        persion.name = "hello"
        logDebug(persion.name)
        if var age = persion.age {
            age = 30
        }
        logDebug("persion.age = \(persion.age)")
//        let aaa: String? = "123"
//        if var bbb = aaa {
//            bbb = "456"
//        }
//        logDebug("aaa = \(aaa)")
        let dict = ["aaa": "123"]
        let aaa = dict["aaaa"]
        if let aaa = aaa {
            logDebug("aaa = \(aaa)")
        }
    }
}
