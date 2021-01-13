//
//  NearlyFatherController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//  - 寻找最近公共父类

import UIKit
private class AView: BView { }
private class BView: DView { }
private class CView: DView { }
private class DView: UIView { }
class NearlyFatherController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug("继承关系 A -> B -> D")
        logDebug("继承关系 C -> D")
        let aClass: AnyClass = AView.classForCoder()
        let bClass: AnyClass = NSObject.classForCoder()
        let result: AnyClass? = comparison(aClass, bClass: bClass)
        logDebug("\(aClass) 与 \(bClass) 的最近公共父类为 \(String(describing: result))")
        
    }
    /// 获取 aClass 的父类
    func superClasses(_ aClass: AnyClass) -> [AnyClass] {
        var result: [AnyClass] = []
        var aClass: AnyClass? = aClass
        while aClass != nil {
            result.append(aClass!)
            aClass = aClass?.superclass()
        }
        return result
    }
    /// 对比 经过两次for循环比较 时间复杂度为O(N^2)
    func comparison(_ aClass: AnyClass,
                    bClass: AnyClass) -> AnyClass? {
        let aResult = superClasses(aClass)
        let bResult = superClasses(bClass)
        for aItem in aResult {
            for bItem in bResult {
                if aItem == bItem {
                    return aItem
                }
            }
        }
        return nil
    }
    /// 优化使用一层 for循环  用到了 NSSet
    /// 因为NSSet的内部实现是一个hash表，所以查询元素的时间的复杂度变成O(1)
    /// 我们一共有N个节点，所以总时间复杂度优化到了O(N)
    func optimizeComparison(_ aClass: AnyClass,
                            bClass: AnyClass) -> AnyClass? {
        let aResult = superClasses(aClass)
        let bResult = superClasses(bClass)
        let bSet = NSSet(array: bResult)
        for aItem in aResult {
            if bSet.contains(aItem) {
                return aItem
            }
        }
        return nil
    }
}
