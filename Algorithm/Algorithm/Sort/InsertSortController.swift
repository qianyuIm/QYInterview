//
//  InsertSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/16.
//

import UIKit

class InsertSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug(def)
        let array = [2,10,9,3,20,4,8]
        touchesBeganBlock = { [weak self] in
            logDebug(self?.insertSort(array))
        }
    }
    /**
     实现思路：

     　　1. 从第一个元素开始，认为该元素已经是排好序的。
     　　2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。
     　　3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。
     　　4. 重复步骤3，直到已排好序的元素小于或等于新元素。
     　　5. 在当前位置插入新元素。
     　　6. 重复步骤2。
     　　复杂度：

     　　平均时间复杂度：O(n^2)

     　　平均空间复杂度：O(1)
     */
    func insertSort(_ array: [Int]) -> [Int] {
        if array.count < 1 {
            return array
        }
        var array = array
        // 从位置1 取值
        for i in 1..<array.count {
            // 反向遍历
            var j = i
            while j > 0 && array[j] < array[j - 1] {
                let temp = array[j]
                array[j] = array[j - 1]
                array[j - 1] = temp
                j -= 1
                
            }
        }
        return array
    }
   

}
