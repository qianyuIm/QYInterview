//
//  SelectSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/15.
//

import UIKit

class SelectSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        touchesBeganBlock = { [weak self] in
            self?.selectSort1(self!.sortArray)
        }
    }
    // 选择排序
    /*
     原理: 第一次从待排序的数组中选择最小或者最大的元素，放入序列的起始位置.
        然后从剩余未排序的元素中寻找最小或最大的元素，放到已排序的末尾，以此类推，直到全部待排序的个数为0
     */
    // 平均时间复杂度：O(n^2)
    // 平均空间复杂度：O(1)
    // 不稳定
    func selectSort(_ array: [Int]) {
        if array.count < 1 {
            return
        }
        var sortArray = array
        for i in 0..<sortArray.count {
            // 假设当前为最小值
            var min = sortArray[i]
            for j in (i + 1)..<array.count {
                // 查找最小值
                if min > sortArray[j] {
                    let temp = sortArray[j]
                    sortArray[j] = min
                    min = temp
                }
            }
            // 交换
            sortArray[i] = min
        }
        logDebug("\(sortArray)")

    }
    
    func selectSort1(_ array: [Int]) {
        if array.count < 1 {
            return
        }
        var sortArray = array
        for index in 0..<sortArray.count {
            var min = sortArray[index]
            for j in (index + 1)..<sortArray.count {
                // 查找最小值
                if (min > sortArray[j]) {
                    let temp = sortArray[j]
                    sortArray[j] = min
                    min = temp
                }
            }
            // 交换最小
            sortArray[index] = min
        }
        logDebug("\(sortArray)")
    }

}
