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
            self?.quickSort(&array,low: 0,high: array.count - 1)
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
    func quickSort(_ array: inout [Int], low: Int, high: Int) {
        if low >= high {
            return
        }
        var i = low
        var j = high
        // 基准数字
        let midKey = array[i]
        while i != j {
            // 从右向左遍历
            while i < j && array[j] >= midKey {
                j -= 1
            }
            
            // 从左边开始比较，比key小的数位置不变
            while i < j && array[i] <= midKey{
                i += 1
            }
            if i < j {
                let temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
            
        }
        array[low] = array[i]//此时i和j相等，处于中间位置，替换midKey值
        array[i] = midKey
        // 左递归
        quickSort(&array, low: low, high: i - 1)
        quickSort(&array, low: i + 1, high: high)
    }
    

}
