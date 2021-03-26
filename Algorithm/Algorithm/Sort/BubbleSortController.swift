//
//  BubbleSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/25.
//

import UIKit

class BubbleSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        touchesBeganBlock = { [weak self] in
            self?.bubbleSort(self!.sortArray)
            self?.bubbleOptimizerSort(self!.sortArray)

        }
    }
    
    /// 时间复杂度----O(n^2)
    /// - Parameter array:
    func bubbleSort(_ array: [Int]) {
        guard !array.isEmpty else {
            logDebug("空数组")
            return
        }
        var perArray = array
        for i in 0 ..< array.count {
            for j in 0 ..< (array.count - 1 - i) {
                if perArray[j] > perArray[j+1] {
                    let temp = perArray[j+1]
                    perArray[j+1] = perArray[j]
                    perArray[j] = temp
                }
            }
        }
        logDebug("\(perArray)")
    }
    
    /// 优化后
    /// - Parameter array:
    func bubbleOptimizerSort(_ array: [Int]) {
        guard !array.isEmpty else {
            logDebug("空数组")
            return
        }
        
        var perArray = array
        for i in 0 ..< array.count {
            var flag = false
            for j in 0 ..< (array.count - 1 - i) {
                if perArray[j] > perArray[j+1] {
                    flag = true
                    let temp = perArray[j+1]
                    perArray[j+1] = perArray[j]
                    perArray[j] = temp
                }
            }
            if !flag {
                logDebug("跳出")
                break
            }
        }
        logDebug("\(perArray)")
    }
}
