//
//  BinarySearchController.swift
//  QYInterview
//
//  Created by cyd on 2021/1/14.
//  - 二分查找法
// 优点:1.速度快 2.比较次数少 3.性能好
// 缺点: 1.必须是一个有序的数组（升序或者降序）2.适用范围：适用不经常变动的数组
import UIKit

class BinarySearchController: BaseViewController {

    let item = [1,3,5,7,9,11,13,16,17]
    let undefinedIndex: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let target: Int = 11
        let index = binarySearch(item, target: target)
        logDebug("\(target) 在数组中的下标为\(index)")
    }
    func binarySearch(_ item: [Int], target: Int) -> Int {
        if item.count < 1 {
            // 数组无元素返回-1
            return undefinedIndex
        }
        // 定义三个变量 第一个值下标、中间值下标、最后一个值下标
        var startIndex = 0
        var endIndex = item.count - 1
        var midIndex = 0
        // 进行循环  数组中第一个对象和最后一个对象之前还有其他对象则进行循环
        while startIndex < endIndex - 1 {
            midIndex = startIndex + (endIndex - startIndex) / 2
            // 如果中间值大于目标值
            if item[midIndex] > target {
                // 中间值做为最后一个值，在前半段再进行相同的搜索
                endIndex = midIndex
            } else {
                startIndex = midIndex
            }
        }
        // 如果第一个值和目标值相等则获取第一个值的下标
        if item[startIndex] == target {
            return startIndex
        }
        // 如果最后一个值和目标值想等则获取最后一个下标
        if item[endIndex] == target {
            return endIndex
        }
        return undefinedIndex
    }
}
