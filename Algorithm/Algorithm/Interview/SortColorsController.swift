//
//  SortColorsController.swift
//  Algorithm
//
//  Created by cyd on 2021/3/26.
// https://leetcode-cn.com/problems/sort-colors/
// https://juejin.cn/post/6844904118100688904#heading-1

/**
 给定一个包含红色、白色和蓝色，一共 n 个元素的数组，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。

 此题中，我们使用整数 0、 1 和 2 分别表示红色、白色和蓝色。
 
 进阶：

 你可以不使用代码库中的排序函数来解决这道题吗？
 你能想出一个仅使用常数空间的一趟扫描算法吗？

 */

import UIKit

class SortColorsController: BaseViewController {

    var nums = [2,0,2,1,1,0]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logDebug("排序前")
        logDebug(self.nums)
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            self.sortColors(&self.nums)
            logDebug("排序后")
            logDebug(self.nums)
        }
    }
    func sortColors(_ nums: inout [Int]) {
        let onePointer = 0
        let twoPointer = 0
        let threePointer = 0
        
    }
    func swap(nums: [Int], i: Int, j: Int) {
        var nums = nums
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
}
