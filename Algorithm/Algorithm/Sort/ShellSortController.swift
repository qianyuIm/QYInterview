//
//  ShellSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/19.
//

import UIKit

class ShellSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug(def)
        var array = [7,10,9,3,20,4,8]
        touchesBeganBlock = { [weak self] in
            self?.shellSort(&array)
            logDebug(array)
        }
    }
    /**
     希尔排序，也称递减增量排序算法，是插入排序的一种更高效的改进版本。希尔排序是非稳定排序算法。
     */
    func shellSort(_ array: inout [Int]) {
        var j: Int = 0
        // 获取增量
        var gap = array.count / 2
        while gap > 0 {
            for i in 0..<gap {
                j = i + gap
                while j < array.count {
                    if array[j] < array[j - gap] {
                        let temp = array[j]
                        var k = j - gap
                        // 插入排序
                        while k >= 0 && array[k] > temp {
                            array[k + gap] = array[k]
                            k -= gap
                        }
                        array[k + gap] = temp
                    }
                    j += gap
                }
            }
            gap /= 2
        }
    }
    

}
