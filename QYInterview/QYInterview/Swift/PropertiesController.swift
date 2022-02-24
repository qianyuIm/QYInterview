//
//  PropertiesController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/24.
//

import UIKit

/// 属性包装器  将首字母大写
@propertyWrapper struct CapitalizedWrapped {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.capitalized
        }
    }
    init(_ wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}
/// @dynamicMemberLookup 动态返回一个函数 和 @dynamicCallable 来调用
@dynamicCallable
@dynamicMemberLookup
fileprivate class Persion {
    // 存储属性
    var storagePropertie: String = ""
    @CapitalizedWrapped("")
    var wrapperPropertie: String
//     @dynamicMemberLookup
    subscript(dynamicMember member: String) -> String {
        let properties = ["nickname": "qianyu"];
        // 返回固定值 任何属性都可以获取到这个值比如 nick / nick1
//        return "123"
        return properties[member, default: "undefined"]
    }
    // @dynamicCallable
    func dynamicallyCall(withArguments: [String]) {
        for item in withArguments {
            print(item)
        }
    }
}
private var associatedStoragePropertieKey: UInt8 = 0

extension Persion {

    // 在 extension 中不能添加 存储属性如果需要添加的话 需要使用关联对象
    var associatedStoragePropertie: String? {
        set {
            objc_setAssociatedObject(self, &associatedStoragePropertieKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let rs = objc_getAssociatedObject(self, &associatedStoragePropertieKey) as? String {
                return rs
            }
            return nil
        }
    }
    
    // 计算属性 不直接存储值，而是通过提供一个getter，setter来间接获取和设置其他属性和变量的值
    var calculatePropertie: String {
        set {
            storagePropertie = newValue
        }
        get {
            return storagePropertie
        }
        
    }
}

class PropertiesController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.touchesBeganBlock = { [weak self] in
            self?.test()
        }
    }
    func test() {
        let persion = Persion()
        persion.calculatePropertie = "我是计算属性赋值存储属性"
        persion.associatedStoragePropertie = "我是关联存储属性"
        persion.wrapperPropertie = "i am"
        logDebug("\(persion.storagePropertie)")
        logDebug("\(persion.calculatePropertie)")
        logDebug("\(persion.associatedStoragePropertie ?? "")")
        logDebug("\(persion.wrapperPropertie)")
        logDebug("\(persion.nickname)")

        persion.dynamicallyCall(withArguments: ["123","456"])
        
    }
}
