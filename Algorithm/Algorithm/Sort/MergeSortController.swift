//
//  MergeSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/5/6.
//

import UIKit

class MergeSortController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug(def)
        let array = [7,10,9,3,20,4,8]
        touchesBeganBlock = { [weak self] in
            guard let self = self else { return  }
            let newArray = self.mergeSort(array)
            logDebug(newArray)
        }
    }
    
    /// 归并排序
    // 1.首先我们将需要排序的序列进行拆分，拆分成足够小的数组。
    // 也就是拆分的数组中只有一个元素。无序数组拆分的所有数组因为其中只含有一个元素，
    // 所以都是有序的。我们就可以对这些有序的小数组进行合并了
    
    // 2. 将拆分的多个有序数组进行两两合并，
    // 合并后的新数组仍然是有序的。我们再次对这些合并产生的数组进行两两合并，
    // 直到所有被拆分的数组有重新被合并成一个大数组位置。这个重新合并生成的数组就是有序的，
    // 也就是归并排序所产生的有序序列。
    func mergeSort(_ array: [Int]) -> [Int] {
        // 1. 第一步 拆分为单一元素的数组的数组
        var temp: [[Int]] = []
        for item in array {
            var sub: [Int] = []
            sub.append(item)
            temp.append(sub)
        }
        // 2. 对这个数组中的数组进行合并
        while temp.count != 1 {
            var index = 0
            while index < temp.count - 1 {
                // 将 index 和 index+1的的数组合并
                temp[index] = merge(temp[index], second: temp[index+1])
                temp.remove(at: index+1)
                index += 1
            }
        }
        return temp.first!
    }
    // 合并两个有序数组
    func merge(_ first: [Int], second: [Int]) -> [Int] {
        var result:[Int] = []
        var firstIndex = 0
        var secondIndex = 0
        while firstIndex < first.count && secondIndex < second.count {
            if first[firstIndex] < second[secondIndex] {
                result.append(first[firstIndex])
                firstIndex += 1
            } else {
                result.append(second[secondIndex])
                secondIndex += 1
            }
        }
        // 当first和seconde长短不一时候判定
        while firstIndex < first.count {
            result.append(first[firstIndex])
            firstIndex += 1
        }
        while secondIndex < second.count {
            result.append(second[secondIndex])
            secondIndex += 1
        }
        return result
    }
}
