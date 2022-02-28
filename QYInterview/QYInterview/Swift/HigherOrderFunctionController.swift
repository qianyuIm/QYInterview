//
//  HigherOrderFunctionController.swift
//  QYInterview
//
//  Created by cyd on 2022/2/28.
//

import UIKit

class HigherOrderFunctionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logDebug("compactMap数组 主要用于过滤非空的搭配 flatMap来进行降维度")
        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
//            self.testOneDimensionalArray()
//            self.testTwoDimensionalArray()
            self.testTwoOptionalDimensionalArray()
        }
    }
    // 测试一维数组
    func testOneDimensionalArray() {
        let array = [1,2,3,4,5,6,7,8]
        logDebug("原始数组 -> \(array)")
        let mapArray = array.map { item in
            return item * item
        }
        logDebug("map过滤数组 -> \(mapArray)")
        let filterArray = array.filter { item in
            return item % 2 == 0
        }
        logDebug("filter过滤数组 -> \(filterArray)")
        let reduceArray = array.reduce(10) { partialResult, item in
            return partialResult + item
        }
        logDebug("reduce函数可以将一个集合中的所有元素组合起来，生成一个新的值并返回该值");
        logDebug("reduce数组 -> \(reduceArray)")
        let flatMapArray = array.flatMap { item in
            return item
        }
        logDebug("flatMap数组 -> \(flatMapArray)")
        let compactMapArray = array.compactMap { item in
            return item
        }
        logDebug("compactMap数组 -> \(compactMapArray)")

    }
    // 测试二维数组
    // 对于二维数组来说flatMap 会降维，compactMap不会
    func testTwoDimensionalArray() {
        let array = [[1,2,3],[4,5]]
        let flatMapArray = array.flatMap { item in
            return item
        }
        logDebug("flatMap数组 -> \(flatMapArray)")
        let compactMapArray = array.compactMap { item in
            return item
        }
        logDebug("compactMap数组 -> \(compactMapArray)")
    }
    // 二维可选数组
    func testTwoOptionalDimensionalArray() {
        let array = [[1,2,3],[nil,5]]
        let flatMapArray = array.flatMap { item in
            return item.compactMap{ $0 }
        }
        logDebug("flatMap数组 -> \(flatMapArray)")
        let compactMapArray = array.compactMap { item in
            return item.map { $0 }
        }
        logDebug("compactMap数组 主要用于过滤非空的搭配 flatMap来进行降维度-> \(compactMapArray)")
    }
}
