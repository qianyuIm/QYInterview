//
//  MapController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/18.
//

import UIKit

class MapPersion: NSObject {
    @objc dynamic var name: String = ""
    var age: Int = 0 {
        willSet {
            logDebug(newValue)
        }
        didSet {
            logDebug(oldValue)
        }
    }
    var sex: Int {
        return 10
    }
    override init() {
        super.init()
        self.age = 100
    }
}
class MyObjectToObserve: NSObject {
    @objc dynamic var age = 24
    func updateAge() {
        age += 1
    }
}
class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?
    
    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()
        
        observation = observe(\.objectToObserve.age,
                              options: [.old, .new],
                              changeHandler: { (object, change) in
            print("去年年龄: \(change.oldValue!), 今年年龄: \(change.newValue!)")
        })
    }
}
class MapController: BaseViewController {

    let array = [1,3,4,nil,6]
    var persion: MapPersion?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        persion = MapPersion()
        persion?.addObserver(self, forKeyPath: "name", options: [.old,.new], context: nil)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        persion?.name = "你好吗"
        persion?.age = 10
        persion?.sex = 10
//        persion?.setValue("哈哈", forKey: "name")
//        let observerd = MyObjectToObserve()
////        let observer = MyObserver(object: observerd)
//        observerd.addObserver(self, forKeyPath: "age", options: [.new , .old], context: nil)
//        observerd.age = 10// 触发属性值的变化
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        logDebug(change)
    }
    
}
