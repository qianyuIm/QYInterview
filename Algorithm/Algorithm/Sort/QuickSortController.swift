//
//  QuickSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/16.
//

import UIKit

class QuickSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug(def)
        var array = [7,10,9,3,20,4,8]
        touchesBeganBlock = { [weak self] in
            self?.quickSort(&array,start: 0, end: array.count - 1)
            logDebug(array)
        }
    }
    // 快排
    /**
    原理:
     1. 从数列中挑出一个元素作为基数
     2.重新排列数列，把所有比基数小的放入基数前面，反之放到后面，一样大的可以任意一边，完成后基准处于分区的中间位置
     3. 通过递归调用把小于基准元素和大于基准元素的子序列进行排序
            
     */
    func quickSort(_ array: inout [Int], start: Int, end: Int) {
        if (start >= end) { return }
        let index = partition(&array, start: start, end: end)
        quickSort(&array, start: start, end: index - 1)
        quickSort(&array, start: index + 1, end: end)

    }
    // 分区
    func partition(_ array: inout [Int], start: Int, end: Int) -> Int {
        var left = start
        var right = end
        let pivot = array[start]
        while left != right {
            while array[right] >= pivot && left < right {
                right -= 1
            }
            while array[left] <= pivot && left < right {
                left += 1
            }
            if left < right {
                (array[left],array[right]) = (array[right],array[left])
            }
        }
        (array[left],array[start]) = (array[start],array[left])
        return left
    }

}
