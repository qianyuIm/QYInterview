//
//  ClassAndStructController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//  - Class和Struct
// https://swift.gg/2015/08/14/friday-qa-2015-07-17-when-to-use-swift-structs-and-classes/
import UIKit
fileprivate struct Struct {
    var name: String = ""
}
fileprivate class Class: NSObject {
    var name: String = ""
}
class ClassAndStructController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var struct1 = Struct(name: "结构体1")
        var struct2 = struct1
        struct1.name = "结构体1吗?"
        struct2.name = "结构体2吗?"
        logDebug(struct1)
        logDebug(struct2)
        
        var class1 = Class()
        var class2 = class1
        class1.name = "类1吗?"
        class2.name = "类2吗?"
        logDebug(class1.name)
        logDebug(class2.name)
    }
}
