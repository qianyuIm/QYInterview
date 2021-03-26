//
//  PartSortController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/26.
//  https://leetcode-cn.com/problems/sub-sort-lcci/solution/swift-003bu-fen-pai-xu-by-yuanxinliang/
// 给定一个整数数组，编写一个函数，找出索引m和n，只要将索引区间[m,n]的元素排好序，整个数组就是有序的。注意：n-m尽量最小，也就是说，找出符合条件的最短序列。函数返回值为[m,n]，若不存在这样的m和n（例如整个数组是有序的），请返回[-1,-1]。

/*
 从前往后遍历，默认是升序，每遍历下一个值，如果大于等于前面的最大值，那就是升序的情况，否则就是逆序了，逆序就要记录此时的索引位置l，直到遍历完毕；
 从后往前遍历，默认是降序，每遍历下一个值，如果小于等于前面的最小值，那就是降序的情况，否则就是升序了，升序就要记录此时的索引位置r，直到遍历完毕；
 遍历完毕，返回【l，r】

 
 */
import UIKit

class PartSortController: BaseViewController {

    let array = [1,2,4,7,10,11,7,12,6,7,16,18,19]
    // [3,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            let sub = self.subSort(self.array)
            logDebug(sub)
        }
    }
    func subSort(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return [-1,-1]
        }
        // 从左向右扫描
        // 记录最大值
        var max = array[0]
        // 最大值位置
        var right = -1
        // 从右向左扫描
        // 记录最小值
        var min = array[array.count - 1]
        // 最小值位置
        var left = -1
        for i in 1..<array.count {
            // 最大值
            let maxCur = array[i]
            if maxCur >= max {
                max = maxCur
            } else {
                right = i
            }
            // 最小值
            let minCur = array[array.count - i - 1]
            if minCur <= min {
                min = minCur
            } else {
                left = array.count - i - 1
            }
        }
        return [left,right]
    }
}
