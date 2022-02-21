//
//  SwiftKVOViewController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

import UIKit
class UnSwiftKVO: NSObject {
    var someValue: String = "" {
        didSet {
            logDebug("\(someValue)")
        }
    }
}
class SwiftKVO: NSObject {
    @objc dynamic var someValue: String = ""
}
class SwiftKVOViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            self?.test()
            self?.test1()
        }
        logDebug("Swift 要实现KVO，必须继承自NSObject且还要将要观测的对象标记为@objc dynamic")
    }
    
    func test() {
        let unKVO = UnSwiftKVO()
        unKVO.addObserver(self, forKeyPath: "someValue", options: [.old, .new], context: nil)
        unKVO.someValue = "unKVO"
    }
    func test1() {
        let kvo = SwiftKVO()
        kvo.addObserver(self, forKeyPath: "someValue", options: [.old, .new], context: nil)
        kvo.someValue = "KVO"
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        logDebug("\(change)")
    }
}
