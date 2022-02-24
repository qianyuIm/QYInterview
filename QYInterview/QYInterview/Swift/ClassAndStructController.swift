//
//  ClassAndStructController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//  - Class和Struct
// https://swift.gg/2015/08/14/friday-qa-2015-07-17-when-to-use-swift-structs-and-classes/
import UIKit

fileprivate struct Struct {
    var x: Int = 0
    var y: Int = 0
//    mutating func addX(add: Int) {
//        self.x = self.x + add
//    }
}



fileprivate class Class: NSObject {
    var name: String = ""
    var weight: Int = 0
}
fileprivate class Class1: Class {
    
}


class ClassAndStructController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let class1 = Class()
        logDebug("\(change(class1: class1))")
    }
    fileprivate func change(class1: Class) -> Class {
        class1.name = "10"
        return class1
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testClass()
        testStruct()
    }
    
    /// Class是引用类型
    // 当值传递的时候，它是传递对已有instance的引用
    func testClass() {
        let class1 = Class()
        class1.name = "class1"
        class1.weight = 10
        
        let class2 = class1
        class2.name = "class2"
        
        logDebug("class1 name = \(class1.name),class1 weight = \(class1.weight)")
        // 代表两个变量或者常量引用的同一个instance(实例)
        if class1 === class2 {
            logDebug("相同")
        } else {
            logDebug("不相同")
        }
        
    }
    // Struct是值类型
    // 当值进行传递的时候，它会copy传递的值
    func testStruct() {
        var struct1 = Struct(x: 10, y: 10)
        let struct2 = struct1
        struct1.x = 30
        logDebug("struct1 x = \(struct1.x),struct1 y = \(struct1.y)")
        logDebug("struct2 x = \(struct2.x),struct2 y = \(struct2.y)")        
    }
    
}
